import 'dart:convert';

List<OfferItem> OfferItemFromJson(String str) =>
    List<OfferItem>.from(json.decode(str).map((x) => OfferItem.fromJson(x)));

class OfferItem {
  final int id;
  final String customerName;
  final String address;
  final String latitude;
  final String longitude;
  final String serviceArea;
  final String serviceName;
  final String totalCost;
  final String offerDate;

  OfferItem(
      {required this.id,
      required this.customerName,
      required this.address,
      required this.serviceArea,
      required this.latitude,
      required this.longitude,
      required this.serviceName,
      required this.totalCost,
      required this.offerDate});

  factory OfferItem.fromJson(Map<String, dynamic> json) {
    return OfferItem(
      id: json['id'],
      customerName: json['customerName'],
      address: json['address'],
      serviceArea: json['serviceArea'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      serviceName: json['serviceName'],
      totalCost: json['totalCost'],
      offerDate: json['offerDate'],
    );
  }
}
