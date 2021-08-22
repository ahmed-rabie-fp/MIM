import 'package:flutter/material.dart';

class CustomButton extends StatefulWidget {
  final String text;
  final bool isHighlighted;

  CustomButton({Key? key, required this.text, required this.isHighlighted})
      : super(key: key);

  @override
  _CustomButtonState createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {},
      child: Text(
        widget.text,
        style: TextStyle(
          color: widget.isHighlighted
              ? Colors.white
              : Theme.of(context).primaryColor,
          fontWeight: FontWeight.w600,
          fontSize: widget.isHighlighted ? 18 : 14,
        ),
      ),
      style: ButtonStyle(
          backgroundColor: widget.isHighlighted
              ? MaterialStateProperty.all(Theme.of(context).primaryColor)
              : null,
          side: widget.isHighlighted
              ? null
              : MaterialStateProperty.all(
                  BorderSide(color: Theme.of(context).primaryColor, width: 2),
                ),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          padding: MaterialStateProperty.all(
              const EdgeInsets.symmetric(horizontal: 24))),
    );
  }
}
