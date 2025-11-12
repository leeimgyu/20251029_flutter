import 'package:ch07_splash_screen/splash_screen/splash_stateful.dart';
import 'package:ch07_splash_screen/splash_screen/splash_stateless.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Splash Demo',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          // child: SplashScreenStateless(),
          child: SplashScreenStateful(),
        ),
      ),
    );
  }
}
