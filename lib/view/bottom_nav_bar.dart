import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'package:agriculter_bharat/widget/custom_drawer.dart';

import '../common/color_extension.dart';
import '../services/cart_services.dart';
import 'add_to_cart.dart';
import 'home_screen.dart';
import 'profile_screen.dart';
import 'search_screen.dart';

class BottomNavBar extends StatefulWidget {
   int selectedIndex = 0;
  BottomNavBar({
    Key? key,
    required this.selectedIndex,
  }) : super(key: key);

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
 
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final CartController addToCartController = Get.find();

  static const List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    AddToCart(),
    SearchScreen(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      widget.selectedIndex = index;
    });
  }

  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Color(0xff4B844D), // Change this to any color you want
      statusBarIconBrightness: Brightness
          .light, // Brightness.light for dark icons on light background, vice versa
    ));
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          // leading: IconButton(
          //   icon: const Icon(
          //     Icons.menu_rounded,
          //     color: Colors.black,
          //   ),
          //   onPressed: () {
          //     print("drawer...");
          //     _scaffoldKey.currentState?.openDrawer();
          //   },
          // ),
          backgroundColor: Color(0xff4B844D),
          centerTitle: true,
          // title: Text(
          //   "Agriculture Bharat",
          //   style: TextStyle(
          //       color: TColor.primaryText,
          //       fontSize: 25,
          //       fontWeight: FontWeight.w800),
          // ),
          // title: _selectedIndex != 3 ? Image.asset(
          //   "assets/images/logo.png",
          //   height: 50,
          // ) : const Text("Profile"),
          actions: widget.selectedIndex == 0 || widget.selectedIndex == 1
              ? [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Stack(
                      children: [
                        Icon(
                          Icons.shopping_bag_outlined,
                          size: 30,
                          color: TColor.bg,
                        ),
                        // Show count only if items are in the cart
                        if (addToCartController.fetchCartModel != null &&
                            addToCartController.fetchCartModel?.count != null &&
                            addToCartController.fetchCartModel!.count! > 0)
                          Positioned(
                            right: 7,
                            top: 9,
                            child: Container(
                              padding: EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              constraints: BoxConstraints(
                                minWidth: 16,
                                minHeight: 16,
                              ),
                              child: Text(
                                '${addToCartController.fetchCartModel?.count ?? 0}',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ]
              : [
                Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: Image.asset("assets/images/edit.png", width: 25, height: 25,),
                )
              ],
        ),
       // drawer: const CustomDrawer(),
        body: Stack(
          children: [
            _widgetOptions[widget.selectedIndex],
            Positioned(
              bottom: MediaQuery.of(context).padding.bottom -15,
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Theme(
                  data: Theme.of(context).copyWith(
                    canvasColor: Colors
                        .transparent, // Set the background color to transparent
                  ),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color(0xFF70CB74),
                          Color(0xFF354F33)
                        ], // Example gradient colors
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: BottomNavigationBar(
                      backgroundColor: Colors.transparent,
                      items: const <BottomNavigationBarItem>[
                        BottomNavigationBarItem(
                          icon: Icon(Icons.home),
                          label: 'Home',
                        ),
                        BottomNavigationBarItem(
                          icon: Icon(Icons.shopping_cart),
                          label: 'Cart',
                        ),
                        BottomNavigationBarItem(
                          icon: Icon(Icons.search),
                          label: 'Search',
                        ),
                        BottomNavigationBarItem(
                          icon: Icon(Icons.person),
                          label: 'Profile',
                        ),
                      ],
                      currentIndex: widget.selectedIndex,
                      selectedItemColor: Colors.black,
                      unselectedItemColor: Colors.white,
                      onTap: _onItemTapped,
                      elevation: 0,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
