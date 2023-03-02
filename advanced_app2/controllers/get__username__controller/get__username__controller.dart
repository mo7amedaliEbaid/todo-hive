import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GetUsernameController extends GetxController {
  // Text editing controller
  TextEditingController usernameTextFieldController = TextEditingController();

  // Username variables
  String? username;
  int usernameMaxLength = 15;
  int usernameWrittenLength = 0;
  double usernameCountBoxScale = 0;
  
}
