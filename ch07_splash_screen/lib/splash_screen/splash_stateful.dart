import 'dart:async';

import 'package:ch07_splash_screen/splash_screen/mylist.dart';
import 'package:ch07_splash_screen/splash_screen/splash_body.dart';
import 'package:flutter/material.dart';

class SplashScreenStateful extends StatefulWidget {
  const SplashScreenStateful({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreenStateful> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 2), () {
      Navigator.pushReplacement( // push가 아닌 이유 ?
        context,
        MaterialPageRoute(builder: (context) => Mylist()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow,
      body: Container(
        decoration: BoxDecoration(color: Colors.yellow),
        child: SplashBody(),
      ),
    );
  }
}
