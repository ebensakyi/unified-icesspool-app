class Constants {
  //static const String BASE_URL = "https://app.icesspool.net/api";

  static const String BASE_URL = "http://10.0.2.2:3000/api";
  // static const String BASE_URL = "http://172.30.13.241:3000/api";

  static String LOGIN_API_URL = BASE_URL + "/auth/login/mobile";

  static String AWS_S3_URL =
      "https://icesspool-files.s3.amazonaws.com/uploads/";

  static const String USER_SERVICE_AREA_API_URL =
      BASE_URL + "/user-service-area";
  static const String SERVICES_AVAILABLE_API_URL =
      BASE_URL + "/services-available";

  static const String BIODIGESTER_TRANSACTION_API_URL =
      BASE_URL + "/service-request/biodigester/make-request";

  static const String BIODIGESTER_SERVICES_AVAILABLE_API_URL =
      BASE_URL + "/services-available/biodigester-services";

  static const String BIODIGESTER_PRICING_API_URL =
      BASE_URL + "/pricing/biodigester-service";

  static const String GOOGLE_MAPS_API_KEY =
      "AIzaSyCLc4_aCF6feLCH5bjVlpwGpFSV_y6sQdE";

  static const String DISTRICT_API_URL = "/sanitation-report/district";
  // static const String REPORT_TYPE_API_URL = "/v1/primary-data/report-type";

  static String SANITATION_API_URL = "/sanitation-report";
  static String SIGNUP_API_URL = BASE_URL + "/auth/signup";
  static String VALIDATE_ACCOUNT_API_URL = BASE_URL + "/auth/validate-user";

  static const String INITIATE_PAYMENT_URL = BASE_URL + "/payment/initiate";
  static String PROFILE_API_URL = BASE_URL + "/auth/profile";
  static String FORGET_PASSWORD_API_URL =
      BASE_URL + "/auth/forget-password/mobile";
  static String RESET_PASSWORD_API_URL =
      BASE_URL + "/auth/reset-password/mobile";

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

  static String TIME_SCHEDULE_API_URL = BASE_URL + "/configure/time-schedule";

  static String RESEND_OTP_API_URL = BASE_URL + "/auth/resend-otp";

  static String RATE_SERVICE_API_URL =
      BASE_URL + "/service-request/rate-service";

  static const String UPDATE_TRANSACTION_STATUS_API_URL =
      BASE_URL + "/service-request/update-tx/client";
  static String TRANSACTION_HISTORY_API_URL =
      BASE_URL + "/service-request/transaction-history";

  static const int OFFER_MADE = 1;
  static const int OFFER_ACCEPTED = 2;
  static const int PAYMENT_MADE = 3;
  static const int WORK_STARTED_REQUEST = 4; //SP
  static const int WORK_STARTED = 41; // CL
  static const int WORK_NOT_STARTED = 40; // CL

  static const int WORK_COMPLETED_REQUEST = 5; //SP OR CL

  static const int WORK_COMPLETED = 51; //ADMIN, CL
  static const int WORK_NOT_COMPLETED = 50; //ADMIN, CL

  static const int OFFER_CLOSED = 6; //ADMIN
  static const int OFFER_RATED = 7; // CL
  static const int OFFER_CANCELLED_SP = 8; //SP
  static const int OFFER_CANCELLED_CL = 9; //CL
  static const int OFFER_REASSIGNED = 10;

  static String TOILET_TRUCK_TRANSACTION_API_URL =
      BASE_URL + "/service-request/toilet-truck/make-request";

  static String TOILET_TRUCK_AVAILABLE_API_URL =
      BASE_URL + "/pricing/toilet-truck-service/price";
}
