import 'package:get/get.dart';

import '../helpers__controllers/dialogs__controller.dart';

class DateController extends GetxController {
  // Depend. injection
  final DialogsController dialogsController = Get.find();

  // Variables
  DateTime? date;
  DateTime? selectedDate;

  DateTime? setFullDate(param0) {}
}
