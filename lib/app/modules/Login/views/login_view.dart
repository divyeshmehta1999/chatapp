import 'package:chatapp/app/modules/signUP/views/sign_u_p_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../services/auth.dart';
import '../../signin/views/signin_view.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Get.put(LoginController());
    return Scaffold(
        body: SafeArea(
      child: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    colors: [Color(0xff43116A), Color(0xff68E1FD)])),
          ),
          Column(
            children: [
              const Text(
                'Connect \nfriends \neasily & \nquickly',
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 70,
                    color: Colors.white),
              ),
              const Text(
                'Our chat app is the perfect way to stay connected with friends and family.',
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    color: Colors.white),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () async {
                      await Auth().google();
                    },
                    child: Container(
                      height: 48,
                      width: 48,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: Colors.grey),
                      child: Image.asset(
                          'assets/images/Google_Pay-Logo.wine (1).png'),
                    ),
                  ),
                  GestureDetector(
                    //onTap: Auth().facebook(),
                    child: Container(
                      height: 48,
                      width: 48,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: Colors.grey),
                      child: Image.asset(
                          'assets/images/Facebook-f_Logo-Blue-Logo.wine.png'),
                    ),
                  ),
                  GestureDetector(
                    //onTap: Auth()(),
                    child: Container(
                      height: 48,
                      width: 48,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: Colors.grey),
                      child: Image.asset(
                          'assets/images/Apple_Inc.-Logo.wine (1).png'),
                    ),
                  ),
                ],
              ),
              const Text(
                'Or',
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.w500),
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20))),
                  onPressed: () {
                    Get.to(SignUPView());
                  },
                  child: const Text(
                    'Sign Up With Email',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  )),
              TextButton(
                  onPressed: () {
                    Get.to(SignIn());
                  },
                  child: const Text(
                    'Existing Account? LogIn.',
                    style: TextStyle(color: Colors.white),
                  ))
            ],
          )
        ],
      ),
    ));
  }
}
