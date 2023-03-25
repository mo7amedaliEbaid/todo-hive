import 'package:get/get.dart';

import 'dialogs__controller.dart';
import 'extensions/show_info.dart';

class OnNotificationClick extends GetxController {
  OnNotificationClick({this.payload});
  String? payload;

  final DialogsController dialogsController = Get.find();

  @override
  void onReady() {
    if (payload != null) {
      dialogsController.showInfoDialog("deleted",
          "the mission of this notification is completed, so it's automatically deleted .");
    }
    super.onReady();
  }
}
