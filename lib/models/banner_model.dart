// To parse this JSON data, do
//
//     final bannerModel = bannerModelFromJson(jsonString);

import 'dart:convert';

BannerModel bannerModelFromJson(String str) => BannerModel.fromJson(json.decode(str));

String bannerModelToJson(BannerModel data) => json.encode(data.toJson());

class BannerModel {
    bool? status;
    String? message;
    List<BannerData>? data;

    BannerModel({
        this.status,
        this.message,
        this.data,
    });

    factory BannerModel.fromJson(Map<String, dynamic> json) => BannerModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? [] : List<BannerData>.from(json["data"]!.map((x) => BannerData.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class BannerData{
    String? id;
    String? title;
    String? image;
    bool? isActive;
    String? url;
    DateTime? expiresAt;
    DateTime? createdAt;
    DateTime? updatedAt;

    BannerData({
        this.id,
        this.title,
        this.image,
        this.isActive,
        this.url,
        this.expiresAt,
        this.createdAt,
        this.updatedAt,
    });

    factory BannerData.fromJson(Map<String, dynamic> json) => BannerData(
        id: json["_id"],
        title: json["title"],
        image: json["image"],
        isActive: json["isActive"],
        url: json["url"],
        expiresAt: json["expiresAt"] == null ? null : DateTime.parse(json["expiresAt"]),
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "image": image,
        "isActive": isActive,
        "url": url,
        "expiresAt": expiresAt?.toIso8601String(),
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
    };
}
