import 'package:agriculter_bharat/constant/constant.dart';
import 'package:agriculter_bharat/view/login/otp_view.dart';
import 'package:agriculter_bharat/view/payment_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:html/parser.dart' as htmlParser;
import 'package:html/dom.dart' as htmlDom;
import '../api_routes/api_routes.dart';
import '../common/color_extension.dart';
import '../constant/app_preferences.dart';
import '../constant/helper.dart';
import '../services/all_products_services.dart';
import '../services/auth_services.dart';
import '../services/cart_services.dart';

class ProductDetailScreen extends StatefulWidget {
  final String id;
  final String text;
  const ProductDetailScreen({super.key, required this.id, required this.text});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  final AllProductsController allProductsDetailsController = Get.find();
  final AuthController authController = Get.find();
  final CartController addToCartController = Get.find();
  PageController _pageController = PageController();
  final RxInt _currentPage = 0.obs;
  final TextEditingController? _phoneNumberController = TextEditingController();
  FocusNode _phoneNumberFocusNode = FocusNode();
  String otp = "";

  @override
  void dispose() {
    // _phoneNumberController.dispose();
    _phoneNumberFocusNode.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    allProductsDetailsController
        .fetchAllProductsDetails(widget.id)
        .then((_) => priceSaving());
    _pageController = PageController(initialPage: _currentPage.value);
    print("ID ${widget.id}");
    _phoneNumberController!.text;
    super.initState();
  }

  void priceSaving() {
    double actualPrice = double.tryParse(allProductsDetailsController
                .allProductDetailModel.value.data?.first.price ??
            '0.0') ??
        0.0;
    int discountedPrice = allProductsDetailsController
            .allProductDetailModel.value.data?.first.discountPercent ??
        0;

    if (actualPrice != null && discountedPrice != null) {
      allProductsDetailsController.savePrice.value =
          actualPrice * discountedPrice / 100;

      print("save Price ${allProductsDetailsController.savePrice}");
    }
  }

