import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/AppColors.dart';
import '../../../utils/extensions/string_extension.dart';
import '../../../view/general__widgets/dialog__text__button.dart';
import '../dialogs__controller.dart';

extension ShowConfirmWithActionsExtension on DialogsController {
  /// Show a confirm dialog with actions
  void showConfirmWithActionsDialog(
      String infoText, String actionButtonText, void Function()? function,
      {forDelete = false}) {
    Get.defaultDialog(
      title: "",
      backgroundColor: AppColors.lightGrey,
      radius: 5,
      barrierDismissible: false,
      content: Column(
        children: <Widget>[
          Icon(
            forDelete ? Icons.delete : Icons.check,
            color: forDelete ? Colors.red[800] : AppColors.darkBlack,
            size: 60,
          ),
          const SizedBox(height: 15),
          SizedBox(
            width: 200,
            child: Text(
              (infoText).capitalizeAllWordsFirstLetter(),
              style: TextStyle(
                color: AppColors.darkBlack,
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
      actions: [
        DialogTextButton(
          hasBackground: false,
          text: "no",
          onPressed: () {
            Get.back();
          },
        ),
        DialogTextButton(
          forDelete: forDelete,
          onPressed: function,
          text: actionButtonText,
          hasBackground: true,
        ),
      ],
    );
  }
}
