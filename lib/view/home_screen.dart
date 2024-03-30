import 'dart:async';

import 'package:agriculter_bharat/services/categories_services.dart';
import 'package:agriculter_bharat/view/sub_category_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../api_routes/api_routes.dart';
import '../common/color_extension.dart';
import '../constant/constant.dart';
import '../services/banner_services.dart';
import 'utility/Responsive_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final BannerController bannerController = Get.find();
  final CategoryController categoryController = Get.find();
  PageController _pageController = PageController();
  final RxInt _currentPage = 0.obs;
  //Timer? _timer;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentPage.value);
    bannerController.fetchBanners();
    categoryController.fetchCategory();
    ConstFunction().getValues();
    // Start autoplay when widget is initialized
    startAutoPlay();
  }

  @override
  void dispose() {
    // Dispose timer and page controller to prevent memory leaks
    // _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void startAutoPlay() {
    // Start a timer to change page every 3 seconds
    Future.delayed(const Duration(seconds: 5), () {
      if (_pageController.hasClients) {
        if (_currentPage < bannerController.bannerDataList.length - 1) {
          // Reset to the first image if we reach the end
          _pageController.nextPage(
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
        } else {
          _pageController.jumpToPage(0);
        }
        if (mounted) {
          startAutoPlay();
        }
      }
    });
  }

  // Sample image list
  final List<String> imageList = [
    'https://media.istockphoto.com/id/1380361370/photo/decorative-banana-plant-in-concrete-vase-isolated-on-white-background.jpg?s=2048x2048&w=is&k=20&c=Q9VRph8N8d9d7sfb2eB7uf-DQgGGFbZPJu5Zdwm3fzg=',
    'https://as1.ftcdn.net/v2/jpg/03/40/37/62/1000_F_340376293_8KKAtyMn6badZqrCMRajj576ckJoz7Tx.jpg',
    'https://as1.ftcdn.net/v2/jpg/03/83/43/00/1000_F_383430016_lzX8FHsxfKaV6nKW22TQ08idxuBXKU3v.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
      mobile: Scaffold(
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(100),
            child: Container(
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
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: GestureDetector(
                  onTap: () {
                    
                  },
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Row(
                      children: [
                        const SizedBox(width: 10),
                        Icon(Icons.search),
                        const SizedBox(
                          width: 10,
                        ),
                        Text("Search Your Product...")
                      ],
                    ),
                  ),
                ),
              ),
            )),
        body: Stack(
          children: [
            Image.asset(
              'assets/images/png.png', // Replace with your SVG image path
              fit: BoxFit.cover,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
            ),
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Obx(
                      () => Center(
                        child: SizedBox(
                          height: 200,
                          child: PageView.builder(
                            controller: _pageController,
                            onPageChanged: (index) {
                              setState(() {
                                _currentPage.value = index;
                              });
                            },
                            itemCount: bannerController.bannerDataList.length,
                            itemBuilder: (context, index) {
                              return Image.network(
                                bannerController.bannerDataList[index].image !=
                                        null
                                    ? (ApiRoutes.baseUrl +
                                        bannerController
                                            .bannerDataList[index].image!)
                                    : "No Banner Available",
                                fit: BoxFit.contain,
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "Shop By Category",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w800),
                    ),
                    const SizedBox(height: 10),
                    Obx(
                      () => Container(
                        height: 110,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: categoryController.categoryDataList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => SubCategoryView(
                                              id: categoryController
                                                  .categoryDataList[index].id!,
                                              textTitle: categoryController
                                                  .categoryDataList[index]
                                                  .title!,
                                            )));
                              },
                              child: Column(
                                children: [
                                  Container(
                                    width: 80,
                                    height: 80,
                                    padding: const EdgeInsets.all(10),
                                    margin: const EdgeInsets.only(
                                        left: 5, right: 10, top: 5),
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Color(0xffFFFFFF),

                                        border: Border.all(color:Colors.grey.withOpacity(0.5)),
                                       
                                        // boxShadow: [
                                        //   BoxShadow(
                                        //     color: Colors.grey.withOpacity(0.5),
                                        //     spreadRadius: 3,
                                        //     blurRadius: 7,
                                        //     offset: const Offset(1,
                                        //         3), // changes position of shadow
                                        //   ),
                                        // ]
                                        ),
                                    child: Image.network(
                                      categoryController.categoryDataList[index]
                                                  .image !=
                                              null
                                          ? (ApiRoutes.baseUrl +
                                              categoryController
                                                  .categoryDataList[index]
                                                  .image!)
                                          : "No Image found",
                                      height: 70,
                                      width: 70,
                                      fit: BoxFit
                                          .contain, // Use BoxFit.cover to fit the image within the circle
                                    ),
                                  ),
                                  const SizedBox(
                                      height:
                                          10), // Add spacing between the Container and Text
                                  Text(
                                    categoryController
                                            .categoryDataList[index].title ??
                                        "",
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w800),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines:
                                        2, // Adjust max lines as per your need
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Best Selling",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w600),
                        ),
                        Text(
                          "View All",
                          style: TextStyle(
                              color: Color(0xff4A814C),
                              fontSize: 14,
                              decoration: TextDecoration.underline,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 170,
                      child: ListView.builder(
                          itemCount: 10,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: Container(
                                    height: 160,
                                    width: 150,
                                    decoration: BoxDecoration(
                                      color: TColor.bg,
                                      borderRadius: BorderRadius.circular(10),

                                      border: Border.all(
                                          color: Colors.grey.withOpacity(0.5)),
                                      // boxShadow: [
                                      //   BoxShadow(
                                      //     color: Colors.grey.withOpacity(0.5),
                                      //     spreadRadius: 1,
                                      //     blurRadius: 4,
                                      //     offset: const Offset(2,
                                      //         3), // changes position of shadow
                                      //   ),
                                      // ]
                                    ),
                                    child: Column(
                                      children: [
                                        Image.network(
                                          'https://media.istockphoto.com/id/1380361370/photo/decorative-banana-plant-in-concrete-vase-isolated-on-white-background.jpg?s=2048x2048&w=is&k=20&c=Q9VRph8N8d9d7sfb2eB7uf-DQgGGFbZPJu5Zdwm3fzg=',
                                          height: 100,
                                          width: 100,
                                        ),
                                        const Divider(),
                                        const Text("Fertilizers(10ml)"),
                                        const SizedBox(height: 5),
                                        const Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              const Text(
                                                "\u20B940",
                                                style: TextStyle(fontSize: 15),
                                              ),
                                              Text(
                                                "\u20B950",
                                                style: TextStyle(
                                                  fontSize: 10,
                                                  decoration: TextDecoration
                                                      .lineThrough,
                                                ),
                                              ),
                                              const Text(
                                                "20%Off",
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    color: Color(0xff579858)),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Deals For You",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w600),
                        ),
                        Text(
                          "View All",
                          style: TextStyle(
                              color: Color(0xff4A814C),
                              fontSize: 14,
                              decoration: TextDecoration.underline,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 350,
                      child: GridView.builder(
                          padding: EdgeInsets.zero,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2, // Number of columns
                            // Spacing along the cross axis
                            // Aspect ratio of each grid item
                          ),
                          itemCount: 4,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                Container(
                                  height: 160,
                                  width: 150,
                                  decoration: BoxDecoration(
                                    color: TColor.bg,
                                    borderRadius: BorderRadius.circular(10),

                                    border: Border.all(
                                        color: Colors.grey.withOpacity(0.5)),

                                    // boxShadow: [
                                    //   BoxShadow(
                                    //     color: Colors.grey.withOpacity(0.5),
                                    //     spreadRadius: 1,
                                    //     blurRadius: 4,
                                    //     offset: const Offset(2,
                                    //         3), // changes position of shadow
                                    //   ),
                                    // ]
                                  ),
                                  child: Column(
                                    children: [
                                      Image.network(
                                        'https://media.istockphoto.com/id/1380361370/photo/decorative-banana-plant-in-concrete-vase-isolated-on-white-background.jpg?s=2048x2048&w=is&k=20&c=Q9VRph8N8d9d7sfb2eB7uf-DQgGGFbZPJu5Zdwm3fzg=',
                                        height: 100,
                                        width: 100,
                                      ),
                                      const Divider(),
                                      const Text("Fertilizers(10ml)"),
                                      const SizedBox(height: 5),
                                      const Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            const Text(
                                              "\u20B940",
                                              style: TextStyle(fontSize: 15),
                                            ),
                                            Text(
                                              "\u20B950",
                                              style: TextStyle(
                                                fontSize: 10,
                                                decoration:
                                                    TextDecoration.lineThrough,
                                              ),
                                            ),
                                            const Text(
                                              "20%Off",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Color(0xff579858)),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          }),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Popular Products",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w600),
                        ),
                        Text(
                          "View All",
                          style: TextStyle(
                              color: Color(0xff4A814C),
                              fontSize: 14,
                              decoration: TextDecoration.underline,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 170,
                      child: ListView.builder(
                          itemCount: 10,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: Container(
                                    height: 160,
                                    width: 150,
                                    decoration: BoxDecoration(
                                      color: TColor.bg,
                                      borderRadius: BorderRadius.circular(10),

                                      border: Border.all(
                                          color: Colors.grey.withOpacity(0.5)),

                                      // boxShadow: [
                                      //   BoxShadow(
                                      //     color: Colors.grey.withOpacity(0.5),
                                      //     spreadRadius: 1,
                                      //     blurRadius: 4,
                                      //     offset: const Offset(2,
                                      //         3), // changes position of shadow
                                      //   ),
                                      // ]
                                    ),
                                    child: Column(
                                      children: [
                                        Image.network(
                                          'https://media.istockphoto.com/id/1380361370/photo/decorative-banana-plant-in-concrete-vase-isolated-on-white-background.jpg?s=2048x2048&w=is&k=20&c=Q9VRph8N8d9d7sfb2eB7uf-DQgGGFbZPJu5Zdwm3fzg=',
                                          height: 100,
                                          width: 100,
                                        ),
                                        const Divider(),
                                        const Text("Fertilizers(10ml)"),
                                        const SizedBox(height: 5),
                                        const Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              const Text(
                                                "\u20B940",
                                                style: TextStyle(fontSize: 15),
                                              ),
                                              Text(
                                                "\u20B950",
                                                style: TextStyle(
                                                  fontSize: 10,
                                                  decoration: TextDecoration
                                                      .lineThrough,
                                                ),
                                              ),
                                              const Text(
                                                "20%Off",
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    color: Color(0xff579858)),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Seasonal",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w600),
                        ),
                        Text(
                          "View All",
                          style: TextStyle(
                              color: Color(0xff4A814C),
                              fontSize: 14,
                              decoration: TextDecoration.underline,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 170,
                      child: ListView.builder(
                          itemCount: 10,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: Container(
                                    height: 160,
                                    width: 150,
                                    decoration: BoxDecoration(
                                        color: TColor.bg,
                                        borderRadius: BorderRadius.circular(10),

                                        border: Border.all(color:Colors.grey.withOpacity(0.5)),
                                       
                                        // boxShadow: [
                                        //   BoxShadow(
                                        //     color: Colors.grey.withOpacity(0.5),
                                        //     spreadRadius: 1,
                                        //     blurRadius: 4,
                                        //     offset: const Offset(2,
                                        //         3), // changes position of shadow
                                        //   ),
                                        // ]
                                        ),
                                    child: Column(
                                      children: [
                                        Image.network(
                                          'https://media.istockphoto.com/id/1380361370/photo/decorative-banana-plant-in-concrete-vase-isolated-on-white-background.jpg?s=2048x2048&w=is&k=20&c=Q9VRph8N8d9d7sfb2eB7uf-DQgGGFbZPJu5Zdwm3fzg=',
                                          height: 100,
                                          width: 100,
                                        ),
                                        const Divider(),
                                        const Text("Fertilizers(10ml)"),
                                        const SizedBox(height: 5),
                                        const Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              const Text(
                                                "\u20B940",
                                                style: TextStyle(fontSize: 15),
                                              ),
                                              Text(
                                                "\u20B950",
                                                style: TextStyle(
                                                  fontSize: 10,
                                                  decoration: TextDecoration
                                                      .lineThrough,
                                                ),
                                              ),
                                              const Text(
                                                "20%Off",
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    color: Color(0xff579858)),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }),
                    ),
                    const SizedBox(height: 80),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      desktop: Scaffold(
        backgroundColor: TColor.bg,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(
                  () => Center(
                    child: SizedBox(
                      height: 200,
                      child: PageView.builder(
                        controller: _pageController,
                        onPageChanged: (index) {
                          setState(() {
                            _currentPage.value = index;
                          });
                        },
                        itemCount: bannerController.bannerDataList.length,
                        itemBuilder: (context, index) {
                          return Image.network(
                            bannerController.bannerDataList[index].image != null
                                ? (ApiRoutes.baseUrl +
                                    bannerController
                                        .bannerDataList[index].image!)
                                : "No Banner Available",
                            fit: BoxFit.contain,
                          );
                        },
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Shop By Category",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w800),
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 3,
                        blurRadius: 7,
                        offset:
                            const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Obx(
                    () => GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        crossAxisSpacing: 4.0,
                        mainAxisSpacing: 10.0,
                      ),
                      itemCount: categoryController.categoryDataList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => SubCategoryView(
                                          id: categoryController
                                              .categoryDataList[index].id!,
                                          textTitle: categoryController
                                              .categoryDataList[index].title!,
                                        )));
                          },
                          child: Column(
                            //mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment
                                .center, // Center content vertically
                            children: [
                              Expanded(
                                flex: 4,
                                child: Container(
                                  width: 60,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(color: Colors.white),
                                      borderRadius: BorderRadius.circular(50),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 3,
                                          blurRadius: 7,
                                          offset: const Offset(1,
                                              3), // changes position of shadow
                                        ),
                                      ]),
                                  child: CircleAvatar(
                                    backgroundColor: Colors
                                        .transparent, // Ensure the background is transparent
                                    child: Image.network(
                                      categoryController.categoryDataList[index]
                                                  .image !=
                                              null
                                          ? (ApiRoutes.baseUrl +
                                              categoryController
                                                  .categoryDataList[index]
                                                  .image!)
                                          : "No Image found",

                                      fit: BoxFit
                                          .fill, // Use BoxFit.cover to fit the image within the circle
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                  height:
                                      5), // Add spacing between the Container and Text
                              Expanded(
                                flex: 2,
                                // Use Flexible to allow text to wrap
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 4.0),
                                  child: Text(
                                    categoryController
                                            .categoryDataList[index].title ??
                                        "",
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w800),
                                    overflow: TextOverflow.ellipsis,

                                    maxLines:
                                        2, // Adjust max lines as per your need
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Discount Offers",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "View All",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                SizedBox(
                  height: 300,
                  child: ListView.builder(
                      itemCount: 10,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: Container(
                                height: 100,
                                width: 90,
                                decoration: BoxDecoration(
                                    color: TColor.bg,
                                    borderRadius: BorderRadius.circular(2),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 1,
                                        blurRadius: 4,
                                        offset: const Offset(
                                            2, 3), // changes position of shadow
                                      ),
                                    ]),
                                child: Image.network(
                                  'https://media.istockphoto.com/id/1380361370/photo/decorative-banana-plant-in-concrete-vase-isolated-on-white-background.jpg?s=2048x2048&w=is&k=20&c=Q9VRph8N8d9d7sfb2eB7uf-DQgGGFbZPJu5Zdwm3fzg=',
                                ),
                              ),
                            ),
                          ],
                        );
                      }),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
