import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({Key? key}) : super(key: key);

  @override
  _WalletScreenState createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            alignment: Alignment.center,
            color: Colors.white,
            child: Image.asset(
              "assets/logo/logo.png",
              height: 72,
            ),
          ),
          Divider(),
          Container(
              height: 200,
              child: Lottie.asset("assets/lottie_files/wallet.json")),
          const SizedBox(
            height: 56,
          ),
          Text(
            "Login to digital wallet",
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: Theme.of(context).accentColor,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Container(
            height: 100,
            margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: Colors.grey.shade400, width: 2)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "النفاذ الوطني الموحد",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Theme.of(context).accentColor,
                    fontWeight: FontWeight.w800,
                    fontSize: 18,
                  ),
                ),
                Text(
                  "Log in with your account through \nNational Single Sign-On",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey.shade700,
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
