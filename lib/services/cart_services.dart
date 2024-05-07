import 'dart:convert';

import 'package:agriculter_bharat/constant/helper.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../api_routes/api_routes.dart';
import '../constant/constant.dart';
import '../models/fetch_cart_model.dart';

class CartController extends GetxController {
  Map<String, bool> _cartItemsStatus = {};

  Future<void> addToCartData(String id) async {
    try {
      String apiUrl = ApiRoutes.addToCartApi + id;
      var headers = {
        "Accept": "application/json",
        "Authorization": 'Bearer ${MyConstant.access_token}'
      };
      // Map<String, dynamic> body = {"quantity": "1"};
      var response = await http.post(Uri.parse(apiUrl), headers: headers);
      print(response.statusCode);
      print(response.body);
      print(apiUrl);

      var data = json.decode(response.body);
      var success = data["status"];
      if (response.statusCode == 200) {
        if (!success) {
          throw Exception('Failed to send User Data');
        } else {
          _cartItemsStatus[id] = true;
          showSnackBar("", data["message"]);
        }
      } else {
        print("_cartItemsStatus: $_cartItemsStatus");
        print("id: $id");
        if (_cartItemsStatus.containsKey(id) && _cartItemsStatus[id]!) {
          showSnackBar("", data["message"]);
        }
        throw Exception('Failed to send user Data ${response.statusCode}');
      }
    } catch (e) {
      print(e);
    }
  }

  RxList<FetchCartData> fetchCartDataList = <FetchCartData>[].obs;
  FetchCartModel? fetchCartModel;

  Future<void> fetchCartData() async {
    try {
      var uri = await Uri.parse(ApiRoutes.addToCartFetchApi);
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
        fetchCartModel = fetchCartModelFromJson(json.encode(data));

        fetchCartDataList.assignAll(fetchCartModel?.data ?? []);
      } else {
        // throw Exception(
        //     'Failed to fetch banners. Status code: ${response.statusCode}');
        fetchCartDataList.clear();    
        print(response.statusCode);
      }
    } catch (e) {
      throw Exception('Error sending Banners: $e');
    }
  }

  Future<void> deleteAddToCartData(String id) async {
    try {
      String apiUrl = ApiRoutes.deleteAddToCartApi + id;
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
          _cartItemsStatus[id] = false;
          showSnackBar("", data["message"]);
        }
      } else {
        throw Exception('Failed to send user Data ${response.statusCode}');
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> editAddToCartData(String id, int quantity) async {
    print("data type quantity $quantity ${quantity.runtimeType}");
    print("data type id $id ${id.runtimeType}");

    try {
      // Construct the API URL
      var uri = await Uri.parse(ApiRoutes.editAddToCartApi + id);

      // Define headers for the HTTP request
      var headers = {
        'Content-Type': 'application/json',
        "Authorization": 'Bearer ${MyConstant.access_token}'
      };

      // Convert quantity to string

      // Create the request body
      Map<String, dynamic> body = {"quantity": quantity};
      String jsonData = jsonEncode(body);
      print("data type quantity ${quantity.runtimeType}");
      // Perform the HTTP POST request
      var response = await http.post(uri, body: jsonData, headers: headers);

      // Print response status code and body for debugging
      print(response.statusCode);
      print(response.body);

      // Handle response based on status code
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        var success = data["status"];
        if (!success) {
          throw Exception('Failed to update cart: ${data["message"]}');
        } else {
          // Update successful
          showSnackBar("", "Cart updated successfully");
        }
      } else {
        // If the response status code is not 200, throw an exception
        throw Exception(
            'Failed to update cart. Server responded with status code ${response.statusCode}');
      }
    } catch (e) {
      // Handle any exceptions
      print('Exception caught: $e');
      // Show error message to user
      showSnackBar("", "Error occurred: $e");
    }
  }
}
