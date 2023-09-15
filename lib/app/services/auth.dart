import 'dart:developer';

import 'package:chatapp/app/modules/home/views/home_view.dart';
import 'package:chatapp/app/services/snackbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:stacked_firebase_auth/stacked_firebase_auth.dart';

import 'dialog_helper.dart';
import 'storage.dart';

class Auth extends GetxService {
  final auth = FirebaseAuthenticationService();
  final _facebookLogin = FacebookAuth.instance;
  AuthCredential? _pendingCredential;
  final _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<bool> google() async {
    DialogHelper.showLoading();
    bool status = false;
    await auth.signInWithGoogle().then((value) async {
      if (!value.hasError) {
        await handleGetContact();
        status = true;
        print('succecc');
        Get.off(HomeView());
      } else {
        showMySnackbar(msg: value.errorMessage!);
      }
    });
    DialogHelper.hideDialog();
    return status;
  }

  apple() async {
    //TODO: do the required setup mentioned in https://pub.dev/packages/sign_in_with_apple
    final result = await auth
        .signInWithApple(
            //TODO: add your own handler id from firebase console
            appleRedirectUri:
                'https://stacked-firebase-auth-test.firebaseapp.com/__/auth/handler',
            appleClientId: '')
        .then((value) async {
      await handleGetContact();
    });
    print('Apple : ${await result.user?.getIdToken()}');
  }

  Future<bool> loginEmailPass(
      {required String email, required String pass}) async {
    DialogHelper.showLoading();
    bool status = false;
    await auth.loginWithEmail(email: email, password: pass).then((value) async {
      if (!value.hasError) {
        if (FirebaseAuth.instance.currentUser!.emailVerified) {
          await handleGetContact();
          status = true;
        } else {
          showMySnackbar(msg: 'Please verify your Email First');
        }
      } else {
        showMySnackbar(msg: value.errorMessage!);
      }
    });
    DialogHelper.hideDialog();
    return status;
  }

  Future<bool> createEmailPass(
      {required String email, required String pass}) async {
    DialogHelper.showLoading();
    bool status = false;
    await auth
        .createAccountWithEmail(email: email, password: pass)
        .then((value) async {
      _firestore.collection('user').add({'email': email, 'pass': pass});
      Get.offAll(HomeView());
      if (!value.hasError) {
        await handleGetContact();
        status = true;
      } else {
        showMySnackbar(msg: value.errorMessage!);
      }
    });
    DialogHelper.hideDialog();
    return status;
  }

//phone number with country code
  mobileOtp({required String phoneno}) async {
    await auth.requestVerificationCode(
      phoneNumber: '+91' + phoneno,
      onCodeSent: (verificationId) => print(verificationId),
    );
  }

  verifyMobileOtp({required String otp}) async {
    final result = await auth.authenticateWithOtp(otp).then((value) async {
      await handleGetContact();
    });
    print('Mobile Otp : ${await result.user?.getIdToken()}');
  }

  facebook() async {
    //TODO: do the required setup mentioned in https://pub.dev/packages/flutter_facebook_auth
    final result = await signInWithFacebook().then((value) async {
      await handleGetContact();
    });
    print('Facebook : ${await result.user?.getIdToken()}');
  }

  Future<FirebaseAuthenticationResult> signInWithFacebook() async {
    try {
      LoginResult fbLogin = await _facebookLogin.login();
      // log?.v('Facebook Sign In complete. \naccessToken:${accessToken.token}');

      final OAuthCredential facebookCredentials =
          FacebookAuthProvider.credential(fbLogin.accessToken!.token);

      var result =
          await _firebaseAuth.signInWithCredential(facebookCredentials);

      // Link the pending credential with the existing account
      if (_pendingCredential != null) {
        await result.user?.linkWithCredential(_pendingCredential!);
      }

      return FirebaseAuthenticationResult(user: result.user);
    } catch (e) {
      // log?.e(e);
      return FirebaseAuthenticationResult.error(errorMessage: e.toString());
    }
  }

  Future<void> handleGetContact() async {
    final mytoken = await _firebaseAuth.currentUser!.getIdToken(true);
    final fireUid = _firebaseAuth.currentUser!.uid;

    Get.find<GetStorageService>().encjwToken = mytoken!;
    //Get.find<GetStorageService>().setFirebaseUid = fireUid;
    log(Get.find<GetStorageService>().encjwToken);
    //debugPrint('i am user id${Get.find<GetStorageService>().getFirebaseUid}');
  }

  Future<void> logOutUser() async {
    DialogHelper.showLoading();
    // erase the user's token and data in GetStorageService
    Get.find<GetStorageService>().logout();
    // firbase logout
    auth.logout();
    // navigate to login page
    // await Get.offAllNamed(Routes.LOGIN);
    await DialogHelper.hideDialog();
  }
}
