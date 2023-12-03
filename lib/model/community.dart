// To parse this JSON data, do
//
//     final Community = CommunityFromJson(jsonString);

import 'dart:convert';

List<Community> CommunityFromJson(String str) =>
    List<Community>.from(json.decode(str).map((x) => Community.fromJson(x)));

String CommunityToJson(List<Community> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Community {
  Community({
    required this.id,
    required this.name,
    required this.districtId,
    required this.deleted,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String name;
  int districtId;
  int deleted;
  DateTime createdAt;
  DateTime updatedAt;

  factory Community.fromJson(Map<String, dynamic> json) => Community(
        id: json["id"],
        name: json["name"],
        districtId: json["districtId"],
        deleted: json["deleted"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "districtId": districtId,
        "deleted": deleted,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}
