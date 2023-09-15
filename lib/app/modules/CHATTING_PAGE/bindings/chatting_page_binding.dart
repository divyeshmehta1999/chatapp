import 'package:get/get.dart';

import '../controllers/chatting_page_controller.dart';

class ChattingPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChattingPageController>(
      () => ChattingPageController(),
    );
  }
}
