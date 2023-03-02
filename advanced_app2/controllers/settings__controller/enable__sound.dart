import 'package:get/get.dart';
import 'package:hive/hive.dart';

import '../helpers__controllers/dialogs__controller.dart';
import '../helpers__controllers/extensions/show_snackbar.dart';

class EnableSoundSetting extends GetxController {
  final DialogsController dialogsController = Get.put(DialogsController());

  // bool
  static Box localBox = Hive.box("locals");

  bool isSoundEnabled = localBox.get("isSoundEnabled") ?? true;

  //toggle method
  setEnabledSoundBool(boolValue) {
    isSoundEnabled = boolValue;
    update();
    localBox.put("isSoundEnabled", isSoundEnabled);
    dialogsController
        .showSnackbar("those changes will be applied after app restart");
  }

  getEnabledSoundBool() {
    return isSoundEnabled;
  }
}
