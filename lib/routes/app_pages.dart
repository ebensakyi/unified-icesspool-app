import 'package:get/get.dart';

import '../app/modules/complete-payment/bindings/complete_payment_binding.dart';
import '../app/modules/complete-payment/views/complete_payment_view.dart';
import '../app/modules/onboarding/bindings/onboarding_binding.dart';
import '../app/modules/onboarding/views/onboarding_view.dart';
import '../app/modules/services-blog/bindings/services_blog_binding.dart';
import '../app/modules/services-blog/views/services_blog_view.dart';
import '../app/modules/services/bindings/services_binding.dart';
import '../app/modules/services/views/services_view.dart';
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
      //transition: Transition.rightToLeftWithFade,
      //transitionDuration: Duration(milliseconds: 500),
    ),
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
      //transition: Transition.rightToLeftWithFade,
      //transitionDuration: Duration(milliseconds: 500),
    ),
    GetPage(
      name: _Paths.SINGLE_REPORT,
      page: () => SingleReportView(),
      binding: SingleReportBinding(),
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
  ];
}
