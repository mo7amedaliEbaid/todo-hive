import 'package:get/get.dart';
import 'package:hive/hive.dart';


import '../../model/newItemNotificationModel.dart';
import '../../services/local__notifications__service.dart';
import '../helpers__controllers/dialogs__controller.dart';
import '../helpers__controllers/extensions/show_confirm_with_actions.dart';
import '../helpers__controllers/extensions/show_info.dart';
import '../helpers__controllers/extensions/show_snackbar.dart';

class DeleteAllSetting extends GetxController {
  final DialogsController dialogsController = Get.put(DialogsController());
  deleteAll() {
    Box newNotificationsBox =
        Hive.box<NewItemNotifcationModel>('newNotificationsBox');

    // check first if it's already empty
    if (newNotificationsBox.isEmpty) {
      dialogsController.showInfoDialog("Already empty",
          "there is not notification saved yet, you can schedule new notification from the home page");
      return;
    }

    // else show confirm
    dialogsController.showConfirmWithActionsDialog(
        "are you sure you want to delete/Cancel all your notifications ?",
        "delete", () async {
      await newNotificationsBox.clear();
      NotificationService().cancelAllNotifications();

      // Going back
      Get.back();

      // showing snackbar
      dialogsController.showSnackbar("all notifications deleted successfully");
    });
  }
}
