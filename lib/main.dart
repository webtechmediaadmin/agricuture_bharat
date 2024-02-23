import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'common/color_extension.dart';
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
    return MaterialApp(
      title: 'Agricultre Bharat',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: TColor.bg,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        appBarTheme: const AppBarTheme(
          elevation: 0,
          backgroundColor: Colors.transparent
        ),
        useMaterial3: true,
      ),
      home: const BottomNavBar(),
    );
  }
}
