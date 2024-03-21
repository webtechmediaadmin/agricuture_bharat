import 'package:flutter/material.dart';

class ResponsiveWidget extends StatelessWidget {
  final Widget mobile;
  final Widget desktop;

  const ResponsiveWidget(
      {Key? key, required this.mobile, required this.desktop})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth < 1200) {
        //Portrait
        return mobile;
      } else {
        return desktop;
      }
    });
  }
}

bool isMobile(BuildContext context) {
  var width = MediaQuery.of(context).size.width;
  if (width > 600) {
    return false;
  }
  return true;
}

bool isSmallScreenMobile(BuildContext context) {
  var height = MediaQuery.of(context).size.height;
  if (height > 500) {
    return false;
  }
  return true;
}
