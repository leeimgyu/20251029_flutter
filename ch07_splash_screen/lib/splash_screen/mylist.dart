import 'package:flutter/material.dart';

class Mylist extends StatelessWidget {
  const Mylist({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Splash Demo',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
          child: Scaffold(
            appBar: AppBar(
              title: const Text('App Bar'),
              centerTitle: true,
              backgroundColor: Colors.yellow,
            ),
            body: Center(child: Text("My List")),
          ),
        ),
      ),
    );
  }
}
