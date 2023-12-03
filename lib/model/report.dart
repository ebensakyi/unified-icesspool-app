// To parse this JSON data, do
//
//     final Report = ReportFromJson(jsonString);

import 'dart:convert';

List<Report> ReportFromJson(String str) =>
    List<Report>.from(json.decode(str).map((x) => Report.fromJson(x)));

String ReportToJson(List<Report> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Report {
  Report({
    required this.id,
    required this.reportCategoryId,
    required this.community,
    required this.image,
    required this.latitude,
    required this.longitude,
    required this.status,
    required this.address,
    required this.statusMessage,
    required this.description,
    required this.deleted,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String? community;
  String? image;
  String? latitude;
  String? longitude;
  int? reportCategoryId;
  int? status;
  String address;
  String? statusMessage;
  String? description;
  int? deleted;
  DateTime createdAt;
  DateTime updatedAt;

  factory Report.fromJson(Map<String, dynamic> json) => Report(
        id: json["id"],
        community: json["community"],
        image: json["image"],
        reportCategoryId: json["reportCategoryId"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        status: json["status"],
        address: json["address"],
        statusMessage: json["statusMessage"],
        description: json["description"],
        deleted: json["deleted"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "community": community,
        "reportCategoryId": reportCategoryId,
        "image": image,
        "latitude": latitude,
        "longitude": longitude,
        "status": status,
        "address": address,
        "statusMessage": statusMessage,
        "description": description,
        "deleted": deleted,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}
