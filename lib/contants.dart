class Constants {
  //static const String BASE_URL = "https://new.icesspool.net/api";

  // static const String BASE_URL = "http://10.0.2.2:3000/api";
  static const String BASE_URL = "http://192.168.8.100:3000/api";

  static String LOGIN_API_URL = BASE_URL + "/auth/login/mobile";

  static String AWS_S3_URL =
      "https://icesspool-files.s3.amazonaws.com/uploads/";

  static const String USER_SERVICE_AREA_API_URL =
      BASE_URL + "/user/user-service-area";
  static const String SERVICES_AVAILABLE_API_URL =
      BASE_URL + "/user/services-available";

  static const String BIODIGESTER_TRANSACTION_API_URL =
      BASE_URL + "/transaction/biodigester/transaction/make-request";

  static const String CANCELLED_BY_CUSTOMER = "10";
  static const String UPDATE_TRANSACTION_STATUS_API_URL =
      BASE_URL + "/services/update-transaction-status";
  static const String BIODIGESTER_SERVICES_AVAILABLE_API_URL =
      BASE_URL + "/user/biodigester-services-available";

  static const String BIODIGESTER_PRICING_API_URL =
      BASE_URL + "/services/biodigester/pricing";

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

  static List REPORT_STATUS = [
    {"name": "Pending"},
    {"name": "Completed"},
    {"name": "In progress"},
  ];

  static String TIME_SCHEDULE_API_URL = BASE_URL + "/config/time-schedule";

  static String RESEND_OTP_API_URL = BASE_URL + "/auth/resend-otp";

  static String RATE_SERVICE_API_URL = BASE_URL + "/services/rate-service";

  static String RESPONSE_CLAIM_API_URL = BASE_URL + "/client-tx-update";

  static const int OFFER_MADE = 1;
  static const int OFFER_ACCEPTED = 2;
  static const int PAYMENT_MADE = 3;
  static const int WORK_STARTED_REQUEST = 4; //SP
  static const int WORK_STARTED = 41; // CL
  static const int WORK_NOT_STARTED = 40; // CL

  static const int WORK_COMPLETED_REQUEST = 6; //SP OR CL

  static const int WORK_COMPLETED = 51; //ADMIN, CL
  static const int WORK_NOT_COMPLETED = 50; //ADMIN, CL

  static const int OFFER_CLOSED = 6; //ADMIN
  static const int OFFER_RATED = 7; // CL
  static const int OFFER_CANCELLED_SP = 8; //SP
  static const int OFFER_CANCELLED_CL = 9; //CL
  static const int OFFER_REASSIGNED = 10;
}
