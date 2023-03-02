import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

import '../helpers__controllers/dialogs__controller.dart';
import '../helpers__controllers/extensions/show_snackbar.dart';


class ShowOnLockScreenSetting extends GetxController {
  DialogsController dialogsController = Get.put(DialogsController());
  // bool
  static Box localBox = Hive.box("locals");

  bool isHiddenOnLockedScreen = localBox.get("isHiddenOnLockedScreen") ?? false;

  //toggle method
  setNotificationVisibilityOnLockScreen(boolValue) {
    isHiddenOnLockedScreen = boolValue;
    update();
    localBox.put("isHiddenOnLockedScreen", isHiddenOnLockedScreen);

    dialogsController
        .showSnackbar("those changes will be applied after app restart");
  }

  getNotificationVisibilityOnLockScreen() {
    NotificationVisibility? notificationVisibility = isHiddenOnLockedScreen
        ? NotificationVisibility.secret
        : NotificationVisibility.public;

    return notificationVisibility;
  }
}
