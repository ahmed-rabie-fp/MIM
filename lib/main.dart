import 'package:flutter/material.dart';
import 'package:mim_prototype/screens/splash_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MIM Prototype',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0XFFAA8038),
        accentColor: const Color(0XFF2F3281),
        fontFamily: "Nunito",
      ),
      home: SplashScreen(),
    );
  }
}
