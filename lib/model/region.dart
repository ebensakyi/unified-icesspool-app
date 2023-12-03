// To parse this JSON data, do
//
//     final Region = RegionFromJson(jsonString);

import 'dart:convert';

List<Region> RegionFromJson(String str) =>
    List<Region>.from(json.decode(str).map((x) => Region.fromJson(x)));

String RegionToJson(List<Region> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Region {
  Region({
    required this.id,
    required this.name,
    required this.deleted,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String name;
  int deleted;
  DateTime createdAt;
  DateTime updatedAt;

  factory Region.fromJson(Map<String, dynamic> json) => Region(
        id: json["id"],
        name: json["name"],
        deleted: json["deleted"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "deleted": deleted,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}
