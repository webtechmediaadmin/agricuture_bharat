

//import 'package:firebase_messaging/firebase_messaging.dart';

bool isValidPhoneNumber(String string) {
  // Null or empty string is invalid phone number
  if (string.isEmpty) {
    return false;
  }
  // You may need to change this pattern to fit your requirement.
  // I just copied the pattern from here: https://regexr.com/3c53v
  const pattern = r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$';
  final regExp = RegExp(pattern);

  if (!regExp.hasMatch(string)) {
    return false;
  }
  return true;
}

 //FirebaseMessaging messaging = FirebaseMessaging.instance;

class MyConstant {
   static String mobileNumber = "";
   static String access_token = "";
   static String DEVICE_TOKEN = ""; 
   static String? userToken = "";
   static bool? myBoolValue = false;
}

// Future<String> getDeviceToken() async {
//     await messaging.requestPermission(alert: true, badge: true, provisional: false);
//     String? token = await messaging.getToken();
//     MyConstant.DEVICE_TOKEN = token!;
//     print("get id token ${MyConstant.DEVICE_TOKEN}");
//     return token;
//   }    


  // void isRefreshToken() async {
  //   messaging.onTokenRefresh.listen((event) {
  //     event.toString();
  //    });
  // }


