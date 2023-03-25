import 'package:flutter/material.dart';

import '../date__Controller.dart';
import 'get_gate_from_user.dart';
import 'get_time_from_user.dart';


extension GetDateAndTimeBothFromUserExtension on DateController {
// get the full date with time (years, months, days, hours, minutes)
  Future<DateTime?> getFullDateFromUser({DateTime? gettedDate}) async {
    //
    DateTime? date = await dateFromUser(gettedDate: gettedDate);
    TimeOfDay? time = await timeFromUser(gettedDate: gettedDate);

    if (date != null && time != null) {
      return DateTime(date.year, date.month, date.day, time.hour, time.minute);
    } else {
      // note !
      return null;
    }
  }
}