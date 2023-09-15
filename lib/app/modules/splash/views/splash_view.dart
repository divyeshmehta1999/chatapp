import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Get.put(SplashController());
    return Scaffold(
        body: Stack(
      children: [
        Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Color(0xff43116A), Color(0xff68E1FD)])),
        ),
        Center(
          child: Text(
            'TextIT!',
            style: TextStyle(
                fontSize: 50, fontWeight: FontWeight.w500, color: Colors.white),
          ),
        )
      ],
    ));
  }
}
