import 'dart:convert';

import 'package:get/get.dart';

import '../api_routes/api_routes.dart';
import '../constant/constant.dart';
import 'package:http/http.dart' as http;

import '../constant/helper.dart';

class PlaceOrderController extends GetxController {

  Future<void> placeOrder(String id) async {
    try {
      String apiUrl = ApiRoutes.placeOrder;
      var headers = {
       'Content-Type': 'application/json',
        "Authorization": 'Bearer ${MyConstant.access_token}'
      };
      Map<String, dynamic> body = {"shippingAddress": id};
      String jsonData = jsonEncode(body);
      var response = await http.post(Uri.parse(apiUrl), body: jsonData, headers: headers);
      print(response.statusCode);
      print(response.body);
      print(apiUrl);

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        var success = data["status"];
        if (!success) {
          throw Exception('Failed to send Place Order');
        } else {
          showSnackBar("", data["message"]);
        }
      } else {
        throw Exception('Failed to send place Order ${response.statusCode}');
      }
    } catch (e) {
      print(e);
    }
  }

}