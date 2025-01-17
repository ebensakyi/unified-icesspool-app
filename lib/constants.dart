class Constants {
  //static const String BASE_URL = "https://app.icesspool.net/api";

  // static const String BASE_URL = "http://10.0.2.2:3000/api";
  //static const String BASE_URL = "http://192.168.8.100:3000/api";
  //static const String BASE_URL = "http://172.30.13.241:3000/api";
  static const String BASE_URL = "http://192.168.8.100:3000/api";

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

  static String TIME_SCHEDULE_API_URL = BASE_URL + "/configure/time-schedule";

  static String RESEND_OTP_API_URL = BASE_URL + "/auth/resend-otp";

  static String RATE_SERVICE_API_URL =
      BASE_URL + "/service-request/rate-service";

  static const String UPDATE_TRANSACTION_STATUS_API_URL =
      BASE_URL + "/service-request/update-transaction/client";
  static String TRANSACTION_HISTORY_API_URL =
      BASE_URL + "/service-request/transaction-history";

  static const int OFFER_MADE = 1;
  static const int OFFER_ACCEPTED = 2;
  static const int OFFER_IN_PROGRESS = 3;
  static const int OFFER_COMPLETED = 4;
  static const int OFFER_CLOSED = 5;

  static const int OFFER_RATED = 6; // CL
  static const int OFFER_CANCELLED_SP = 7; //SP
  static const int OFFER_CANCELLED_CL = 8; //CL
  static const int OFFER_REASSIGNED = 9;

//Requests and Approvals
  static const int WORK_STARTED_REQUEST = 20; //SP
  static const int WORK_STARTED = 21; // CL
  static const int WORK_NOT_STARTED = 22; // CL

  static const int WORK_COMPLETED_REQUEST = 30; //SP OR CL
  static const int WORK_COMPLETED = 31; //ADMIN, CL
  static const int WORK_NOT_COMPLETED = 32; //ADMIN, CL

  // static const int OFFER_CLOSE_REQUEST_CL = 40; // CL
  // static const int OFFER_CLOSE_REQUEST_SP = 41; //SP

  static String TOILET_TRUCK_TRANSACTION_API_URL =
      BASE_URL + "/service-request/toilet-truck/make-request";

  static String TOILET_TRUCK_AVAILABLE_API_URL =
      BASE_URL + "/pricing/toilet-truck-service/price";

  static String CHANGE_PASSWORD_API_URL = BASE_URL + "/auth/change-password";

  static String FCM_API_URL = BASE_URL + "/auth/fcm";

  static String WATER_TYPES_API_URL = BASE_URL + "/configure/water-type";

  static String WATER_TANKER_AVAILABLE_API_URL =
      BASE_URL + "/configure/truck-classification";

  static String WATER_TRANSACTION_API_URL =
      BASE_URL + "/service-request/water-tanker/make-request";

  static String SP_API_URL = BASE_URL + "/user/service-provider";

  static var DEVICE = "MOBILE";

  static String UPDATE_TRANSACTION_SUB_STATUS_API_URL =
      BASE_URL + "/service-request/update-transaction/client/tx-substatus";
}
