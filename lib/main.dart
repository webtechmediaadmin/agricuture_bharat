import 'package:agriculter_bharat/services/auth_services.dart';
import 'package:agriculter_bharat/services/categories_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'common/color_extension.dart';
import 'services/address_services.dart';
import 'services/all_products_services.dart';
import 'services/banner_services.dart';
import 'services/cart_services.dart';
import 'services/place_order_service.dart';
import 'services/sub_categories_services.dart';
import 'view/bottom_nav_bar.dart';
import 'view/splash.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: TColor.bg, 
      statusBarIconBrightness: Brightness.dark, 
    ));
    return GetMaterialApp(
      title: 'Agriculture Bharat',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: TColor.bg,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        appBarTheme:  AppBarTheme(
          elevation: 0,
          backgroundColor: TColor.bg
        ),
        useMaterial3: false,
      ),
      initialBinding: BindingsBuilder(() {
        Get.put(BannerController());
        Get.put(CategoryController());
        Get.put(SubCategoryController());
        Get.put(AllProductsController());
        Get.put(AuthController());
        Get.put(CartController());
        Get.put(AddressController());
        Get.put(PlaceOrderController());
      }),
      home: const SplashScreen(),
      getPages: [
            GetPage(name: '/bottomNavbar', page: () => BottomNavBar()),
      ],
     
    );
  }
}
