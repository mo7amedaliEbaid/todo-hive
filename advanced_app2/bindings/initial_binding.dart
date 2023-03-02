import 'package:get/get.dart';

import '../controllers/helpers__controllers/dialogs__controller.dart';
import '../controllers/main__controller.dart';
import '../controllers/settings__controller/dark__mode_setting.dart';

class InitialBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<MainController>(MainController(), permanent: true);
    Get.put<ThemeController>(ThemeController());
    Get.put<DialogsController>(DialogsController(), permanent: true);
  }
}
