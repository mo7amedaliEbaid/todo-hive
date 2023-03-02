import '../date__Controller.dart';

extension AssignFullDate on DateController {
  /// assign a full date to the date variable
  DateTime? fullDate(DateTime? gettedDateFromFunction) {
    date = gettedDateFromFunction;
    selectedDate = gettedDateFromFunction;
    update();

    return date;
  }
}
