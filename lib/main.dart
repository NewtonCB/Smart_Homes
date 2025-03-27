import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:renting_app/dashboard/dashboard_view/main_view/dash_view.dart';
import 'package:renting_app/registration_login/controler/login_verification_screen.dart';
import 'package:renting_app/splash_screens/splashscreen.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:renting_app/posting_page/post_view.dart';
import 'package:renting_app/registration_login/view/login_view.dart';
import 'package:renting_app/dashboard/dashboard_view/dashbord_components/swipe_image/image_model.dart';
import 'package:renting_app/dashboard/dashboard_view/dashbord_components/swipe_image/swiper_controller.dart';
import 'package:renting_app/registration_login/view/registration_view.dart';
import 'package:renting_app/dashboard/dashboard_view/feed_page/feed_page_view.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyChW-v8JQikIRr8Sb44JKNsxrzhESd8h_8",
      authDomain: "houserental-29ec3.firebaseapp.com",
      databaseURL: "https://houserental-29ec3-default-rtdb.firebaseio.com",
      projectId: "houserental-29ec3",
      storageBucket: "houserental-29ec3.appspot.com",
      messagingSenderId: "875998543044",
      appId: "1:875998543044:web:865927853a26dff02ddd91",
      measurementId: "G-RW7TVSMQF3",
    ),
  );

  final SwiperController swiperController = Get.put(SwiperController());
  swiperController.setImages([
    ImageModel(imagePath: 'assets/images/mybg.png'),
    ImageModel(imagePath: 'assets/images/dit77.jpg'),
    ImageModel(imagePath: 'assets/images/prof.jpg'),

  ]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Renting App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white70),
      ),
      home: const SplashScreen(),
      getPages: [
        GetPage(name: '/login', page: () => LoginPage()),
        GetPage(name: '/home', page: () => const DashboardPage()),
        GetPage(name: '/add_photo', page: () => PostingPage()),
        GetPage(name: '/feed', page: () => FeedPage()),
        GetPage(name: '/register', page: () => RegistrationPage()),
        GetPage(name: '/verify_code', page: () => VerificationPage(verificationId: '')), // Handle as needed
      ],
    );
  }
}
