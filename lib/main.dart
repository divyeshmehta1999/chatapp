import 'package:chatapp/app/services/firebasemessagingutils.dart';
import 'package:chatapp/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:stacked_firebase_auth/stacked_firebase_auth.dart';

import 'app/routes/app_pages.dart';
import 'app/services/auth.dart';
import 'app/services/storage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseMessagingUtils().initNotification();
  await initGetServices();

  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp],
  );

  return runApp(GestureDetector(
    onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
    child: GetMaterialApp(
      // theme: AppTheme.light,
      // darkTheme: AppTheme.dark,
      defaultTransition: Transition.fade,
      //smartManagement: SmartManagement.full,
      debugShowCheckedModeBanner: false,
      locale: const Locale('en', 'US'),

      initialRoute: AppPages.INITIAL,
      //initialBinding: SplashBinding(),
      getPages: AppPages.routes,
    ),
  ));
}

Future<void> initGetServices() async {
  await Get.putAsync<GetStorageService>(() => GetStorageService().initState());
  await Get.putAsync<Auth>(() async => Auth());
  await Get.put(FirebaseAuthenticationService());
}
