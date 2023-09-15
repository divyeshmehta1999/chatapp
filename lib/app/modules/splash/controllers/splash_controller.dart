import 'package:get/get.dart';

import '../../Login/views/login_view.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    Future.delayed(Duration(seconds: 2), () {
      // Navigate to the next screen (e.g., your home screen)
      Get.off(LoginView()); // Replace with your route name
    });
    super.onInit();
  }
}
