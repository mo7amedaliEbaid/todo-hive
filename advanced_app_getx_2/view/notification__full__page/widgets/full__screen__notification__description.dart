import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class FullScreenNotificationDescription extends StatelessWidget {
  const FullScreenNotificationDescription({
    Key? key,
    required this.text,
    required this.mainController,
  }) : super(key: key);

  final mainController;
  final String text;
  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      mainController.allFirstWordLetterToUppercase(
        text,
      ),
      maxLines: 5,
      style: TextStyle(
        color: Theme.of(context).primaryColor.withOpacity(.7),
        fontSize: 25,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
