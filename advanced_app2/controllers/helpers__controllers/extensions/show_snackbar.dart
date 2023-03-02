import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oktoast/oktoast.dart';

import '../../../utils/extensions/string_extension.dart';
import '../dialogs__controller.dart';


extension ShowSnackbarExtension on DialogsController {
    void showSnackbar(String title) {
    showToastWidget(
      Container(
        padding: const EdgeInsets.only(
          top: 14,
          bottom: 14,
          left: 20,
          right: 10,
        ),
        margin: const EdgeInsets.symmetric(horizontal: 30),
        decoration: BoxDecoration(
          color: Theme.of(Get.overlayContext!).primaryColor,
          borderRadius: BorderRadius.circular(40),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.check,
              color: Theme.of(Get.overlayContext!).backgroundColor,
            ),
            const SizedBox(
              width: 15,
            ),
            Expanded(
              child: Text(
                title.capitalizeAllWordsFirstLetter(),
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  color: Theme.of(Get.overlayContext!).backgroundColor,
                  fontSize: 14,
                ),
                textAlign: TextAlign.left,
                maxLines: 2,
              ),
            ),
            const SizedBox(
              width: 15,
            ),
          ],
        ),
      ),
      duration: const Duration(seconds: 2),
      textDirection: TextDirection.ltr,
      position: ToastPosition.top,
    );
  }
}