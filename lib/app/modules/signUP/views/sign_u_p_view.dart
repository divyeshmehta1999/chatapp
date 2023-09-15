import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../services/auth.dart';
import '../controllers/sign_u_p_controller.dart';

class SignUPView extends GetView<SignUPController> {
  const SignUPView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(SignUPController());
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Sign up with Email',
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                  color: Color(0xff3D4A7A)),
            ),
            const Text(
              'Get chatting with friends and family today by signing up for our chat app!',
              style: TextStyle(
                  fontWeight: FontWeight.w300,
                  fontSize: 14,
                  color: Colors.black),
            ),
            const Text(
              'Your Name',
              style: TextStyle(
                  fontWeight: FontWeight.w300,
                  fontSize: 14,
                  color: Colors.black),
            ),
            TextFormField(
              controller: controller.namecontroller,
            ),
            const Text(
              'Your Email',
              style: TextStyle(
                  fontWeight: FontWeight.w300,
                  fontSize: 14,
                  color: Colors.black),
            ),
            TextFormField(
              controller: controller.emailcontroller,
            ),
            const Text(
              'Your Password',
              style: TextStyle(
                  fontWeight: FontWeight.w300,
                  fontSize: 14,
                  color: Colors.black),
            ),
            TextFormField(
              controller: controller.passwordcontroller,
            ),
            const Text(
              'Confirm Password',
              style: TextStyle(
                  fontWeight: FontWeight.w300,
                  fontSize: 14,
                  color: Colors.black),
            ),
            TextFormField(
              controller: controller.confirmpasswordcontroller,
            ),
            TextButton(
                onPressed: () {
                  Auth().createEmailPass(
                      email: controller.emailcontroller.text,
                      pass: controller.passwordcontroller.text);
                },
                child: Text('Create Account'))
          ],
        ),
      ),
    ));
  }
}
