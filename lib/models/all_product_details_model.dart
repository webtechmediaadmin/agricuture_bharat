// To parse this JSON data, do
//
//     final allProductDetailModel = allProductDetailModelFromJson(jsonString);

import 'dart:convert';

AllProductDetailModel allProductDetailModelFromJson(String str) => AllProductDetailModel.fromJson(json.decode(str));

String allProductDetailModelToJson(AllProductDetailModel data) => json.encode(data.toJson());

class AllProductDetailModel {
    bool? status;
    String? message;
    List<AllProductDetailData>? data;

    AllProductDetailModel({
        this.status,
        this.message,
        this.data,
    });

    factory AllProductDetailModel.fromJson(Map<String, dynamic> json) => AllProductDetailModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? [] : List<AllProductDetailData>.from(json["data"]!.map((x) => AllProductDetailData.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class AllProductDetailData {
    String? id;
    Id? brandId;
    Id? categoryId;
    Id? subCategoryId;
    String? title;
    String? description;
    List<String>? image;
    String? logo;
    String? price;
    bool? isActive;
    String? discountedPrice;
    int? discountPercent;
    int? rating;
    int? quantity;
    DateTime? createdAt;
    DateTime? updatedAt;

    AllProductDetailData({
        this.id,
        this.brandId,
        this.categoryId,
        this.subCategoryId,
        this.title,
        this.description,
        this.image,
        this.logo,
        this.price,
        this.isActive,
        this.discountedPrice,
        this.discountPercent,
        this.rating,
        this.quantity,
        this.createdAt,
        this.updatedAt,
    });

    factory AllProductDetailData.fromJson(Map<String, dynamic> json) => AllProductDetailData(
        id: json["_id"],
        brandId: json["brandID"] == null ? null : Id.fromJson(json["brandID"]),
        categoryId: json["categoryID"] == null ? null : Id.fromJson(json["categoryID"]),
        subCategoryId: json["subCategoryID"] == null ? null : Id.fromJson(json["subCategoryID"]),
        title: json["title"],
        description: json["description"],
        image: json["image"] == null ? [] : List<String>.from(json["image"]!.map((x) => x)),
        logo: json["logo"],
        price: json["price"],
        isActive: json["isActive"],
        discountedPrice: json["discountedPrice"],
        discountPercent: json["discountPercent"],
        rating: json["rating"],
        quantity: json["quantity"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "brandID": brandId?.toJson(),
        "categoryID": categoryId?.toJson(),
        "subCategoryID": subCategoryId?.toJson(),
        "title": title,
        "description": description,
        "image": image == null ? [] : List<dynamic>.from(image!.map((x) => x)),
        "logo": logo,
        "price": price,
        "isActive": isActive,
        "discountedPrice": discountedPrice,
        "discountPercent": discountPercent,
        "rating": rating,
        "quantity": quantity,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
    };
}

class Id {
    String? id;
    String? title;

    Id({
        this.id,
        this.title,
    });

    factory Id.fromJson(Map<String, dynamic> json) => Id(
        id: json["_id"],
        title: json["title"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
    };
}
