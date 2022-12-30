import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'app/controllers/auth_controller.dart';
import 'app/routes/app_pages.dart';
import 'app/utils/error_page.dart';
import 'app/utils/loading_page.dart';
import 'app/utils/splash_screen.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  final authC = Get.put(AuthController(), permanent: true);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "Presensi",
      initialRoute: Routes.LOGIN,
      getPages: AppPages.routes,
    );

    // return FutureBuilder(
    //   future: _initialization,
    //   builder: (context, snapshot) {
    //     if (snapshot.hasError) {
    //       return ErrorScreen();
    //     }
    //     if (snapshot.connectionState == ConnectionState.done) {
    //       return FutureBuilder(
    //         future: Future.delayed(const Duration(seconds: 3)),
    //         builder: (context, snapshot) {
    //           if (snapshot.connectionState == ConnectionState.done) {
    //             return Obx(() => GetMaterialApp(
    //                   debugShowCheckedModeBanner: false,
    //                   title: "ChatApp",
    //                   initialRoute: authC.isSkipIntro.isTrue
    //                       ? authC.isAuth.isTrue
    //                           ? Routes.HOME
    //                           : Routes.LOGIN
    //                       : Routes.HOME,
    //                   getPages: AppPages.routes,
    //                 ));
    //           }

    //           return FutureBuilder(
    //             future: authC.firstInitialized(),
    //             builder: (context, snapshot) => const SplashScreen(),
    //           );
    //         },
    //       );
    //     }
    //     return LoadingScreen();
    //   },
    // );
  }
}
