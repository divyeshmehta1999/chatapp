import 'package:get/get.dart';

import '../modules/CHATTING_PAGE/bindings/chatting_page_binding.dart';
import '../modules/CHATTING_PAGE/views/chatting_page_view.dart';
import '../modules/Login/bindings/login_binding.dart';
import '../modules/Login/views/login_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/signUP/bindings/sign_u_p_binding.dart';
import '../modules/signUP/views/sign_u_p_view.dart';
import '../modules/signin/bindings/signin_binding.dart';
import '../modules/signin/views/signin_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.SPLASH,
      page: () => SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
        name: _Paths.SIGNUP,
        page: () => const SignIn(),
        binding: SigninBinding()),
    GetPage(
      name: _Paths.SIGN_U_P,
      page: () => const SignUPView(),
      binding: SignUPBinding(),
    ),
    GetPage(
      name: _Paths.CHATTING_PAGE,
      page: () => ChattingPageView('', ''),
      binding: ChattingPageBinding(),
    ),
  ];
}
