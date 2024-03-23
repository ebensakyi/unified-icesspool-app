// To parse this JSON data, do
//
//     final District = DistrictFromJson(jsonString);

import 'dart:convert';

List<ToiletTruckPricing> ToiletTruckPricingFromJson(String str) =>
    List<ToiletTruckPricing>.from(
        json.decode(str).map((x) => ToiletTruckPricing.fromJson(x)));

String ToiletTruckPricingToJson(List<ToiletTruckPricing> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ToiletTruckPricing {
  ToiletTruckPricing({
    required this.id,
    required this.name,
    required this.cost,
    this.shortDesc,
    this.fullDesc,

  });

  int id;
  String name;
  String cost;
  String? shortDesc;
  String? fullDesc;

  factory ToiletTruckPricing.fromJson(Map<String, dynamic> json) =>
      ToiletTruckPricing(
        id: json["id"],
        name: json["name"],
        cost: json["cost"],
        shortDesc: json["shortDesc"],
        fullDesc: json["fullDesc"]
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "cost": cost,
        "shortDesc": shortDesc,
        "fullDesc": fullDesc
      };
}
