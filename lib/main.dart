import 'package:flutter/material.dart';
import 'package:mim_prototype/providers/news_provider.dart';
import 'package:mim_prototype/screens/splash_screen.dart';
import 'package:provider/provider.dart';
void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<NewsProvider>.value(value: NewsProvider()),
    ],
      child: MyApp()));
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