  void tableFormat() {
    final htmlDom.Document document = htmlParser.parse(
        allProductsDetailsController.allProductDetailModel.value.data!
            .map((element) => element.description.toString())
            .join(" "));

    // Retrieve and display product description
    final htmlDom.Element? productDescriptionElement = document
        .querySelector('h2'); // Selecting the h2 tag for product description
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
        row.querySelectorAll('td').forEach((htmlDom.Element cell) {
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
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          actions: [
            IconButton(
              icon: Icon(Icons.share, color: TColor.bg),
              onPressed: () {
                print("share..");
                Share.share('check out my website https://example.com',
                    subject: 'Look what I made!');
              },
            ),
          ],
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: TColor.bg),
            onPressed: () {
              Navigator.pop(context); // Handles navigation to previous route
            },
          ),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xff4B844D),
                  Color(0xff111E12),
                ],
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25),
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Image.asset(
              'assets/images/png.png', // Replace with your SVG image path
              fit: BoxFit.cover,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
            ),
            Padding(
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
                    () => Container(
                      height: 300,
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
                                  fit: BoxFit.fill,
                                  height: 300,
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
                    height: 10,
                  ),
                  Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RatingBar.builder(
                        initialRating: 0,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemSize: 25,
                        itemPadding: const EdgeInsets.symmetric(horizontal: 0),
                        itemBuilder: (context, _) => const Icon(
                          Icons.star,
                          color: Color(0xff579858),
                          size: 10.0,
                        ),
                        onRatingUpdate: (rating) {
                          print(rating);
                        },
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
                                  fontSize:
                                      18.0, // Change font size for "Price"
                                  color: Colors.black.withOpacity(
                                      0.7), // Change color for "Price"
                                ),
                              ),
                              TextSpan(
                                text:
                                    "${allProductsDetailsController.allProductDetailModel.value.data?.first.price} /-  ",
                                style: const TextStyle(
                                    fontSize:
                                        18.0, // Change font size for "180"
                                    color:
                                        Colors.black, // Change color for "180"
                                    fontWeight: FontWeight.w600),
                              ),
                              TextSpan(
                                text:
                                    "${allProductsDetailsController.allProductDetailModel.value.data?.first.discountedPrice} /-",
                                style: const TextStyle(
                                    fontSize:
                                        12.0, 
                                    decoration: TextDecoration.lineThrough,    // Change font size for "180"
                                    color:
                                        Colors.grey, // Change color for "180"
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                       Text(
                    widget.text,
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.w600),
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
                                  fontSize: 12.0, // Change font size for "Price"
                                  color: Colors.black
                                      .withOpacity(0.7), // Change color for "Price"
                                ),
                              ),
                              TextSpan(
                                text:
                                    '${allProductsDetailsController.savePrice.value.toStringAsFixed(2)} /-   ',
                                style: const TextStyle(
                                    fontSize: 12.0, // Change font size for "180"
                                    color: Colors.red, // Change color for "180"
                                    fontWeight: FontWeight.w600),
                              ),
                              TextSpan(
                                text:
                                    '${allProductsDetailsController.allProductDetailModel.value.data?.first.discountPercent}% OFF',
                                style: const TextStyle(
                                    fontSize: 18.0, // Change font size for "180"
                                    color: Colors.green, // Change color for "180"
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  // const SizedBox(
                  //   height: 5,
                  // ),
                  // const Text(
                  //   "inclusive of all taxes",
                  //   style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                  // ),
                  // const SizedBox(
                  //   height: 5,
                  // ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     Container(
                  //       padding: const EdgeInsets.all(10),
                  //       decoration: BoxDecoration(
                  //           color: Colors.green[50],
                  //           borderRadius: BorderRadius.circular(3),
                  //           border:
                  //               Border.all(color: Colors.green, width: 0.5)),
                  //       child: const Center(
                  //         child: Text(
                  //           "SKU:.S_1030",
                  //           style: TextStyle(
                  //               fontSize: 18, fontWeight: FontWeight.w600),
                  //         ),
                  //       ),
                  //     ),
                  //     Obx(
                  //       () => Text(
                  //         "Deal Price:. ${allProductsDetailsController.allProductDetailModel.value.data?.first.discountedPrice} /-",
                  //         style: const TextStyle(
                  //             fontSize: 20,
                  //             fontWeight: FontWeight.w600,
                  //             color: Colors.green),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  // const SizedBox(height: 10),
                  // RichText(
                  //   text: TextSpan(
                  //     style: TextStyle(
                  //       fontSize: 16.0,
                  //       color: Colors.black,
                  //     ),
                  //     children: <TextSpan>[
                  //       TextSpan(
                  //         text: 'FREE delivery: ',
                  //         style: TextStyle(
                  //           fontSize: 16.0, // Change font size for "Price"
                  //           color: Colors.black
                  //               .withOpacity(0.7), // Change color for "Price"
                  //         ),
                  //       ),
                  //       TextSpan(
                  //         text: 'Thursday, 29 February 2024',
                  //         style: TextStyle(
                  //             fontSize: 16.0, // Change font size for "180"
                  //             color: Colors.black, // Change color for "180"
                  //             fontWeight: FontWeight.w600),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  // const SizedBox(
                  //   height: 10,
                  // ),
                  // Row(
                  //   children: [
                  //     SizedBox(
                  //       width: 130, // Set your desired width
                  //       height: 40,
                  //       // Set your desired height
                  //       child: TextFormField(
                  //         decoration: InputDecoration(
                  //           contentPadding: const EdgeInsets.all(10),
                  //           hintText:
                  //               "Enter Pincode..", // Adjust content padding as needed
                  //           border: OutlineInputBorder(
                  //             // borderSide: const BorderSide(
                  //             //   color: Colors.red, // Set border color
                  //             //   width: 2.0, // Set border width
                  //             // ),
                  //             borderRadius: BorderRadius.circular(
                  //                 5.0), // Adjust border radius as needed
                  //           ),
                  //           focusedBorder: OutlineInputBorder(
                  //             borderSide: const BorderSide(
                  //               color: Colors.grey, // Border color when focused
                  //               width: 0.5, // Border width when focused
                  //             ),
                  //             borderRadius: BorderRadius.circular(
                  //                 5.0), // Adjust border radius as needed
                  //           ),
                  //           errorBorder: OutlineInputBorder(
                  //             borderSide: const BorderSide(
                  //               color: Colors.grey, // Border color when focused
                  //               width: 0.5,
                  //             ),
                  //             borderRadius: BorderRadius.circular(
                  //                 5.0), // Adjust border radius as needed
                  //           ),
                  //           focusedErrorBorder: OutlineInputBorder(
                  //             borderSide: const BorderSide(
                  //               color: Colors.grey, // Border color when focused
                  //               width: 0.5,
                  //             ),
                  //             borderRadius: BorderRadius.circular(
                  //                 5.0), // Adjust border radius as needed
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //     const SizedBox(
                  //       width: 10,
                  //     ),
                  //     Container(
                  //       padding: const EdgeInsets.all(13),
                  //       decoration: BoxDecoration(
                  //           color: Color.fromARGB(255, 201, 59, 28),
                  //           borderRadius: BorderRadius.circular(5),
                  //           boxShadow: [
                  //             BoxShadow(
                  //               color: Colors.black
                  //                   .withOpacity(0.3), // Shadow color
                  //               spreadRadius: 2, // Spread radius
                  //               blurRadius: 5,
                  //               offset:
                  //                   Offset(0, 1), // Changes position of shadow
                  //             ),
                  //           ]),
                  //       child: const Center(
                  //         child: Text(
                  //           "Check Availability",
                  //           style: TextStyle(
                  //               color: Colors.white,
                  //               fontSize: 14,
                  //               fontWeight: FontWeight.w600),
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  // ),
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
                      style: const TextStyle(
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
                        const TextSpan(
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
                  Container(
                    height: 50,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        MyConstant.myBoolValue =
                            await PreferenceApp().getIsNewUser();
                        print("is new user ${MyConstant.myBoolValue}");
                        MyConstant.userToken =
                            await PreferenceApp().getAccessToken();
                        print("token given ${MyConstant.userToken}");

                        if (MyConstant.myBoolValue == true &&
                            MyConstant.userToken != null) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const PaymentScreen()),
                          );
                        } else {
                          showButtomSheet();
                        }
                      },
                      style: ButtonStyle(
                        elevation: MaterialStateProperty.all<double>(
                            0), // Adjust elevation as needed
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                50), // Adjust border radius as needed
                            // Border color
                          ),
                        ),
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Color(0xff5DA35F)),
                      ),
                      child: Text(
                        'BUY NOW',
                        style: TextStyle(color: TColor.bg, fontSize: 18),
                      ),
                    ),
                  ),
                  const SizedBox(
                      height: 20), // Adding some spacing between buttons
                  Container(
                    height: 50,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        print('Item bought!');
                        print("ID of product ${widget.id}");

                        MyConstant.myBoolValue =
                            await PreferenceApp().getIsNewUser();
                        print("is new user ${MyConstant.myBoolValue}");
                        MyConstant.userToken =
                            await PreferenceApp().getAccessToken();
                        print("token given ${MyConstant.userToken}");

                        if (MyConstant.myBoolValue == true &&
                            MyConstant.userToken != null) {
                          addToCartController.addToCartData(widget.id);
                        } else {
                          showSnackBar("", "Login First!");
                          showButtomSheet();
                        }
                      },
                      style: ButtonStyle(
                        elevation: MaterialStateProperty.all<double>(
                            0), // Adjust elevation as needed
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                50), // Adjust border radius as needed
                            side:
                                BorderSide(color: Colors.green), // Border color
                          ),
                        ),
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                      ),
                      child: const Text('ADD TO CART',
                          style: TextStyle(
                              color: Color(0xff5DA35F), fontSize: 18)),
                    ),
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
                                for (String cell in allProductsDetailsController
                                    .tableData[index])
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: Text(
                                        cell,
                                        style: const TextStyle(
                                            fontSize: 15, color: Colors.black),
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
                  if (allProductsDetailsController.productDescription.value !=
                      null)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        allProductsDetailsController.productDescription.value,
                        style:
                            const TextStyle(fontSize: 15, color: Colors.black),
                      ),
                    )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showButtomSheet() {
    showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext context) {
        Future.delayed(const Duration(milliseconds: 200), () {
          FocusScope.of(context).requestFocus(_phoneNumberFocusNode);
        });

        return GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    child: SizedBox(
                      child: IconButton(
                        onPressed: () {
                          Navigator.pop(context); // Close the bottom sheet
                        },
                        icon: const Icon(
                          Icons.cancel,
                          color: Colors.white,
                          size: 40,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.0),
                        topRight: Radius.circular(20.0),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 20),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            "Log in or sign up",
                            style: TextStyle(
                                letterSpacing: 1,
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.w800),
                          ),
                          const SizedBox(height: 20),
                          Container(
                            width: MediaQuery.of(context)
                                .size
                                .width, // Set your desired width
                            child: TextFormField(
                              keyboardType: TextInputType.phone,
                              focusNode: _phoneNumberFocusNode,
                              controller: _phoneNumberController,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.all(10),
                                hintText: "Enter mobile number",
                                prefixText: "+91",
                                prefixStyle: const TextStyle(
                                    color: Colors.black, fontSize: 16),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(
                                      10), // Adjust border radius as needed
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Colors
                                        .grey, // Border color when focused
                                    width: 0.5, // Border width when focused
                                  ),
                                  borderRadius: BorderRadius.circular(
                                      5.0), // Adjust border radius as needed
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Colors
                                        .grey, // Border color when focused
                                    width: 0.5,
                                  ),
                                  borderRadius: BorderRadius.circular(
                                      5.0), // Adjust border radius as needed
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Colors
                                        .grey, // Border color when focused
                                    width: 0.5,
                                  ),
                                  borderRadius: BorderRadius.circular(
                                      5.0), // Adjust border radius as needed
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 16.0),
                          Obx(
                            () => authController.isLoading.value
                                ? const CircularProgressIndicator()
                                : ElevatedButton(
                                    onPressed: () async {
                                      // Handle submission here
                                      String phoneNumber =
                                          _phoneNumberController != null
                                              ? _phoneNumberController!.text
                                              : "";

                                      print(
                                          'Submitted Phone Number: $phoneNumber');
                                      _phoneNumberFocusNode.unfocus();
                                      Navigator.pop(context);

                                      // if (_phoneNumberController == null ||
                                      //     _phoneNumberFocusNode == null ||
                                      //     authController == null) {
                                      //   print(
                                      //       'Error: One or more controllers are null');
                                      //   // Handle the case where one of the controllers or authController is null
                                      //   return;
                                      // }

                                      final mobileValidation =
                                          isValidPhoneNumber(phoneNumber);

                                      if (phoneNumber == "") {
                                        showSnackBar(
                                            "", "Please enter mobile number");
                                      } else if (phoneNumber.length < 10) {
                                        showSnackBar("",
                                            "Mobile number must have 10 digits");
                                      } else if (mobileValidation == false) {
                                        showSnackBar(
                                            "", "Invalid mobile number");
                                      } else {
                                        print("Tapped button");
                                        try {
                                          await authController
                                              .loginUser(phoneNumber)
                                              .then((value) async {
                                            MyConstant.mobileNumber =
                                                phoneNumber;
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => OTPView(
                                                    callback: showButtomSheet),
                                              ),
                                            );
                                          });
                                        } catch (e) {
                                          print('Error: $e');
                                          showSnackBar(
                                              "", "Error sending OTP: $e");
                                        }
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      minimumSize:
                                          const Size(double.infinity, 50),
                                      backgroundColor: const Color.fromARGB(255,
                                          58, 57, 49), // Color for Buy button
                                    ),
                                    child: const Text(
                                      'Continue',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 18),
                                    ),
                                  ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
