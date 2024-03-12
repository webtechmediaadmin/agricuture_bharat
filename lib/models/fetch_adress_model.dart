// To parse this JSON data, do
//
//     final fetchAddressModel = fetchAddressModelFromJson(jsonString);

import 'dart:convert';

FetchAddressModel fetchAddressModelFromJson(String str) => FetchAddressModel.fromJson(json.decode(str));

String fetchAddressModelToJson(FetchAddressModel data) => json.encode(data.toJson());

class FetchAddressModel {
    bool? status;
    String? message;
    List<FetchAddressData>? data;

    FetchAddressModel({
        this.status,
        this.message,
        this.data,
    });

    factory FetchAddressModel.fromJson(Map<String, dynamic> json) => FetchAddressModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? [] : List<FetchAddressData>.from(json["data"]!.map((x) => FetchAddressData.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class FetchAddressData {
    String? id;
    String? userId;
    CountryId? countryId;
    StateId? stateId;
    CityId? cityId;
    String? pincode;
    String? name;
    String? phoneNumber;
    String? type;
    String? buildingName;
    String? area;
    DateTime? createdAt;
    DateTime? updatedAt;

    FetchAddressData({
        this.id,
        this.userId,
        this.countryId,
        this.stateId,
        this.cityId,
        this.pincode,
        this.name,
        this.phoneNumber,
        this.type,
        this.buildingName,
        this.area,
        this.createdAt,
        this.updatedAt,
    });

    factory FetchAddressData.fromJson(Map<String, dynamic> json) => FetchAddressData(
        id: json["_id"],
        userId: json["userID"],
        countryId: json["countryID"] == null ? null : CountryId.fromJson(json["countryID"]),
        stateId: json["stateID"] == null ? null : StateId.fromJson(json["stateID"]),
        cityId: json["cityID"] == null ? null : CityId.fromJson(json["cityID"]),
        pincode: json["pincode"],
        name: json["name"],
        phoneNumber: json["phoneNumber"],
        type: json["type"],
        buildingName: json["buildingName"],
        area: json["area"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "userID": userId,
        "countryID": countryId?.toJson(),
        "stateID": stateId?.toJson(),
        "cityID": cityId?.toJson(),
        "pincode": pincode,
        "name": name,
        "phoneNumber": phoneNumber,
        "type": type,
        "buildingName": buildingName,
        "area": area,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
    };
}

class CityId {
    String? id;
    String? countryId;
    String? stateId;
    String? name;
    bool? status;
    List<Pincode>? pincode;

    CityId({
        this.id,
        this.countryId,
        this.stateId,
        this.name,
        this.status,
        this.pincode,
    });

    factory CityId.fromJson(Map<String, dynamic> json) => CityId(
        id: json["_id"],
        countryId: json["countryID"],
        stateId: json["stateID"],
        name: json["name"],
        status: json["status"],
        pincode: json["pincode"] == null ? [] : List<Pincode>.from(json["pincode"]!.map((x) => Pincode.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "countryID": countryId,
        "stateID": stateId,
        "name": name,
        "status": status,
        "pincode": pincode == null ? [] : List<dynamic>.from(pincode!.map((x) => x.toJson())),
    };
}

class Pincode {
    int? code;
    bool? status;
    String? id;

    Pincode({
        this.code,
        this.status,
        this.id,
    });

    factory Pincode.fromJson(Map<String, dynamic> json) => Pincode(
        code: json["code"],
        status: json["status"],
        id: json["_id"],
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "status": status,
        "_id": id,
    };
}

class CountryId {
    String? id;
    bool? status;
    DateTime? createdAt;
    DateTime? updatedAt;
    String? name;

    CountryId({
        this.id,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.name,
    });

    factory CountryId.fromJson(Map<String, dynamic> json) => CountryId(
        id: json["_id"],
        status: json["status"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "status": status,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "name": name,
    };
}

class StateId {
    String? id;
    String? countryId;
    String? name;
    bool? status;

    StateId({
        this.id,
        this.countryId,
        this.name,
        this.status,
    });

    factory StateId.fromJson(Map<String, dynamic> json) => StateId(
        id: json["_id"],
        countryId: json["countryID"],
        name: json["name"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "countryID": countryId,
        "name": name,
        "status": status,
    };
}
