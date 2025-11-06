import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextWidgetExample extends StatelessWidget {
  const TextWidgetExample({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text(
            "Hello Flutter, 쿠키런",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w700,
              fontFamily: 'CookieRun',
              color: Colors.blue,
            ),
          ),
        ),
      ),
    );
  }
}