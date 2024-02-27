// To parse this JSON data, do
//
//     final allProductModel = allProductModelFromJson(jsonString);

import 'dart:convert';

AllProductModel allProductModelFromJson(String str) => AllProductModel.fromJson(json.decode(str));

String allProductModelToJson(AllProductModel data) => json.encode(data.toJson());

class AllProductModel {
    bool? status;
    String? message;
    List<AllProductData>? data;

    AllProductModel({
        this.status,
        this.message,
        this.data,
    });

    factory AllProductModel.fromJson(Map<String, dynamic> json) => AllProductModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? [] : List<AllProductData>.from(json["data"]!.map((x) => AllProductData.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class AllProductData {
    String? id;
    Id? brandId;
    Id? categoryId;
    Id? subCategoryId;
    String? title;
    String? description;
    List<dynamic>? image;
    dynamic logo;
    String? price;
    bool? isActive;
    int? rating;
    int? quantity;
    DateTime? createdAt;
    DateTime? updatedAt;

    AllProductData({
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
        this.rating,
        this.quantity,
        this.createdAt,
        this.updatedAt,
    });

    factory AllProductData.fromJson(Map<String, dynamic> json) => AllProductData(
        id: json["_id"],
        brandId: json["brandID"] == null ? null : Id.fromJson(json["brandID"]),
        categoryId: json["categoryID"] == null ? null : Id.fromJson(json["categoryID"]),
        subCategoryId: json["subCategoryID"] == null ? null : Id.fromJson(json["subCategoryID"]),
        title: json["title"],
        description: json["description"],
        image: json["image"] == null ? [] : List<dynamic>.from(json["image"]!.map((x) => x)),
        logo: json["logo"],
        price: json["price"],
        isActive: json["isActive"],
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
