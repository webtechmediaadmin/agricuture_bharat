import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../api_routes/api_routes.dart';
import '../models/all_product_details_model.dart';
import '../models/all_product_model.dart';

class AllProductsController extends GetxController {
   RxList<AllProductData> allProductDataList = <AllProductData>[].obs;

  Future<void> fetchAllProducts(String id) async {
    try {
      var uri = await Uri.parse(ApiRoutes.allProducts + id);
      var headers = {"Content-type": "application/json"};

      print(uri.toString());

      var response = await http.get(uri, headers: headers);
      print(response.statusCode);
      print(response.body);

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        print(data);

        // Assuming the response data is an instance of BannerModel
        AllProductModel allProductModel = allProductModelFromJson(json.encode(data));

        allProductDataList.assignAll(allProductModel.data ?? []);
      } else {
        throw Exception('Failed to fetch banners. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error sending Banners: $e');
    }
  }

  var allProductDetailModel = AllProductDetailModel().obs;
  RxList<List<String>> tableData = <List<String>>[].obs;
  RxString productDescription = ''.obs;
  final RxDouble savePrice = 0.0.obs;

  Future<void> fetchAllProductsDetails(String id) async {
    try {
      var uri = await Uri.parse(ApiRoutes.allProductsDetails + id);
      var headers = {"Content-type": "application/json"};

      print(uri.toString());

      var response = await http.get(uri, headers: headers);
      print(response.statusCode);
      print(response.body);

      if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
        allProductDetailModel.value =
            AllProductDetailModel.fromJson(jsonResponse);
        
        
      } else {
        throw Exception('Failed to fetch banners. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error sending Banners: $e');
    }
  }
}