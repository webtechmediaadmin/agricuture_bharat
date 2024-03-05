import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../api_routes/api_routes.dart';
import '../constant/app_preferences.dart';
import '../constant/constant.dart';

class AuthController extends GetxController {
  var isLoading = false.obs;
  var isLoggedIn = false.obs;

  Future<void> loginUser(String phone) async {
    try {
      isLoading.value = true;

      var uri = await Uri.parse(ApiRoutes.mobileNumberApi);
      var headers = {"Content-type": "application/json"};
      final requestBody = {'phoneNumber': phone};
      print(uri.toString());
      print(requestBody.toString());
      var response =
          await http.post(uri, headers: headers, body: jsonEncode(requestBody));
      print(response.statusCode);
      print(response.body);
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        var success = data["status"];

        if (!success) {
          throw Exception('Failed to send OTP');
        }
      } else {
        throw Exception(
            'Failed to send OTP. Server returned ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error sending OTP: $e');
    } finally {
      isLoading(false);
    }
  }

  Future<bool> verifyOtp(String phoneNumber, String otp) async {
    try {
      isLoading(true);
      var uri = await Uri.parse(ApiRoutes.verifyOtp);
      var headers = {"Content-type": "application/json"};
      final requestBody = {'phoneNumber': phoneNumber, 'otp': otp};
      print(uri.toString());
      print(requestBody.toString());
      var response =
          await http.post(uri, headers: headers, body: jsonEncode(requestBody));
      print(response.statusCode);
      print(response.body);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print(" data $data");
        final success = data["status"] as bool?;
        final token = data['token'];
        print(" check success value $success");
        if (success == null || !success) {
          throw Exception('OTP verification failed');
        } else {
          
          if(success != null && token != null){
          print("TOKEN $token");
          PreferenceApp().setAccessToken(data['token'] ?? "");
          MyConstant.access_token = data['token'] ?? "";
          PreferenceApp().setIsNewUser(true);
          print("--------token ${MyConstant.access_token}");
          }
        }
        return true;
      } else {
        throw Exception(
            'Failed to verify OTP. Server returned ${response.statusCode}');
      }
    } catch (e) {
      print(e);
      return false;
    } finally {
      isLoading(false);
    }
  }
}
