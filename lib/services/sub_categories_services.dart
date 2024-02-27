import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../api_routes/api_routes.dart';
import '../models/sub_categories_model.dart';

class SubCategoryController extends GetxController {
   RxList<SubCategoryData> categoryDataList = <SubCategoryData>[].obs;

  Future<void> fetchCategory(String id) async {
    try {
      var uri = await Uri.parse(ApiRoutes.subCategories + id);
      var headers = {"Content-type": "application/json"};

      print(uri.toString());

      var response = await http.get(uri, headers: headers);
      print(response.statusCode);
      print(response.body);

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        print(data);

        // Assuming the response data is an instance of BannerModel
        SubCategoryModel categoryModel = subCategoryModelFromJson(json.encode(data));

        categoryDataList.assignAll(categoryModel.data ?? []);
      } else {
        throw Exception('Failed to fetch banners. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error sending Banners: $e');
    }
  }
}