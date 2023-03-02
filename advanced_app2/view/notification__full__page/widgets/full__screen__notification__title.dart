import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class FullScreenNotificationTitle extends StatelessWidget {
  const FullScreenNotificationTitle({
    Key? key,
    required this.mainController,
    required this.text,
  }) : super(key: key);

  final mainController;
  final String text;
  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      mainController.allFirstWordLetterToUppercase(text),
      maxLines: 2,
      style: const TextStyle(
        fontSize: 35,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
