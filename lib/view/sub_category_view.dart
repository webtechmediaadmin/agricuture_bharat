import 'package:agriculter_bharat/common/color_extension.dart';
import 'package:agriculter_bharat/services/sub_categories_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../api_routes/api_routes.dart';
import 'all_product_screen.dart';

class SubCategoryView extends StatefulWidget {
  final String id;
  final String textTitle;
  const SubCategoryView({super.key, required this.id, required this.textTitle});

  @override
  State<SubCategoryView> createState() => _SubCategoryViewState();
}

class _SubCategoryViewState extends State<SubCategoryView> {
  final SubCategoryController subCategoryController = Get.find();

  @override
  void initState() {
    // TODO: implement initState
    subCategoryController.fetchCategory(widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColor.bg,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          widget.textTitle,
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
            Navigator.pop(context); // Handles navigation to previous route
          },
        ),
      ),
      body: Obx(
        () => ListView.builder(
          itemCount: subCategoryController.categoryDataList.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 5),
              child: Card(
                elevation: 0,
                color: Colors.blueGrey.withOpacity(0.3),
                child: ListTile(
                  title: Text(
                    subCategoryController.categoryDataList[index].title!,
                    style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 20),
                  ),
                  subtitle: const Text(
                    'View Products',
                    style:
                        TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
                  ),
                  leading: Image.network(
                    subCategoryController.categoryDataList[index].image !=
                            null
                        ? (ApiRoutes.baseUrl +
                            subCategoryController
                                .categoryDataList[index].image!)
                        : "No Images Found",
                    fit: BoxFit.cover,
                  ),
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                    size: 15,
                    color: Colors.black,
                    weight: 800,
                  ),
                  onTap: () {
                     Navigator.push(context,
                  MaterialPageRoute(builder: (_) => AllProductsView(
                    id: subCategoryController.categoryDataList[index].id!,
                    text: subCategoryController.categoryDataList[index].title!,
                  )));
             
                    // Handle onTap
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
