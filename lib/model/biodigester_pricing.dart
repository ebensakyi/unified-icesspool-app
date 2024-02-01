// To parse this JSON data, do
//
//     final District = DistrictFromJson(jsonString);

import 'dart:convert';

List<BiodigesterPricing> BiodigesterPricingFromJson(String str) =>
    List<BiodigesterPricing>.from(
        json.decode(str).map((x) => BiodigesterPricing.fromJson(x)));

String BiodigesterPricingToJson(List<BiodigesterPricing> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BiodigesterPricing {
  BiodigesterPricing({
    required this.id,
    required this.name,
    required this.cost,
    required this.type,
    required this.biodigesterServiceId,
    this.shortDesc,
    this.fullDesc,

    // required this.deleted,
    // required this.createdAt,
    // required this.updatedAt,
  });

  int id;
  int biodigesterServiceId;
  String name;
  String cost;
  String type;
  String? shortDesc;
  String? fullDesc;

  // int deleted;
  // DateTime createdAt;
  // DateTime updatedAt;

  factory BiodigesterPricing.fromJson(Map<String, dynamic> json) =>
      BiodigesterPricing(
        id: json["id"],
        biodigesterServiceId: json["biodigesterServiceId"],
        name: json["name"],
        cost: json["cost"],
        type: json["type"],
        shortDesc: json["shortDesc"],
        fullDesc: json["fullDesc"],

        // deleted: json["deleted"],
        // createdAt: DateTime.parse(json["createdAt"]),
        // updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "biodigesterServiceId": biodigesterServiceId,
        "name": name,
        "cost": cost,
        "type": type,
        "shortDesc": shortDesc,
        "fullDesc": fullDesc,
        // "deleted": deleted,
        // "createdAt": createdAt.toIso8601String(),
        // "updatedAt": updatedAt.toIso8601String(),
      };
}
