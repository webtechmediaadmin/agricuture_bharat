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
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          centerTitle: true,
          title: Text(
            widget.textTitle,
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
      body: Stack(
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
                  crossAxisCount: 3, // Adjust the number of columns as needed
                  crossAxisSpacing: 5.0,
                  mainAxisSpacing: 5.0,
                ),
                itemCount: subCategoryController.categoryDataList.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 3, horizontal: 5),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => AllProductsView(
                                      id: subCategoryController
                                          .categoryDataList[index].id!,
                                      text: subCategoryController
                                          .categoryDataList[index].title!,
                                    )));
            
                        // Handle onTap
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: TColor.bg,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: const Color(0xff5FA861)),
                        ),
                        child: Column(
                          children: [
                            Expanded(
                              flex: 3,
                              child: SizedBox(
                                height: 120,
                                child: Image.network(
                                  subCategoryController
                                              .categoryDataList[index].image !=
                                          null
                                      ? (ApiRoutes.baseUrl +
                                          subCategoryController
                                              .categoryDataList[index].image!)
                                      : "No Images Found",
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                width: double.infinity, // Take full width
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(
                                        9), // Adjust the radius as needed
                                    bottomRight: Radius.circular(
                                        9), // Adjust the radius as needed
                                  ),
                                  gradient: LinearGradient(
                                    colors: [
                                      Color(0xFF60A962),
                                      Color(0xFF264327)
                                    ], // Define your gradient colors
                                    begin: Alignment
                                        .topLeft, // Define your gradient begin point
                                    end: Alignment
                                        .bottomRight, // Define your gradient end point
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    subCategoryController
                                        .categoryDataList[index].title!,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.center,
                                    style:
                                        TextStyle(color: TColor.bg, fontSize: 12),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
