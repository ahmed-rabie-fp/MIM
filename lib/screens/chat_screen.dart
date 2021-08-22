import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mim_prototype/custom_widgets/custom_button.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child: Column(
          children: [
            const SizedBox(
              height: 72,
            ),
            Lottie.asset(
              "assets/lottie_files/login.json",
              height: 256,
            ),
            const SizedBox(
              height: 56,
            ),
            Text(
              "Please you have to login first",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).accentColor,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            CustomButton(
              text: "Login",
              isHighlighted: true,
            )
          ],
        ),
      ),
    );
  }
}
