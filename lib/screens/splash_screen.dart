import 'package:flutter/material.dart';
import 'package:mim_prototype/screens/main_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void didChangeDependencies() {
    _navigateToMainScreen();
    super.didChangeDependencies();
  }

  /// Navigate to [MainScreen] after delaying time in [SplashScreen] for 2 second.
  void _navigateToMainScreen() {
    Future.delayed(Duration(seconds: 2))
        .then((value) => Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => MainScreen(),
            )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        alignment: Alignment.center,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 64),
          child: Image.asset(
            "assets/logo/logo.png",
          ),
        ),
      ),
    );
  }
}
