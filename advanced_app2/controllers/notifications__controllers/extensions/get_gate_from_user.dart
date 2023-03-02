import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../date__Controller.dart';

extension GetDateFromUserExtension on DateController {
  /// get the just the date(years, months, days)

  Future<DateTime?> dateFromUser({DateTime? gettedDate}) async {
    // showing datePicker dialog
    DateTime? date = await showDatePicker(
      context: Get.overlayContext as BuildContext,
      initialDate: gettedDate ?? selectedDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      //giving the possibility for the user to choose time between now and the next 5 years
      lastDate: DateTime.now().add(
        const Duration(days: 365 * 5),
      ),
    );
    return date;
  }
}
