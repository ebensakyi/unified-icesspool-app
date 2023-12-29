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
    required this.desc,

    // required this.deleted,
    // required this.createdAt,
    // required this.updatedAt,
  });

  int id;
  String name;
  double cost;
  String type;
  String desc;

  // int deleted;
  // DateTime createdAt;
  // DateTime updatedAt;

  factory BiodigesterPricing.fromJson(Map<String, dynamic> json) =>
      BiodigesterPricing(
        id: json["id"],
        name: json["name"],
        cost: json["cost"],
        type: json["type"],
        desc: json["desc"],

        // deleted: json["deleted"],
        // createdAt: DateTime.parse(json["createdAt"]),
        // updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "cost": cost,
        "type": type,
        "desc": desc,
        // "deleted": deleted,
        // "createdAt": createdAt.toIso8601String(),
        // "updatedAt": updatedAt.toIso8601String(),
      };
}
