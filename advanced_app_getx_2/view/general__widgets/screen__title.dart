import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class ScreenTitle extends StatelessWidget {
  const ScreenTitle({Key? key, required this.title, required this.mainController})
      : super(key: key);
  final mainController;
  final String title;
  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      mainController.allFirstWordLetterToUppercase(title),
      maxLines: 2,
      style: const TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
