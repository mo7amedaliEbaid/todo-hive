// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';

import '../../utils/AppColors.dart';
import '../../utils/extensions/string_extension.dart';

class DialogTextButton extends StatelessWidget {
  const DialogTextButton({
    Key? key,
    required this.onPressed,
    required this.text,
    required this.hasBackground,
    this.forDelete = false,
  }) : super(key: key);

  // Variables
  final String text;
  final void Function()? onPressed;
  final bool hasBackground, forDelete;
  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: hasBackground
              ? forDelete
                  ? Colors.red[800]!.withOpacity(.15)
                  : AppColors.darkBlack
              : Colors.transparent,
          primary: hasBackground
              ? forDelete
                  ? Colors.red[800]
                  : AppColors.lightGrey
              : Theme.of(context).primaryColor,
        ),
        onPressed: onPressed,
        child: Text(
          text.capitalizeAllWordsFirstLetter(),
          style: TextStyle(
            color: hasBackground
                ? forDelete
                    ? Colors.red[800]
                    : AppColors.white
                : AppColors.darkBlack.withOpacity(.6),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
