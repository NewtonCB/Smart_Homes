import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:renting_app/splash_screens/splashscreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:renting_app/posting_page/post_view.dart';
import 'package:renting_app/dashboard/presentation/pages/home/view/home.dart';
import 'package:shimmer/main.dart';

void main()  async{
  // Firebase initialization remains unchanged
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
    measurementId: "G-RW7TVSMQF3"

    )
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Renting App',
      theme: ThemeData(
        colorScheme:ColorScheme.fromSeed(seedColor: Colors.white70)
        // You can add any other theme configurations here
      ),
      home: const SplashScreen(),
      getPages: [
        GetPage(name: '/home', page: () => const ScreenHome()),
        // GetPage(name: '/newsFeed', page: () => ChatsScreen()),
        GetPage(name: '/add_photo', page: () =>  PostingPage()),
        // GetPage(name: '/profile', page: () => MessagesScreen()),
        // GetPage(name: '/back', page: () => SearchScreen()),
      ],
    );
  }
}

