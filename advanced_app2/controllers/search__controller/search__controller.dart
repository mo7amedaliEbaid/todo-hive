import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

import '../../model/newItemNotificationModel.dart';

class MySearchController extends GetxController {
  // Search text field controller
  TextEditingController searchBarController = TextEditingController();

  // Convert the box to list
  List<NewItemNotifcationModel> boxAsList =
      Hive.box<NewItemNotifcationModel>("newNotificationsBox").values.toList();

  // Filter method
  dynamic filterElement(String textToFilterWith, dynamic element) {
    // Given the ability to search with title and description
    // Filter with anything from the model (except booleans ofc)

    return (element.title.toLowerCase().contains(
              textToFilterWith.toLowerCase(),
            )) ||
        (element.description.toLowerCase().contains(
              textToFilterWith.toLowerCase(),
            )) ||
        element.dateToShow.day.toString().toLowerCase().contains(
              textToFilterWith.toLowerCase(),
            ) ||
        element.dateToShow.year.toString().toLowerCase().contains(
              textToFilterWith.toLowerCase(),
            ) ||
        element.dateToShow.month.toString().toLowerCase().contains(
              textToFilterWith.toLowerCase(),
            );

    //
  }

  filterList(List listToFilter, String textToFilterWith) {
    // Filter the list with the given text
    return listToFilter
        .where((element) => filterElement(textToFilterWith, element))
        .toList();
  }

  @override
  void onClose() {
    searchBarController.dispose();
    super.onClose();
  }
}
