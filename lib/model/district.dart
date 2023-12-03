// To parse this JSON data, do
//
//     final District = DistrictFromJson(jsonString);

import 'dart:convert';

List<District> DistrictFromJson(String str) =>
    List<District>.from(json.decode(str).map((x) => District.fromJson(x)));

String DistrictToJson(List<District> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class District {
  District({
    required this.id,
    required this.name,
    required this.abbrv,
    required this.deleted,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String name;
  String abbrv;
  int deleted;
  DateTime createdAt;
  DateTime updatedAt;

  factory District.fromJson(Map<String, dynamic> json) => District(
        id: json["id"],
        name: json["name"],
        abbrv: json["abbrv"],
        deleted: json["deleted"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "abbrv": abbrv,
        "deleted": deleted,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}
