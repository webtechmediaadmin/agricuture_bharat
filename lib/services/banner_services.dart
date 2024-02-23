import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../api_routes/api_routes.dart';
import '../models/banner_model.dart';

class BannerController extends GetxController {
  RxList<BannerData> bannerDataList = <BannerData>[].obs;

  Future<void> fetchBanners() async {
    try {
      var uri = await Uri.parse(ApiRoutes.bannerApi);
      var headers = {"Content-type": "application/json"};

      print(uri.toString());

      var response = await http.get(uri, headers: headers);
      print(response.statusCode);
      print(response.body);

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        print(data);

        // Assuming the response data is an instance of BannerModel
        BannerModel bannerModel = bannerModelFromJson(json.encode(data));

        bannerDataList.assignAll(bannerModel.data ?? []);
      } else {
        throw Exception('Failed to fetch banners. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error sending Banners: $e');
    }
  }
}
