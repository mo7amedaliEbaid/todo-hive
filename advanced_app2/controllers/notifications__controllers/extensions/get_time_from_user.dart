import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../date__Controller.dart';

extension GetTimeFromUserExtension on DateController {
  /// get just the time (hours, minutes)
  Future<TimeOfDay?> timeFromUser({DateTime? gettedDate}) async {
    // showing timePicker dialog
    TimeOfDay? time = await showTimePicker(
      context: Get.overlayContext as BuildContext,
      initialTime: gettedDate != null
          ? TimeOfDay.fromDateTime(gettedDate)
          : selectedDate != null
              ? TimeOfDay.fromDateTime(selectedDate!)
              : TimeOfDay.now(),
      // TimeOfDay(hour: DateTime.now().hour, minute: DateTime.now().minute),
    );
    return time;
  }
}
