import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';


class Description extends StatelessWidget {
  const Description({
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
      style: TextStyle(
        fontSize: 20,
        color: Theme.of(context).primaryColor.withOpacity(.55),
      ),
      maxLines: 3,
    );
  }
}
