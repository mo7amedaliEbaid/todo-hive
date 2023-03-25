import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

import '../../view/main__page/tabs__screens/settings/widgets/change__username__bottomsheet__widget.dart';
import '../helpers__controllers/dialogs__controller.dart';
import '../helpers__controllers/extensions/show_info.dart';
import '../helpers__controllers/extensions/show_snackbar.dart';

class ChangeUsernameSetting extends GetxController {
  ChangeUsernameSetting({required this.context});

// Init input value with username
  @override
  void onInit() {
    editUsernameController =
        TextEditingController(text: localBox.get("username"));
    super.onInit();
  }

  // Variables
  late BuildContext context;
  final DialogsController dialogsController = Get.put(DialogsController());

  // username variables
  int usernameMaxLength = 10;
  int usernameWrittenLength = 0;
  double usernameCountBoxScale = 0;

  // TextEditingController
  late TextEditingController editUsernameController;

  // Box
  Box localBox = Hive.box("locals");
  showEditUsernameBottomSheet() {
    Get.bottomSheet(
      ChangeUsernameBottomSheetWidget(
        controller: editUsernameController,
        usernameMaxLength: usernameMaxLength,
        usernameWrittenLength: usernameWrittenLength,
        counterBoxScale: usernameCountBoxScale,
        onSuccess: () {
          changeUsername(editUsernameController.text);
        },
      ),
    );
  }

  changeUsername(String newUsername) {
    if (newUsername.isEmpty) {
      dialogsController.showInfoDialog(
          "no username written", "please, write a username");
      return;
    }

    // Set new username to box
    localBox.put("username", newUsername);

    // Going back
    Get.back();

    // Showing snackbar
    dialogsController.showSnackbar("username modified successfully");
  }

  // Method handler for username text field
  countUsernameLength(String username) async {
    if (username.isEmpty) {
      usernameWrittenLength = 0;
      usernameCountBoxScale = 0;
    } else {
      usernameWrittenLength = username.length;
      usernameCountBoxScale = 1;
    }
    update();
    if (username.length == usernameMaxLength) {
      usernameCountBoxScale = 1.25;
      await Future.delayed(const Duration(milliseconds: 30));
      usernameCountBoxScale = 1;
    }

    update();
  }
}
