import 'dart:developer';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:icesspool/controllers/home_controller.dart';
import 'package:icesspool/model/reportType.dart';

import '../contants.dart';
import '../model/district.dart';
import '../model/region.dart';
import '../model/report.dart';
import '../model/reportCategory.dart';

class DataServices {
  // static Future<List<Region>> getRegions() async {
  //   try {
  //     var client = http.Client();

  //     var uri = Uri.parse(Constants.BASE_URL + Constants.REGION_API_URL);
  //     var response = await client.get(uri);
  //     if (response.statusCode == 200) {
  //       var json = response.body;
  //       return RegionFromJson(json);
  //     }
  //     return [];
  //   } catch (e) {
  //     log(e.toString());
  //     return [];
  //   }
  // }

  static Future<List<District>> getDistricts() async {
    try {
      var client = http.Client();
      var uri = Uri.parse(Constants.BASE_URL + Constants.DISTRICT_API_URL);

      var response = await client.get(uri);
      if (response.statusCode == 200) {
        var json = response.body;
        return DistrictFromJson(json);
      }
      return [];
    } catch (e) {
      inspect(e.toString());
      return [];
    }
  }

  static Future<List<Report>> getReports(userId) async {
    try {
      var client = http.Client();
      var uri = Uri.parse(Constants.BASE_URL +
          Constants.SANITATION_API_URL +
          "?userId=$userId");

      var response = await client.get(uri);
      if (response.statusCode == 200) {
        var json = response.body;

        return ReportFromJson(json);
      }
      return [];
    } catch (e) {
      inspect(e);
      return [];
    }
  }

  static Future<List<ReportCategory>> getReportCategories() async {
    try {
      var client = http.Client();
      var uri =
          Uri.parse(Constants.BASE_URL + Constants.REPORT_CATEGORY_API_URL);

      var response = await client.get(uri);
      inspect(response);
      if (response.statusCode == 200) {
        var json = response.body;

        return ReportCategoryFromJson(json);
      }
      return [];
    } catch (e) {
      inspect(e);
      return [];
    }
  }

  // static Future<List<ReportType>> getReportTypes() async {
  //   try {
  //     var client = http.Client();
  //     var uri = Uri.parse(Constants.BASE_URL + Constants.REPORT_TYPE_API_URL);

  //     var response = await client.get(uri);
  //     if (response.statusCode == 200) {
  //       var json = response.body;
  //       return ReportTypeFromJson(json);
  //     }
  //     return [];
  //   } catch (e) {
  //     log(e.toString());
  //     return [];
  //   }
  // }
}
