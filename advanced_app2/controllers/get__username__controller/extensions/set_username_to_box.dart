import 'package:hive/hive.dart';

import '../get__username__controller.dart';

extension SetUsernameExtension on GetUsernameController {
  /// Set a new Username to the box
  setUserName(String textFieldValue) {
    // Opening the other box
    Box localBox = Hive.box('locals');

    // Saving the username in the box
    localBox.put("username", textFieldValue);

    // Setting the new username value (for the first time, but it's optional)
    username = textFieldValue;

    // When this is done we need to set that this is an old user so he will be redirected to mainPage
    localBox.put("isNewUsingApp", false);
  }
}
