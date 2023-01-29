import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pyc/screens/route.dart';
import 'package:pyc/screens/splash/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'PYC',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        backgroundColor: Colors.white,
      ),
      getPages: routes,
      home: const SplashScreen(),
    );
  }
}
