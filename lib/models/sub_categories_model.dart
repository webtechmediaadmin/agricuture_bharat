// To parse this JSON data, do
//
//     final subCategoryModel = subCategoryModelFromJson(jsonString);

import 'dart:convert';

SubCategoryModel subCategoryModelFromJson(String str) => SubCategoryModel.fromJson(json.decode(str));

String subCategoryModelToJson(SubCategoryModel data) => json.encode(data.toJson());

class SubCategoryModel {
    bool? status;
    String? message;
    List<SubCategoryData>? data;

    SubCategoryModel({
        this.status,
        this.message,
        this.data,
    });

    factory SubCategoryModel.fromJson(Map<String, dynamic> json) => SubCategoryModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? [] : List<SubCategoryData>.from(json["data"]!.map((x) => SubCategoryData.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class SubCategoryData{
    String? id;
    CategoryId? categoryId;
    String? title;
    String? image;
    String? description;
    bool? isActive;
    int? v;

    SubCategoryData({
        this.id,
        this.categoryId,
        this.title,
        this.image,
        this.description,
        this.isActive,
        this.v,
    });

    factory SubCategoryData.fromJson(Map<String, dynamic> json) => SubCategoryData(
        id: json["_id"],
        categoryId: json["category_id"] == null ? null : CategoryId.fromJson(json["category_id"]),
        title: json["title"],
        image: json["image"],
        description: json["description"],
        isActive: json["isActive"],
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "category_id": categoryId?.toJson(),
        "title": title,
        "image": image,
        "description": description,
        "isActive": isActive,
        "__v": v,
    };
}

class CategoryId {
    String? id;
    String? title;

    CategoryId({
        this.id,
        this.title,
    });

    factory CategoryId.fromJson(Map<String, dynamic> json) => CategoryId(
        id: json["_id"],
        title: json["title"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
    };
}
