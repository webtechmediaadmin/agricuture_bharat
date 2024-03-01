import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:html/parser.dart' as htmlParser;
import 'package:html/dom.dart' as htmlDom;
import '../api_routes/api_routes.dart';
import '../services/all_products_services.dart';

class ProductDetailScreen extends StatefulWidget {
  final String id;
  final String text;
  const ProductDetailScreen({super.key, required this.id, required this.text});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  final AllProductsController allProductsDetailsController = Get.find();
  PageController _pageController = PageController();
  final RxInt _currentPage = 0.obs;
 

  @override
  void initState() {
    // TODO: implement initState
    allProductsDetailsController.fetchAllProductsDetails(widget.id).then((_) =>priceSaving() );
    _pageController = PageController(initialPage: _currentPage.value);
    print("ID ${widget.id}");
    
    super.initState();
  }

 void priceSaving() {
  double actualPrice = double.tryParse(allProductsDetailsController
      .allProductDetailModel.value.data?.first.price ?? '0.0') ?? 0.0;
  int discountedPrice = allProductsDetailsController
      .allProductDetailModel.value.data?.first.discountPercent ?? 0;

  if (actualPrice != null && discountedPrice != null) {
     allProductsDetailsController.savePrice.value = actualPrice * discountedPrice / 100;
     
    print("save Price ${allProductsDetailsController.savePrice}");
  } 
}



