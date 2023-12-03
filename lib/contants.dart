class Constants {
  static const String BASE_URL = "https://dashboard.esicapps.org/api";

  // static const String BASE_URL = "http://10.0.2.2:3000/api";
  // static const String REGION_API_URL = "/v1/primary-data/region";

  static const String DISTRICT_API_URL = "/sanitation-report/district";
  // static const String REPORT_TYPE_API_URL = "/v1/primary-data/report-type";

  static String SANITATION_API_URL = "/sanitation-report";
  static String LOGIN_API_URL = "/sanitation-report/signup-login";
  static String AWS_S3_URL =
      "https://esicapps-images.s3.eu-west-2.amazonaws.com/";

  static List REPORT_CATEGORY = [
    "",
    {"name": "Garbage Accumulation"},
    {"name": "Overflowing Dumpsters"},
    {"name": "Illegal Dumping"},
    {"name": "Contaminated Water Sources"},
    {"name": "Sewage Problems"},
    {"name": "Inadequate Public Toilets"},
    {"name": "Chemical Spills"},
    {"name": "Mosquito Breeding Sites"},
  ];

  static List REPORT_STATUS = [
    {"name": "Pending"},
    {"name": "Completed"},
    {"name": "In progress"},
  ];

  static String REPORT_CATEGORY_API_URL = "/sanitation-report/report-category";
}
