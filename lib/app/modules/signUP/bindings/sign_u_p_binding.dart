import 'package:get/get.dart';

import '../controllers/sign_u_p_controller.dart';

class SignUPBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SignUPController>(
      () => SignUPController(),
    );
  }
}
