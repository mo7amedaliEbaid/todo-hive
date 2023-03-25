import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../../../utils/AppColors.dart';
import '../../../utils/extensions/string_extension.dart';
import '../../../view/general__widgets/dialog__text__button.dart';
import '../dialogs__controller.dart';

extension ShowInfoDialogExtension on DialogsController {
   /// Show a info dialog
  void showInfoDialog(String infoTitle, String infoText) {
    Get.defaultDialog(
      title: "",
      backgroundColor: AppColors.lightGrey,
      radius: 5,
      contentPadding: const EdgeInsets.only(right: 20),
      content: RepaintBoundary(
        child: Container(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              AutoSizeText(
                infoTitle.capitalizeAllWordsFirstLetter(),
                style: TextStyle(
                  color: AppColors.darkBlack,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 2,
              ),
              const SizedBox(height: 10),
              AutoSizeText(
                infoText.capitalizeAllWordsFirstLetter(),
                style: TextStyle(
                  color: AppColors.darkBlack,
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                ),
                maxLines: 3,
              ),
            ],
          ),
        ),
      ),
      actions: [
        Align(
          alignment: Alignment.centerRight,
          child: DialogTextButton(
            hasBackground: false,
            text: "ok",
            onPressed: () {
              Get.back();
            },
          ),
        ),
      ],
    );
  }

}