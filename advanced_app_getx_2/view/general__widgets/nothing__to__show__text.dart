import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/main__controller.dart';

class NothingToShow extends GetView<MainController> {
  const NothingToShow({
    Key? key,
    required this.text,
    this.margin = const EdgeInsets.only(right: 20, top: 150),
  }) : super(key: key);

  final String text;
  final EdgeInsets margin;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: margin,
        child: AutoSizeText(
controller.allFirstWordLetterToUppercase(text),
          style: TextStyle(
            color: Theme.of(context).primaryColor.withOpacity(.25),
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
          maxLines: 2,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
