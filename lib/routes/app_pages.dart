import 'package:get/get.dart';
import 'package:icesspool/bindings/single_report_binding.dart';
import 'package:icesspool/views/login_view.dart';
import 'package:icesspool/views/single_report_view.dart';

import '../bindings/home_binding.dart';
import '../bindings/login_binding.dart';
import '../views/home_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.LOGIN;
  static const HOME = Routes.HOME;
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
  ];
}
