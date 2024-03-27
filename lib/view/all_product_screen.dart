import 'package:agriculter_bharat/view/product_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../api_routes/api_routes.dart';
import '../common/color_extension.dart';
import '../services/all_products_services.dart';

class AllProductsView extends StatefulWidget {
  final String id;
  final String text;
  const AllProductsView({Key? key, required this.id, required this.text})
      : super(key: key);

  @override
  State<AllProductsView> createState() => _AllProductsViewState();
}

class _AllProductsViewState extends State<AllProductsView> {
  final AllProductsController allProductsController = Get.find();

  @override
  void initState() {
    // TODO: implement initState
    allProductsController.fetchAllProducts(widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          centerTitle: true,
          title: Text(
            widget.text,
            style: TextStyle(color: TColor.bg),
          ),

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
            Obx(
              () => Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // Adjust the number of columns as needed
                    crossAxisSpacing: 5.0,
                    mainAxisSpacing: 5.0,
                  ),
                  itemCount: allProductsController.allProductDataList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => ProductDetailScreen(
                                      id: allProductsController
                                          .allProductDataList[index].id!,
                                      text: allProductsController
                                          .allProductDataList[index].title!,
                                    )));
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: TColor.bg,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: const Color(0xff5FA861)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Container(
                                height: 200,
                                color: Colors.white,
                                child: Center(
                                  child: Image.network(
                                    allProductsController
                                                .allProductDataList[index].logo !=
                                            null
                                        ? (ApiRoutes.baseUrl +
                                            allProductsController
                                                .allProductDataList[index].logo
                                                .toString())
                                        : "No Images Found",
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            const Divider(),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    allProductsController
                                        .allProductDataList[index].title
                                        .toString(),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Expanded(
                                  child: Text(
                                    'Price: ${allProductsController.allProductDataList[index].price.toString()}',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey[700],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    'Quantity:  ${allProductsController.allProductDataList[index].quantity.toString()}',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.green,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
