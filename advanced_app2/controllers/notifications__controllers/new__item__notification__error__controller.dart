import 'package:get/get.dart';

import '../helpers__controllers/dialogs__controller.dart';
import '../helpers__controllers/extensions/show_info.dart';

final DialogsController dialogsController = Get.put(DialogsController());

/////////////////////
/// Title
//
bool checkTitleValidity(String title) {
  return title.isEmpty;
}

//
void checkTitleValidityDialog() {
  dialogsController.showInfoDialog(
      "Title is empty", "please, set a title for your notification");
}

/////////////////////
/// Description
//
bool checkDescriptionValidity(String description) {
  return description.isEmpty;
}

//
void checkDescriptionValidityDialog() {
  dialogsController.showInfoDialog("description is empty",
      "please, set a description for your notification");
}

/////////////////////
/// DateTime (year, month, day)
//
bool checkDateTimeValidity(DateTime? date) {
  return (date?.year == null && date?.month == null && date?.day == null);
}

//
void checkDateTimeValidityDialog() {
  dialogsController.showInfoDialog("no date selected",
      "please, choose the schedule date for your notification");
}

/////////////////////
/// TimeOfDay (hours, minutes)
//
bool checkTimeOfDayValidity(DateTime? date) {
  return (date?.hour == null && date?.minute == null);
}

//
void checkTimeOfDayValidityDialog() {
  dialogsController.showInfoDialog("no hours / minutes selected",
      "please, set a specific time for scheduling your notification");
}

/////////////////////
/// Fulltime validity
bool checkFullTimeValidity(DateTime? date) {
  return date != null && date.isBefore(DateTime.now());
}

void checkFullTimeValidityDialog() {
  dialogsController.showInfoDialog("date not accepted",
      "we can't show you a notification in the past, please, pick a schedule date");
}
