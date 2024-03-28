import 'package:agriculter_bharat/view/bottom_nav_bar.dart';
import 'package:agriculter_bharat/view/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../common/color_extension.dart';
import '../constant/app_preferences.dart';
import '../constant/constant.dart';
import 'myaddress_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    print("TOKEN TAKEN ${MyConstant.access_token}");
    print("TOKEN TAKEN ${MyConstant.myBoolValue}");
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(150),
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
            child: Column(children: [
              Center(
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xffFFFFFF),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.person,
                      size: 80,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                "User Name",
                style: TextStyle(color: Colors.white, fontSize: 15),
              )
            ]),
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
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: Color(0XF4B844D).withOpacity(0.3)),
                          borderRadius: BorderRadius.circular(10)),
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.person_outline_outlined,
                                color: Color(0xff4B844D),
                              ),
                              const SizedBox(width: 15),
                              Text(
                                "Order History",
                                style: TextStyle(
                                    fontSize: 14, color: Color(0xff4B844D)),
                              ),
                            ],
                          ),
                          const Icon(
                            Icons.arrow_forward_ios,
                            size: 12,
                            color: Color(0xff4B844D),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Color(0XF4B844D).withOpacity(0.3)),
                            borderRadius: BorderRadius.circular(10)),
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.wallet_outlined,
                                  color: Color(0xff4B844D),
                                ),
                                const SizedBox(width: 15),
                                Text(
                                  "Payment Settings",
                                  style: TextStyle(
                                      fontSize: 14, color: Color(0xff4B844D)),
                                ),
                              ],
                            ),
                            const Icon(
                              Icons.arrow_forward_ios,
                              size: 12,
                              color: Color(0xff4B844D),
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    if (MyConstant.userToken != null &&
                        MyConstant.myBoolValue == true)
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const MyAddresses()));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Color(0XF4B844D).withOpacity(0.3)),
                              borderRadius: BorderRadius.circular(10)),
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  const Icon(
                                    Icons.location_on_outlined,
                                    color: Color(0xff4B844D),
                                  ),
                                  const SizedBox(width: 15),
                                  Text(
                                    "Saved Addresses",
                                    style: TextStyle(
                                        fontSize: 14, color: Color(0xff4B844D)),
                                  ),
                                ],
                              ),
                              const Icon(
                                Icons.arrow_forward_ios,
                                size: 12,
                                color: Color(0xff4B844D),
                              )
                            ],
                          ),
                        ),
                      ),
                    const SizedBox(height: 10),
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: Color(0XF4B844D).withOpacity(0.3)),
                          borderRadius: BorderRadius.circular(10)),
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.language_outlined,
                                color: Color(0xff4B844D),
                              ),
                              const SizedBox(width: 15),
                              Text(
                                "Select Language",
                                style: TextStyle(
                                    fontSize: 14, color: Color(0xff4B844D)),
                              ),
                            ],
                          ),
                          const Icon(
                            Icons.arrow_forward_ios,
                            size: 12,
                            color: Color(0xff4B844D),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: Color(0XF4B844D).withOpacity(0.3)),
                          borderRadius: BorderRadius.circular(10)),
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.notifications_outlined,
                                color: Color(0xff4B844D),
                              ),
                              const SizedBox(width: 15),
                              Text(
                                "Notification Settings",
                                style: TextStyle(
                                    fontSize: 14, color: Color(0xff4B844D)),
                              ),
                            ],
                          ),
                          const Icon(
                            Icons.arrow_forward_ios,
                            size: 12,
                            color: Color(0xff4B844D),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: Color(0XF4B844D).withOpacity(0.3)),
                          borderRadius: BorderRadius.circular(10)),
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.privacy_tip,
                                color: Color(0xff4B844D),
                              ),
                              const SizedBox(width: 15),
                              Text(
                                "Privacy Policy",
                                style: TextStyle(
                                    fontSize: 14, color: Color(0xff4B844D)),
                              ),
                            ],
                          ),
                          const Icon(
                            Icons.arrow_forward_ios,
                            size: 12,
                            color: Color(0xff4B844D),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: Color(0XF4B844D).withOpacity(0.3)),
                          borderRadius: BorderRadius.circular(10)),
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.info,
                                color: Color(0xff4B844D),
                              ),
                              const SizedBox(width: 15),
                              Text(
                                "About Us",
                                style: TextStyle(
                                    fontSize: 14, color: Color(0xff4B844D)),
                              ),
                            ],
                          ),
                          const Icon(
                            Icons.arrow_forward_ios,
                            size: 12,
                            color: Color(0xff4B844D),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    GestureDetector(
                      onTap: () {
                        showLogoutDialog(context);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Color(0XF4B844D).withOpacity(0.3)),
                            borderRadius: BorderRadius.circular(10)),
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.logout,
                                  color: Color(0xff4B844D),
                                ),
                                const SizedBox(width: 15),
                                Text(
                                  "Log Out",
                                  style: TextStyle(
                                      fontSize: 14, color: Color(0xff4B844D)),
                                ),
                              ],
                            ),
                            const Icon(
                              Icons.arrow_forward_ios,
                              size: 12,
                              color: Color(0xff4B844D),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          child: FractionallySizedBox(

            widthFactor: 0.8,
            child: Container(
             
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFF70CB74),
                    Color(0xFF354F33),
                  ], // Adjust gradient colors as needed
                ),
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Center(
                      child: Text(
                        'Log out of your account?',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15.0,
                        ),
                      ),
                    ),
                  ),
                
                  const Divider(),
                  GestureDetector(
                    onTap: () {
                      PreferenceApp().removePreferences();
                      Get.offAllNamed('/bottomNavbar');
                    },
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text(
                          'Log out',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: TColor.bg,
                          ),
                        ),
                      ),
                    ),
                  ),
                 
                  const Divider(),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: const Center(
                      child: Text(
                        'Cancel',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 15,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                   SizedBox(height: 10.0),
                   ],
              ),
            ),
          ),
        );
      },
    );
  }
}
