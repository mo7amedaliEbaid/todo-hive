import 'package:hive/hive.dart';

import '../get__username__controller.dart';

extension GetUsernameExtension on GetUsernameController {
    // Get username from the box
  String getUsername() {
    // Like we see we opened the box directly cause, it's already open from the getUsernameController
    // Getting the box
    Box localBox = Hive.box('locals');

    // Getting the username from the box
    String usernameToShow = localBox.get("username");

    ///
    // since we didn't save the username value in some variables, we will let the box open, yes, this is fine (from the official hive docs)
    // if you think that will cause performance problem, save the value we got into a variable and return it and close the box
    // localBox.close();
    ///

    // Got it
    return usernameToShow;
  }
}