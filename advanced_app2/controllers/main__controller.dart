import 'package:get/get.dart';
import 'package:hive/hive.dart';

class MainController extends GetxController {
  MainController({this.payload});

  // Variables
  String? payload;



  /// Make all first letters of strings uppercase
  allFirstWordLetterToUppercase(String text) {
    if (text.isEmpty) {
      return text;
    }
    // in case of last letter is " " it makes an error so first :
    if (text[text.length - 1] == " ") {
      return text.trim().split(' ').map((word) {
        return "${word[0].toUpperCase()}${word.substring(1)} ";
      }).join(' ');
    }

    return text.split(' ').map((word) {
      return word[0].toUpperCase() + word.substring(1);
    }).join(' ');
  }
    String setDateShow(DateTime dateToShow) {
// write date properly

    int years = dateToShow.year;
    int months = dateToShow.month;
    int days = dateToShow.day;
    int hours = dateToShow.hour;
    int minutes = dateToShow.minute;
    String date =
        "$years-$months-$days  $hours:${minutes.toString().padLeft(2, '0')}";
    return date;
  }
}
