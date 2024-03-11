import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../api_routes/api_routes.dart';
import '../constant/constant.dart';
import '../constant/helper.dart';

class AddressController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController pincodeController = TextEditingController();
  TextEditingController buildingNameController = TextEditingController();
  TextEditingController areaController = TextEditingController();
  TextEditingController alternatePhoneController = TextEditingController();
  TextEditingController landmarkController = TextEditingController();
  dynamic cityName;
  dynamic stateName;
  dynamic countryName;

  Future<void> addressFetch(Map<String, dynamic> body) async {
    try {
      String apiUrl = ApiRoutes.addressesApi;
      var headers = {
        "Accept": "application/json",
        "Authorization": 'Bearer ${MyConstant.access_token}'
      };

      var response =
          await http.post(Uri.parse(apiUrl), body: body, headers: headers);
      print(response.statusCode);
      print(response.body);
      print(apiUrl);

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        var success = data["status"];
        if (!success) {
          throw Exception('Failed to save User Address');
        } else {
          showSnackBar("", data["message"]);
        }
      } else {
        throw Exception('Failed to send user Data ${response.statusCode}');
      }
    } catch (e) {
      print(e);
    }
  }

  RxMap<dynamic, dynamic> userData = {}.obs;

  Future<bool> fetchDataByPincode(String pincode) async {
    try {
      String apiUrl = "${ApiRoutes.pinCodeData}$pincode";
      var response = await http.get(Uri.parse(apiUrl));
      print(response.statusCode);
      print(response.body);

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        dynamic success = data["status"];
        print("get user success value $success");

        if (success != null && success) {
          // Find the city data that matches the entered pincode
          dynamic cityDataList = data["data"];
          var cityData = cityDataList.firstWhere(
            (city) {
              return (city["pincode"] as List)
                  .any((pin){
                    print("PINCODE RETURN----------${pin["code"].toString()}");
                    return pin["code"].toString() == pincode;
                  });
            },
            orElse: () => null,
          );

          print("PINCODE----------------$cityData");
          if (cityData != null) {
            // Extract city, state, and country names
            var cityName = cityData["name"];
            var stateName = cityData["stateID"]["name"];
            //   var countryName = cityData["countryID"]["name"];

            // Update user data
            userData.assignAll({
              "cityName": cityName,
              "stateName": stateName,
              //  "countryName": countryName,
            });

            return true;
          } else {
            throw Exception('City not found for the entered pincode');
          }
        } else {
          throw Exception('Failed to fetch city data');
        }
      } else {
        print('Error: ${response.statusCode}');
        return false;
      }
    } catch (error) {
      print('Error: $error');
      return false;
    }
  }
}
