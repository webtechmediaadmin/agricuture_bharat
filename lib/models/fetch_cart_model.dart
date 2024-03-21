// To parse this JSON data, do
//
//     final fetchCartModel = fetchCartModelFromJson(jsonString);

import 'dart:convert';

FetchCartModel fetchCartModelFromJson(String str) =>
    FetchCartModel.fromJson(json.decode(str));

String fetchCartModelToJson(FetchCartModel data) => json.encode(data.toJson());

class FetchCartModel {
  bool? status;
  int? count;
  List<FetchCartData>? data;
  String? message;

  FetchCartModel({
    this.status,
    this.count,
    this.data,
    this.message,
  });

  factory FetchCartModel.fromJson(Map<String, dynamic> json) => FetchCartModel(
        status: json["status"],
        count: json["count"],
        data: json["data"] == null
            ? []
            : List<FetchCartData>.from(
                json["data"]!.map((x) => FetchCartData.fromJson(x))),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "count": count,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "message": message,
      };
}

class FetchCartData {
  String? id;
  String? userId;
  ProductId? productId;
  int quantity;
  double? totalAmount;
  DateTime? createdAt;
  DateTime? updatedAt;

  FetchCartData({
    this.id,
    this.userId,
    this.productId,
    this.quantity = 1,
    this.totalAmount,
    this.createdAt,
    this.updatedAt,
  });

  factory FetchCartData.fromJson(Map<String, dynamic> json) => FetchCartData(
        id: json["_id"],
        userId: json["userID"],
        productId: json["productID"] == null
            ? null
            : ProductId.fromJson(json["productID"]),
        quantity: _parseQuantity(json["quantity"]),
          totalAmount: json["totalAmount"]?.toDouble() ?? 0.0,
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
      );

  static int _parseQuantity(dynamic quantity) {
    if (quantity is int) {
      return quantity;
    } else if (quantity is String) {
      return int.tryParse(quantity) ?? 0;
    }
    return 0;
  }

  Map<String, dynamic> toJson() => {
        "_id": id,
        "userID": userId,
        "productID": productId?.toJson(),
        "quantity": quantity,
        "totalAmount": totalAmount,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
      };
}

class ProductId {
  String? id;
  String? brandId;
  String? categoryId;
  String? subCategoryId;
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

  ProductId({
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

  factory ProductId.fromJson(Map<String, dynamic> json) => ProductId(
        id: json["_id"],
        brandId: json["brandID"],
        categoryId: json["categoryID"],
        subCategoryId: json["subCategoryID"],
        title: json["title"],
        description: json["description"],
        image: json["image"] == null
            ? []
            : List<String>.from(json["image"]!.map((x) => x)),
        logo: json["logo"],
        price: json["price"],
        isActive: json["isActive"],
        discountedPrice: json["discountedPrice"],
        discountPercent: json["discountPercent"],
        rating: json["rating"],
        quantity: json["quantity"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "brandID": brandId,
        "categoryID": categoryId,
        "subCategoryID": subCategoryId,
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
