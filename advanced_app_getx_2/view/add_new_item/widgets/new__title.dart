import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class NewTitle extends StatelessWidget {
  const NewTitle({
    Key? key,
    required this.mainController,
    required this.text,
    this.textAlign,
    this.fontSize = 40,
  }) : super(key: key);
  final String text;
  final mainController;
  final double? fontSize;
  final TextAlign? textAlign;
  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      mainController.allFirstWordLetterToUppercase(text),
      textAlign: textAlign,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: FontWeight.bold,
        color: Theme.of(context).primaryColor,
      ),
    );
  }
}
