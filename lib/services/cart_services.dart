import 'dart:convert';

import 'package:agriculter_bharat/constant/helper.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../api_routes/api_routes.dart';
import '../constant/constant.dart';
import '../models/fetch_cart_model.dart';

class CartController extends GetxController {
  Future<void> addToCartData(String id) async {
    try {
      String apiUrl = ApiRoutes.addToCartApi + id;
      var headers = {
        "Accept": "application/json",
        "Authorization": 'Bearer ${MyConstant.access_token}'
      };
     // Map<String, dynamic> body = {"quantity": 1};
      var response =
          await http.post(Uri.parse(apiUrl), headers: headers);
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
        throw Exception('Failed to fetch banners. Status code: ${response.statusCode}');
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
  
      var response =
          await http.delete(Uri.parse(apiUrl), headers: headers);
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

  
  Future<void> editAddToCartData(String id, int quantity) async {
    try {
      String apiUrl = ApiRoutes.editAddToCartApi + id;
      var headers = {
        "Accept": "application/json",
        "Authorization": 'Bearer ${MyConstant.access_token}'
      };
      Map<String, dynamic> body = {"quantity": quantity};
      var response =
      await http.post(Uri.parse(apiUrl), body: body, headers: headers);
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

}