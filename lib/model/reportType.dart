// To parse this JSON data, do
//
//     final Community = CommunityFromJson(jsonString);

import 'dart:convert';

List<ReportType> ReportTypeFromJson(String str) =>
    List<ReportType>.from(json.decode(str).map((x) => ReportType.fromJson(x)));

String ReportTypeToJson(List<ReportType> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ReportType {
  ReportType({
    // required this.id,
    required this.name,
    // required this.deleted,
    // required this.createdAt,
    // required this.updatedAt,
  });

  // int id;
  String name;
  // int deleted;
  // DateTime createdAt;
  // DateTime updatedAt;

  factory ReportType.fromJson(Map<String, dynamic> json) => ReportType(
        // id: json["id"],
        name: json["name"],
        // deleted: json["deleted"],
        // createdAt: DateTime.parse(json["createdAt"]),
        // updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        // "id": id,
        "name": name,
        // "deleted": deleted,
        // "createdAt": createdAt.toIso8601String(),
        // "updatedAt": updatedAt.toIso8601String(),
      };
}
