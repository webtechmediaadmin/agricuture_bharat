import 'package:agriculter_bharat/services/auth_services.dart';
import 'package:agriculter_bharat/services/categories_services.dart';
import 'package:agriculter_bharat/view/login/otp_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'common/color_extension.dart';
import 'services/all_products_services.dart';
import 'services/banner_services.dart';
import 'services/sub_categories_services.dart';
import 'view/bottom_nav_bar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: TColor.bg, // Change this to any color you want
      statusBarIconBrightness: Brightness.dark, // Brightness.light for dark icons on light background, vice versa
    ));
    return GetMaterialApp(
      title: 'Agricultre Bharat',
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
      }),
      home: const BottomNavBar(),
     
    );
  }
}
