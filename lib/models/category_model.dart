// To parse this JSON data, do
//
//     final categoryModel = categoryModelFromJson(jsonString);

import 'dart:convert';

CategoryModel categoryModelFromJson(String str) => CategoryModel.fromJson(json.decode(str));

String categoryModelToJson(CategoryModel data) => json.encode(data.toJson());

class CategoryModel {
    bool? status;
    String? message;
    List<CategoryData>? data;

    CategoryModel({
        this.status,
        this.message,
        this.data,
    });

    factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? [] : List<CategoryData>.from(json["data"]!.map((x) => CategoryData.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class CategoryData {
    String? id;
    String? title;
    String? image;
    String? description;
    bool? isActive;
    DateTime? createdAt;
    DateTime? updatedAt;

    CategoryData({
        this.id,
        this.title,
        this.image,
        this.description,
        this.isActive,
        this.createdAt,
        this.updatedAt,
    });

    factory CategoryData.fromJson(Map<String, dynamic> json) => CategoryData(
        id: json["_id"],
        title: json["title"],
        image: json["image"],
        description: json["description"],
        isActive: json["isActive"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "image": image,
        "description": description,
        "isActive": isActive,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
    };
}
