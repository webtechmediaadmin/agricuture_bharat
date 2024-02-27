import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../api_routes/api_routes.dart';
import '../services/all_products_services.dart';

class AllProductsView extends StatefulWidget {
  final String id;
  final String text;
  const AllProductsView({Key? key, required this.id, required this.text}) : super(key: key);

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
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          widget.text,
          style: const TextStyle(color: Colors.black),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.black),
            onPressed: () {},
          ),
        ],
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Obx(
          () => GridView.count(
            scrollDirection: Axis.vertical,
            shrinkWrap: true, // Disable GridView's scrolling
            crossAxisCount: 2,
            mainAxisSpacing: 20.0,
            children: List.generate( allProductsController.allProductDataList
                                        .length, (index) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      height: 200,
                      color: Colors.white,
                      child: Card(
                        elevation: 5,
                        shadowColor: Colors.grey.withOpacity(1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: Image.network(
                              allProductsController.allProductDataList
                                        [index].image !=
                                      null
                                  ? (ApiRoutes.baseUrl +
                                       allProductsController.allProductDataList
                                        [index].logo.toString())
                                  : "No Images Found",
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    allProductsController.allProductDataList
                                        [index].title.toString(),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Price: ${allProductsController.allProductDataList
                                        [index].price.toString()}',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[700],
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Quantity:  ${allProductsController.allProductDataList
                                        [index].quantity.toString()}',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.green,
                    ),
                  ),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}
