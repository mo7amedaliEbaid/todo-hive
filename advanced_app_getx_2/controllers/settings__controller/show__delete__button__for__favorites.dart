import 'package:get/get.dart';
import 'package:hive/hive.dart';

import '../helpers__controllers/dialogs__controller.dart';

class ShowDeleteButtonForFavoritesSetting extends GetxController {
  final DialogsController dialogsController = Get.put(DialogsController());

  // bool
  static Box localBox = Hive.box("locals");

  bool isDeleteButtonHidden = localBox.get("isDeleteButtonHidden") ?? false;

  //toggle method
  setToHideDeleteButton(boolValue) {
    isDeleteButtonHidden = boolValue;
    update();
    localBox.put("isDeleteButtonHidden", isDeleteButtonHidden);
    // dialogsController
    //     .showSnackbar("those changes will be applied after app restart");
  }

  getIsHideDeleteButton() {
    return isDeleteButtonHidden;
  }
}
