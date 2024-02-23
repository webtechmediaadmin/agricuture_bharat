import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../api_routes/api_routes.dart';
import '../common/color_extension.dart';
import '../services/banner_services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final BannerController bannerController = Get.find();
  PageController _pageController = PageController();
  final RxInt _currentPage = 0.obs;
  //Timer? _timer;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentPage.value);
    bannerController.fetchBanners();

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
    return SafeArea(
      child: Scaffold(
        backgroundColor: TColor.bg,
        drawer: const Drawer(),
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Agriculture Bharat",
            style: TextStyle(
                color: TColor.primaryText,
                fontSize: 25,
                fontWeight: FontWeight.w800),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                Icons.shopping_bag_outlined,
                size: 25,
                color: TColor.primaryText,
              ),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(
                  ()=> Center(
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
                           (ApiRoutes.baseUrl +
                                    bannerController
                                        .bannerDataList[index].image!) ??
                                "No Bannner Available",
                          
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
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      crossAxisSpacing: 4.0,
                      mainAxisSpacing: 8.0,
                    ),
                    itemCount: 12,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        width: 70,
                        height: 100,
                        // Adjust the height as per your need
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment
                              .center, // Center content vertically
                          children: [
                            Container(
                              width: 70,
                              height: 70,
                              decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(35),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 1,
                                      blurRadius: 4,
                                      offset: const Offset(
                                          2, 3), // changes position of shadow
                                    ),
                                  ]),
                              child: Center(
                                child: ClipOval(
                                  child: Image.network(
                                    'https://media.istockphoto.com/id/1380361370/photo/decorative-banana-plant-in-concrete-vase-isolated-on-white-background.jpg?s=2048x2048&w=is&k=20&c=Q9VRph8N8d9d7sfb2eB7uf-DQgGGFbZPJu5Zdwm3fzg=',
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                                height:
                                    5), // Add spacing between the Container and Text
                            Flexible(
                              // Use Flexible to allow text to wrap
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 4.0),
                                child: Text(
                                  'Item $index',
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(color: Colors.black),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2, // Adjust max lines as per your need
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
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
