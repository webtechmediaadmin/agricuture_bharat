import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../api_routes/api_routes.dart';
import '../constant/constant.dart';
import '../constant/helper.dart';
import '../models/fetch_adress_model.dart';

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

  Future<void> addressFetch(final body) async {
    try {
      String apiUrl = ApiRoutes.addressesApi;
      var headers = {
        "Content-type": "application/json",
        "Authorization": 'Bearer ${MyConstant.access_token}'
      };
      print("BODY1-------------$body");
      var response =
          await http.post(Uri.parse(apiUrl), body: jsonEncode(body), headers: headers);
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
              return (city["pincode"] as List).any((pin) {
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
              "cityId": cityData["_id"], // Add city ID extraction
              "stateId": cityData["stateID"]["_id"], //
              //  "countryName": countryName,
            });

            print("City ID: ${cityData["_id"]}");
            print("State ID: ${cityData["stateID"]["_id"]}");

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



  RxList<FetchAddressData> addressDataList = <FetchAddressData>[].obs;

  Future<void> fetchAddresses() async {
    try {
      var uri = await Uri.parse(ApiRoutes.addressFetchData);
       var headers = {
        "Content-type": "application/json",
        "Authorization": 'Bearer ${MyConstant.access_token}'
      };

      print(uri.toString());

      var response = await http.get(uri, headers: headers);
      print(response.statusCode);
      print(response.body);

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        print(data);

        // Assuming the response data is an instance of BannerModel
        FetchAddressModel fetchAddressModel = fetchAddressModelFromJson(json.encode(data));

        addressDataList.assignAll(fetchAddressModel.data ?? []);
      } else {
        addressDataList.clear();
        throw Exception('Failed to fetch addresses. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error sending Addresses: $e');
    }
  }



  Future<void> deleteAddress(String id) async {
    try {
      String apiUrl = ApiRoutes.deleteAddress + id;
      var headers = {
        "Accept": "application/json",
        "Authorization": 'Bearer ${MyConstant.access_token}'
      };

      var response = await http.delete(Uri.parse(apiUrl), headers: headers);
      print(response.statusCode);
      print(response.body);
      print(apiUrl);

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        var success = data["status"];
        if (!success) {
          throw Exception('Failed to send User Data');
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


  Future<void> editAddress(final body, String id) async {
    try {
      String apiUrl = ApiRoutes.editAddressApi + id;
      var headers = {
        "Content-type": "application/json",
        "Authorization": 'Bearer ${MyConstant.access_token}'
      };
      print("BODY1-------------$body");
      var response =
          await http.post(Uri.parse(apiUrl), body: jsonEncode(body), headers: headers);
      print(response.statusCode);
      print(response.body);
      print(apiUrl);

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        var success = data["status"];
        if (!success) {
          throw Exception('Failed to edit User Address');
        } else {
          showSnackBar("", data["message"]);
        }
      } else {
        throw Exception('Failed to edit user Data ${response.statusCode}');
      }
    } catch (e) {
      print(e);
    }
  }


}
