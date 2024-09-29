import 'package:get/get.dart';
import 'package:pikemup/bindings/host_binding.dart';

import '../bindings/home_binding.dart';
import '../bindings/root_bindings.dart';
import '../pages/authentication/login.dart';
import '../pages/authentication/otp_verification.dart';
import '../pages/host/host_home_page_bottom_bar.dart';
import '../pages/onboarding/onboarding.dart';
import '../pages/splash/splash.dart';
import '../pages/user/home_page_bottom_bar.dart';
import './app_routes.dart';


class AppPages {
  static final pages = [
    //Common Pages
    GetPage(name: Routes.INITIAL, page: () => Splash(), binding: RootBindings()),
    GetPage(name: Routes.LOGIN, page: () => LoginPage(),binding: RootBindings()),
    // GetPage(name: Routes.FACULTY_LOGIN, page: () => FacultyLoginPage(),binding: RootBindings()),
    GetPage(name: Routes.ONBOARDING, page: () => Onboarding(),binding: RootBindings()),
    GetPage(name: Routes.OTP_VERIFICATION, page: () => OTPVerification()),
    // GetPage(name: Routes.FACULTY_OTP_VERIFICATION, page: () => const FacultyOTPVerification()),

    //General Page
    // GetPage(name: Routes.IMAGE_VIEWER, page:() => ImageViewer()),

    //User Pages
    GetPage(name: Routes.HOME, page: () => HomePageBottomBar(), binding: HomeBinding()),
    GetPage(name: Routes.HOST_HOME, page: () => HostHomePageBottomBar(), binding: HostBinding()),


    //Host Pages
  ];
}
