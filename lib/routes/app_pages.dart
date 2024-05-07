import 'package:get/get.dart';

import '../app/modules/about/bindings/about_binding.dart';
import '../app/modules/about/views/about_view.dart';
import '../app/modules/change-password/bindings/change_password_binding.dart';
import '../app/modules/change-password/views/change_password_view.dart';
import '../app/modules/complete-payment/bindings/complete_payment_binding.dart';
import '../app/modules/complete-payment/views/complete_payment_view.dart';
import '../app/modules/forget-password/bindings/forget_password_binding.dart';
import '../app/modules/forget-password/views/forget_password_view.dart';
import '../app/modules/forgotten-password/bindings/forgotten_password_binding.dart';
import '../app/modules/forgotten-password/views/forgotten_password_view.dart';
import '../app/modules/help/bindings/help_binding.dart';
import '../app/modules/help/views/help_view.dart';
import '../app/modules/login/bindings/login_binding.dart';
import '../app/modules/login/views/login_view.dart';
import '../app/modules/notification/bindings/notification_binding.dart';
import '../app/modules/notification/views/notification_view.dart';
import '../app/modules/onboarding/bindings/onboarding_binding.dart';
import '../app/modules/onboarding/views/onboarding_view.dart';
import '../app/modules/privacy/bindings/privacy_binding.dart';
import '../app/modules/privacy/views/privacy_view.dart';
import '../app/modules/profile/bindings/profile_binding.dart';
import '../app/modules/profile/views/profile_view.dart';
import '../app/modules/register/bindings/register_binding.dart';
import '../app/modules/register/views/register_view.dart';
import '../app/modules/reset-password/bindings/reset_password_binding.dart';
import '../app/modules/reset-password/views/reset_password_view.dart';
import '../app/modules/safety/bindings/safety_binding.dart';
import '../app/modules/safety/views/safety_view.dart';
import '../app/modules/services/bindings/services_binding.dart';
import '../app/modules/services/views/services_view.dart';
import '../app/modules/setting/bindings/setting_binding.dart';
import '../app/modules/setting/views/setting_view.dart';
import '../app/modules/toilet-truck/bindings/toilet_truck_binding.dart';
import '../app/modules/toilet-truck/views/toilet_truck_view.dart';
import '../app/modules/transaction-history/bindings/transaction_history_binding.dart';
import '../app/modules/transaction-history/views/transaction_history_view.dart';
import '../app/modules/water-tanker/bindings/water_tanker_binding.dart';
import '../app/modules/water-tanker/views/water_tanker_view.dart';
import '../bindings/home_binding.dart';
import '../bindings/login_binding.dart';
import '../bindings/single_report_binding.dart';
import '../views/home_view.dart';
import '../views/login_view.dart';
import '../views/single_report_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  // static const INITIAL = Routes.HOME; //Routes.LOGIN;
  static const INITIAL = Routes.LOGIN;

  static const HOME = Routes.HOME;
  static const ONBOARDING = Routes.ONBOARDING;

  static const SINGLE_REPORT = Routes.SINGLE_REPORT;

  static final routes = [
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
      //transition: Transition.rightToLeftWithFade,
      //transitionDuration: Duration(milliseconds: 500),
    ),

    GetPage(
      name: _Paths.COMPLETE_PAYMENT,
      page: () => const CompletePaymentView(),
      binding: CompletePaymentBinding(),
    ),
    // GetPage(
    //   name: _Paths.SERVICES_BLOG,
    //   page: () => const ServicesBlogView(),
    //   binding: ServicesBlogBinding(),
    // ),
    GetPage(
      name: _Paths.SERVICES,
      page: () => const ServicesView(),
      binding: ServicesBinding(),
    ),
    GetPage(
      name: _Paths.ONBOARDING,
      page: () => const OnboardingView(),
      binding: OnboardingBinding(),
    ),
    GetPage(
      name: _Paths.SETTING,
      page: () => const SettingView(),
      binding: SettingBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.NOTIFICATION,
      page: () => const NotificationView(),
      binding: NotificationBinding(),
    ),
    GetPage(
      name: _Paths.PRIVACY,
      page: () => const PrivacyView(),
      binding: PrivacyBinding(),
    ),
    GetPage(
      name: _Paths.SAFETY,
      page: () => const SafetyView(),
      binding: SafetyBinding(),
    ),
    GetPage(
      name: _Paths.HELP,
      page: () => const HelpView(),
      binding: HelpBinding(),
    ),
    GetPage(
      name: _Paths.ABOUT,
      page: () => const AboutView(),
      binding: AboutBinding(),
    ),
    GetPage(
      name: _Paths.FORGET_PASSWORD,
      page: () => ForgetPasswordView(),
      binding: ForgetPasswordBinding(),
    ),
    GetPage(
      name: _Paths.RESET_PASSWORD,
      page: () => ResetPasswordView(),
      binding: ResetPasswordBinding(),
    ),
    GetPage(
      name: _Paths.TRANSACTION_HISTORY,
      page: () => TransactionHistoryView(),
      binding: TransactionHistoryBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER,
      page: () => RegisterView(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: _Paths.TOILET_TRUCK,
      page: () => ToiletTruckView(),
      binding: ToiletTruckBinding(),
    ),
    GetPage(
      name: _Paths.WATER_TANKER,
      page: () => const WaterTankerView(),
      binding: WaterTankerBinding(),
    ),
    GetPage(
      name: _Paths.FORGOTTEN_PASSWORD,
      page: () => ForgottenPasswordView(),
      binding: ForgottenPasswordBinding(),
    ),
    GetPage(
      name: _Paths.CHANGE_PASSWORD,
      page: () => ChangePasswordView(),
      binding: ChangePasswordBinding(),
    ),
  ];
}
