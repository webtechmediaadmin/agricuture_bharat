  import 'package:agriculter_bharat/constant/constant.dart';
import 'package:flutter/material.dart';
  import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';

import '../../constant/helper.dart';
import '../../services/auth_services.dart';
import '../bottom_nav_bar.dart';

  class OTPView extends StatefulWidget {
     final Function callback;
    const OTPView({super.key, required this.callback});

    @override
    State<OTPView> createState() => _OTPViewState();
  }

  class _OTPViewState extends State<OTPView> {
    final AuthController authController = Get.find();

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          elevation: 5,
          title: const Text(
            "OTP Verification",
            style: TextStyle(color: Colors.black, fontSize: 15),
          ),
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
              size: 15,
            ),
            onPressed: () {
              Navigator.pop(context);
              widget.callback();
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 30),
          child: Column(
            children: [
              Center(
                  child: Text(
                "We've sent a verification code to",
                style: TextStyle(color: Colors.black.withOpacity(0.6)),
              )),
              Center(
                  child: Text(
                "+91 ${MyConstant.mobileNumber}",
                style: TextStyle(color: Colors.black, fontSize: 16),
              )),
              const SizedBox(height: 30),
              OtpTextField(
                autoFocus: true,
                numberOfFields: 4,
                borderColor: Colors.black,
                margin: const EdgeInsets.all(10),
                borderRadius: BorderRadius.circular(10),
                cursorColor: Colors.black,
                showCursor: true,
                showFieldAsBox: true,
                keyboardType: TextInputType.phone,
                onCodeChanged: (String code) {
                  //handle validation or checks here
                },
                onSubmit: (String verifyController) async {
                  // showDialog(
                  //     context: context,
                  //     builder: (context) {
                  //       return AlertDialog(
                  //         title: const Text("Verification Code"),
                  //         content: Text('Code entered is $verificationCode'),
                  //       );
                  //     });
                  if (verifyController.isEmpty) {
                      showSnackBar("", "Please enter mobile number");
                    } else if (verifyController.length < 4) {
                      showSnackBar("", "Verification code must have 4 digits");
                    } else {
                      try {
                        await authController
                          .verifyOtp(
                              MyConstant.mobileNumber, verifyController)
                          .then((dynamic success){
                        if (success ) {
                          print("get access $success");
                            Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => BottomNavBar(selectedIndex: 0)),
                                            );
                        } else {
                          print("Invalid OTP response");
                          showSnackBar("", "Invalid OTP");
                        }
                      }); 
                      } catch (e) {
                        print('Error: $e');
                              showSnackBar("", "Error sending OTP: $e"); 
                      }
                     
                     
                    }
                }, 
              ),
            ],
          ),
        ),
      );
    }
  }
