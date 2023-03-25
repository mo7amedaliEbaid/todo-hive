import 'package:get/get.dart';
import 'package:hive/hive.dart';

import '../helpers__controllers/dialogs__controller.dart';
import '../helpers__controllers/extensions/show_snackbar.dart';

class EnableVibrationSetting extends GetxController {
  final DialogsController dialogsController = Get.put(DialogsController());

  // bool
  static Box localBox = Hive.box("locals");

  bool isVibrationEnabled = localBox.get("isVibrationEnabled") ?? true;

  //toggle method
  setEnabledVibration(boolValue) {
    isVibrationEnabled = boolValue;
    update();
    localBox.put("isVibrationEnabled", isVibrationEnabled);

    dialogsController
        .showSnackbar("those changes will be applied after app restart");
  }

  getEnabledVibration() {
    return isVibrationEnabled;
  }
}