  void tableFormat() {
    final htmlDom.Document document = htmlParser.parse(
        allProductsDetailsController.allProductDetailModel.value.data!
            .map((element) => element.description.toString())
            .join(" "));
    
    // Retrieve and display product description
    final htmlDom.Element? productDescriptionElement =
        document.querySelector('h2'); // Selecting the h2 tag for product description
    if (productDescriptionElement != null) {
      allProductsDetailsController.productDescription.value =
          productDescriptionElement.text.trim();
    }

    // Retrieve and display table data
    final htmlDom.Element? table = document.querySelector('table');
    if (table != null) {
      final List<List<String>> tableData = [];
      table.querySelectorAll('tr').forEach((htmlDom.Element row) {
        final List<String> rowData = [];
        row.querySelectorAll('td').forEach((htmlDom.Element cell){
          rowData.add(cell.text);
        });

        tableData.add(rowData);
      });

      allProductsDetailsController.tableData.value = tableData;
    }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () {
            print(";;;;;;");
            Navigator.pop(context); // Handles navigation to previous route
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.share, color: Colors.black),
            onPressed: () {
              print("share..");
              Share.share('check out my website https://example.com',
                  subject: 'Look what I made!');
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Product Inforamtion",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                widget.text,
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                    fontWeight: FontWeight.w400),
              ),
              const SizedBox(
                height: 5,
              ),
              Obx(
                () => SizedBox(
                  height: 200,
                  child: PageView.builder(
                    controller: _pageController,
                    onPageChanged: (index) {
                      setState(() {
                        _currentPage.value = index;
                      });
                    },
                    itemCount: allProductsDetailsController
                            .allProductDetailModel.value.data?.length ??
                        0,
                    itemBuilder: (context, productIndex) {
                      var product = allProductsDetailsController
                          .allProductDetailModel.value.data![productIndex];

                      // Preload images
                      for (var imageUrl in product.image ?? []) {
                        precacheImage(
                            NetworkImage(ApiRoutes.baseUrl + imageUrl),
                            context);
                      }

                      return PageView.builder(
                        itemCount: product.image?.length ?? 0,
                        itemBuilder: (context, imageIndex) {
                          var imageUrl = product.image?[imageIndex];
                          if (imageUrl != null && imageUrl.isNotEmpty) {
                            return Image.network(
                              ApiRoutes.baseUrl + imageUrl,
                              fit: BoxFit.contain,
                            );
                          } else {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        },
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Obx(
                () => RichText(
                  text: TextSpan(
                    style: const TextStyle(
                      fontSize: 16.0,
                      color: Colors.black,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Price: ',
                        style: TextStyle(
                          fontSize: 18.0, // Change font size for "Price"
                          color: Colors.black
                              .withOpacity(0.7), // Change color for "Price"
                        ),
                      ),
                      TextSpan(
                        text:
                            "${allProductsDetailsController.allProductDetailModel.value.data?.first.price} /-",
                        style: const TextStyle(
                            fontSize: 18.0, // Change font size for "180"
                            color: Colors.black, // Change color for "180"
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Obx(
                () => RichText(
                  text: TextSpan(
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.black,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: 'You Save: ',
                        style: TextStyle(
                          fontSize: 18.0, // Change font size for "Price"
                          color: Colors.black
                              .withOpacity(0.7), // Change color for "Price"
                        ),
                      ),
                      TextSpan(
                        text: '${allProductsDetailsController.savePrice.value.toStringAsFixed(2)} /-   ',
                        style: TextStyle(
                            fontSize: 18.0, // Change font size for "180"
                            color: Colors.red, // Change color for "180"
                            fontWeight: FontWeight.w600),
                      ),
                      TextSpan(
                        text:
                            '(${allProductsDetailsController.allProductDetailModel.value.data?.first.discountPercent}% OFF)',
                        style: TextStyle(
                            fontSize: 18.0, // Change font size for "180"
                            color: Colors.green, // Change color for "180"
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              const Text(
                "inclusive of all taxes",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.green[50],
                        borderRadius: BorderRadius.circular(3),
                        border: Border.all(color: Colors.green, width: 0.5)),
                    child: const Center(
                      child: Text(
                        "SKU:.S_1030",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  Obx(
                    () => Text(
                      "Deal Price:. ${allProductsDetailsController.allProductDetailModel.value.data?.first.discountedPrice} /-",
                      style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.green),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              RichText(
                text: TextSpan(
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.black,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: 'FREE delivery: ',
                      style: TextStyle(
                        fontSize: 16.0, // Change font size for "Price"
                        color: Colors.black
                            .withOpacity(0.7), // Change color for "Price"
                      ),
                    ),
                    TextSpan(
                      text: 'Thursday, 29 February 2024',
                      style: TextStyle(
                          fontSize: 16.0, // Change font size for "180"
                          color: Colors.black, // Change color for "180"
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Container(
                    width: 130, // Set your desired width
                    height: 40,
                    // Set your desired height
                    child: TextFormField(
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(10),
                        hintText:
                            "Enter Pincode..", // Adjust content padding as needed
                        border: OutlineInputBorder(
                          // borderSide: const BorderSide(
                          //   color: Colors.red, // Set border color
                          //   width: 2.0, // Set border width
                          // ),
                          borderRadius: BorderRadius.circular(
                              5.0), // Adjust border radius as needed
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.grey, // Border color when focused
                            width: 0.5, // Border width when focused
                          ),
                          borderRadius: BorderRadius.circular(
                              5.0), // Adjust border radius as needed
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.grey, // Border color when focused
                            width: 0.5,
                          ),
                          borderRadius: BorderRadius.circular(
                              5.0), // Adjust border radius as needed
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.grey, // Border color when focused
                            width: 0.5,
                          ),
                          borderRadius: BorderRadius.circular(
                              5.0), // Adjust border radius as needed
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Container(
                    padding: const EdgeInsets.all(13),
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 201, 59, 28),
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: [
                          BoxShadow(
                            color:
                                Colors.black.withOpacity(0.3), // Shadow color
                            spreadRadius: 2, // Spread radius
                            blurRadius: 5,
                            offset: Offset(0, 1), // Changes position of shadow
                          ),
                        ]),
                    child: const Center(
                      child: Text(
                        "Check Availability",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "In Stock.",
                style: TextStyle(
                    color: Colors.green,
                    fontSize: 18,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 10,
              ),
              RichText(
                text: TextSpan(
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.black,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Sold by ',
                      style: TextStyle(
                        fontSize: 16.0, // Change font size for "Price"
                        color: Colors.black
                            .withOpacity(0.7), // Change color for "Price"
                      ),
                    ),
                    TextSpan(
                      text: 'Agriculture Bharat',
                      style: TextStyle(
                          fontSize: 16.0, // Change font size for "180"
                          color: Colors.black, // Change color for "180"
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  print('Item bought!');
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50), // Full width
                  primary:
                      Color.fromARGB(255, 235, 208, 6), // Color for Buy button
                ),
                child: const Text(
                  'Buy Now',
                  style: TextStyle(color: Colors.black, fontSize: 18),
                ),
              ),
              const SizedBox(height: 20), // Adding some spacing between buttons
              ElevatedButton(
                onPressed: () {
                  print('Item bought!');
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  primary: Colors.yellow,
                ),
                child: const Text('Add to Cart',
                    style: TextStyle(color: Colors.black, fontSize: 18)),
              ),
              const SizedBox(height: 20),
              const Text(
                "Product Details",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
              if (allProductsDetailsController.tableData.isNotEmpty)
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  //  itemCount: tableData.length,
                  itemCount: allProductsDetailsController.tableData.length,
                  itemBuilder: (context, index) {
                    return Container(
                      color: index.isEven
                          ? Colors.grey.withOpacity(0.3)
                          : Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            for (String cell
                                in allProductsDetailsController.tableData[index])
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Text(
                                    cell,
                                    style: const TextStyle(
                                        fontSize: 15,
                                        color: Colors.black),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              Divider(
                thickness: 0.5,
                color: Colors.black.withOpacity(0.1),
              ),
              if (allProductsDetailsController.productDescription.value != null)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    allProductsDetailsController.productDescription.value,
                    style: const TextStyle(
                        fontSize: 15, color: Colors.black),
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}