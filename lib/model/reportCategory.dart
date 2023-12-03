// To parse this JSON data, do
//

import 'dart:convert';

List<ReportCategory> ReportCategoryFromJson(String str) =>
    List<ReportCategory>.from(
        json.decode(str).map((x) => ReportCategory.fromJson(x)));

String ReportCategoryToJson(List<ReportCategory> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ReportCategory {
  ReportCategory({
    required this.id,
    required this.name,
    // required this.deleted,
    // required this.createdAt,
    // required this.updatedAt,
  });

  int id;
  String name;
  // int deleted;
  // DateTime createdAt;
  // DateTime updatedAt;

  factory ReportCategory.fromJson(Map<String, dynamic> json) => ReportCategory(
        id: json["id"],
        name: json["name"],
        // deleted: json["deleted"],
        // createdAt: DateTime.parse(json["createdAt"]),
        // updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        // "deleted": deleted,
        // "createdAt": createdAt.toIso8601String(),
        // "updatedAt": updatedAt.toIso8601String(),
      };
}
