import 'package:chatapp/app/modules/home/views/home_view.dart';
import 'package:chatapp/app/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/signin_controller.dart';

class SignIn extends GetView<SignInController> {
  const SignIn({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => SignInController());
    return Scaffold(
        body: SafeArea(
            child: Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Log In To ChatBox',
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Color(0xff3D4A7A)),
          ),
          const Text(
            'Welcome back! Sign in using your social account or email to continue us',
            style: TextStyle(
                fontSize: 14, fontWeight: FontWeight.w300, color: Colors.black),
          ),
          const Text(
            'Your Email',
            style: TextStyle(
                fontSize: 14, fontWeight: FontWeight.w300, color: Colors.black),
          ),
          TextFormField(
            controller: controller.emailController,
            decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20))),
          ),
          const Text(
            'Your Password',
            style: TextStyle(
                fontSize: 14, fontWeight: FontWeight.w300, color: Colors.black),
          ),
          TextFormField(
            controller: controller.passwordController,
            decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20))),
          ),
          TextButton(
              style: TextButton.styleFrom(backgroundColor: Color(0xff3D4A7A)),
              onPressed: () async {
                await Auth().loginEmailPass(
                    email: controller.emailController.text,
                    pass: controller.passwordController.text);
                Get.to(HomeView());
              },
              child: Text(
                'Login',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
              )),
        ],
      ),
    )));
  }
}
