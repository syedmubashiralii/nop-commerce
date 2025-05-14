import 'package:get/get.dart';
import 'package:nop_commerce/app/bindings/home_binding.dart';
import 'package:nop_commerce/app/bindings/settings_binding.dart';
import 'package:nop_commerce/app/views/home_view.dart';
import 'package:nop_commerce/app/views/settings/login_view.dart';
import 'package:nop_commerce/app/views/splash_view.dart';


part 'app_routes.dart';

class AppPages {
  AppPages._();
  static const INITIAL = Routes.SPLASH;

  static final routes = [
     GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashView(),
      // binding: HomeBinding(),
    ),

    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: SettingsBinding(),
    ),
   
  ];
}
