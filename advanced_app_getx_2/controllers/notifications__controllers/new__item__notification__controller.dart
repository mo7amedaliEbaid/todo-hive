import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

import '../../model/newItemNotificationModel.dart';
import '../../services/local__notifications__service.dart';
import '../../view/notification__full__page/widgets/bottom__sheet_widget.dart';
import '../favorites__controller/favorites__controller.dart';
import '../helpers__controllers/dialogs__controller.dart';
import '../helpers__controllers/extensions/show_snackbar.dart';
import '../main__controller.dart';

import 'package:timezone/timezone.dart' as tz;

import 'new__item__notification__error__controller.dart';

class NewNotificationController extends GetxController {
  @override
  void onReady() async {
    // initialize the notifications service
    NotificationService().init();
    // opening the hive box now when the get username page is opened
    Box newNotifications =
        await Hive.openBox<NewItemNotifcationModel>("newNotificationsBox");

    super.onReady();
  }

  // Dependency injection
  final DialogsController dialogsController = Get.put(DialogsController());
  final FavoritesController favoritesController =
      Get.put(FavoritesController());
  final MainController mainController = Get.put(MainController());

  ///
  // NotificationService instance
  // uncommenting this will cause a stack overflow
  // final NotificationService notificationService = NotificationService();
  ///

  // New item  Text editing controllers
  late TextEditingController titleController;
  late TextEditingController descriptionController;

  // TextFields keys
  final titleTextFieldKey = UniqueKey();
  final descriptionTextFieldKey = UniqueKey();

  // Options variables
  bool isRepeatedOptionEnabled = false;
  bool hasAutoDeleteEnabled = false;

  // Title variables
  int titleMaxLength = 40;
  int titleWrittenLength = 0;
  double titleCountBoxScale = 0;

  // Description variables
  int descriptionMaxLength = 125;
  int descriptionWrittenLength = 0;
  double descriptionCountBoxScale = 0;

  // Variables that will take the new data to update the notification
  String? newTitle;
  String? newDescription;
  bool? newIsAlarmed;
  bool? newIsRepeated;
  DateTime? newDate;

  // Add new item method
  addNewNotification(
    String title,
    String description,
    DateTime? date,
    bool isRepeated,
    bool autoDeleteEnabled,
  ) {
    // init the hive box
    Box<NewItemNotifcationModel> newNotificationsBox =
        Hive.box<NewItemNotifcationModel>("newNotificationsBox");
    // and add it to box
    int newId = Random().nextInt(1000000);

    // Check title
    if (checkTitleValidity(title)) {
      checkTitleValidityDialog();
      return;
    }

    // // Check description
    // if (checkDescriptionValidity(description)) {
    //   checkDescriptionValidityDialog();
    //   return;
    // }

    // Check date (years, months, days)
    if (checkDateTimeValidity(date)) {
      checkDateTimeValidityDialog();
      return;
    }

    // Check date (hours, minutes)
    if (checkTimeOfDayValidity(date)) {
      checkTimeOfDayValidityDialog();
      return;
    }

    // Get back if in somehow the user choosed a date in the past
    if (checkFullTimeValidity(date)) {
      checkFullTimeValidityDialog();
      return;
    }

    // Add to box then
    newNotificationsBox.add(
      NewItemNotifcationModel(
        title,
        description,
        date!,
        isRepeated,
        autoDeleteEnabled,
        // isFavorite: false by default :
        false,
        // id
        newId,
      ),
    );

    ///
    // Using openContainer from the animations package trait the AddNewNotificationPage as just a widget so open/close it execute the dispose to text editing controllers so we should re-init them after any add operations

    /// Pushing the notification
    // Instance of service
    final NotificationService notificationService = NotificationService();

    // Get difference between the current date and the notification date
    Duration difference = date.difference(DateTime.now());

    // Create it
//

    notificationService.createScheduledNotification(
      newId,
      title,
      description,
      tz.TZDateTime.now(tz.local).add(
        Duration(
          seconds: difference.inSeconds,
        ),
      ),
      "$newId",
      isRepeated,
    );

    clear();
    // going back
    Get.back();
    // show snackbar
    dialogsController.showSnackbar("created successfully");
  }

  // Delete notification
  deleteNotification(int index) {
    // Init the hive box
    Box<NewItemNotifcationModel> newNotificationsBox =
        Hive.box<NewItemNotifcationModel>("newNotificationsBox");

    // delete it from box
    newNotificationsBox.deleteAt(index);

    // this is optional but there is a 1% case that need it so, it's important
    update();

    // Going back
    Get.back();

    // showing snackbar
    dialogsController.showSnackbar("deleted successfully");
  }

  // This shows the bottom sheet for update title
  showEditDialog(String hint, NewItemNotifcationModel gettedNotification,
      int reversedIndex) {
    // First set an init value whenever we open the bottom sheet
    titleController.text = newTitle ?? gettedNotification.title;

    // For first time it will for sure be the titleController.text so
    countTitleLength(titleController.text);
    update();

    // Open the bottom sheet
    Get.bottomSheet(
      BottomSheetWidget(
        // Success method
        onSuccess: () {
          setNewTitle(titleController.text);

          update();
        },

        // Specify the type of the bottom sheet
        forTitle: true,

        hint: hint,

        gettedNotification: gettedNotification,
      ),
    );
  }

  // This shows the bottom sheet for update description
  showEditDescriptionDialog(
    String hint,
    NewItemNotifcationModel gettedNotification,
  ) {
    // First set an init value whenever we open the bottom sheet
    descriptionController.text =
        newDescription ?? gettedNotification.description;

    // For first time it will for sure be the descriptionController.text so
    countTitleLength(descriptionController.text);
    update();

    // Open the bottom sheet
    Get.bottomSheet(BottomSheetWidget(
      // Success method
      onSuccess: () {
        setNewDescription(descriptionController.text);

        update();
      },
      // Specify the type of the bottom sheet
      forDescription: true,
      hint: hint,
      gettedNotification: gettedNotification,
    ));
  }

//

  // Set the updated title to newTitle variable
  setNewTitle(String value) {
    // Store it
    newTitle = value;

    // Now we change the textField value to the new value
    titleController.text = newTitle!;
    update();

    // Going back
    Get.back();
  }

  // Give the updated description to newTitle variable
  setNewDescription(String value) {
    // Store it
    newDescription = value;

    // Now we change the textField value to the new value
    descriptionController.text = newDescription!;
    update();

    // Going back
    Get.back();
  }

  // Edit notification
  updateNotification(
    int index,
    String title,
    String description,
    DateTime date,
    bool isRepeated,
    bool isAlarm,
    bool isFavorite,
  ) {
    // Init the hive box
    Box<NewItemNotifcationModel> newNotificationsBox =
        Hive.box<NewItemNotifcationModel>("newNotificationsBox");

    Get.back();

    // Check title
    if (checkTitleValidity(title)) {
      checkTitleValidityDialog();
      return;
    }

    // Check description
    if (checkDescriptionValidity(description)) {
      checkDescriptionValidityDialog();
      return;
    }

    // Check date (years, months, days)
    if (checkDateTimeValidity(date)) {
      checkDateTimeValidityDialog();
      return;
    }

    // Check date (hours, minutes)
    if (checkTimeOfDayValidity(date)) {
      checkTimeOfDayValidityDialog();
      return;
    }

    // get back if in somehow the user choosed a date in the past
    if (checkFullTimeValidity(date)) {
      checkFullTimeValidityDialog();
      return;
    }

    // update it in box

    newNotificationsBox.putAt(
      index,
      NewItemNotifcationModel(
        title,
        description,
        date,
        isRepeated,
        isAlarm,
        isFavorite,
        newNotificationsBox.getAt(index)!.id,
      ),
    );

    ///
    // Instance of service
    final NotificationService notificationService = NotificationService();
    // cancel the pending one
    notificationService
        .cancelNotificationWithId(newNotificationsBox.getAt(index)!.id);

    // Get difference
    Duration difference = date.difference(DateTime.now());

    // Create a new one with the new data
    if (isRepeated == false) {
      notificationService.createScheduledNotification(
        newNotificationsBox.getAt(index)!.id,
        title,
        description,
        // This will show it after 5 secondes from the current time
        tz.TZDateTime.now(tz.local).add(
          Duration(
            seconds: difference.inSeconds,
          ),
        ),
        "${newNotificationsBox.getAt(index)!.id}",
        isRepeated,
      );
    }

    if (isRepeated) {
      notificationService.setPeriodically(
        newNotificationsBox.getAt(index)!.id,
        title,
        description,
        "${newNotificationsBox.getAt(index)!.id}",
      );
      // Going back
    }

    // Re init inputs
    clear();

    // Re init the the marked new Variables
    reInitNewVariables();

    // Going back
    Get.back();

    // Showing snackbar
    dialogsController.showSnackbar("updated successfully");
  }

  // Method handler for title text field
  countTitleLength(String title) async {
    if (title.isEmpty) {
      titleWrittenLength = 0;
      titleCountBoxScale = 0;
    } else {
      titleWrittenLength = title.length;
      titleCountBoxScale = 1;
    }
    update();
    if (title.length == titleMaxLength) {
      titleCountBoxScale = 1.25;
      await Future.delayed(const Duration(milliseconds: 30));
      titleCountBoxScale = 1;
    }

    update();
  }

  // Method handler for description text field
  countDescriptionLength(String description) async {
    if (description.isEmpty) {
      descriptionWrittenLength = 0;
      descriptionCountBoxScale = 0;
    } else {
      descriptionWrittenLength = description.length;
      descriptionCountBoxScale = 1;
    }
    update();
    if (description.length == descriptionMaxLength) {
      descriptionCountBoxScale = 1.25;
      await Future.delayed(const Duration(milliseconds: 30));
      descriptionCountBoxScale = 1;
    }

    update();
  }

  // Toggle isRepeatedOptionEnabled
  toggleRepeatedOptionBoolean() {
    isRepeatedOptionEnabled = !isRepeatedOptionEnabled;
    update();
    return isRepeatedOptionEnabled;
  }

  // Toggle hasAutoDelete
  toggleAlarmOptionBoolean() {
    hasAutoDeleteEnabled = !hasAutoDeleteEnabled;
    update();
    return hasAutoDeleteEnabled;
  }

  @override
  void onInit() {
    titleController = TextEditingController();
    descriptionController = TextEditingController();

    super.onInit();
  }

  @override
  void onClose() {
    titleController.dispose();
    descriptionController.dispose();
    super.onClose();
  }

  clear() {
    titleController.text = "";
    descriptionController.text = "";
    titleWrittenLength = 0;
    descriptionWrittenLength = 0;
    titleCountBoxScale = 0;
    descriptionCountBoxScale = 0;
    hasAutoDeleteEnabled = false;
    isRepeatedOptionEnabled = false;
  }

  void reInitNewVariables() {
    newTitle = null;
    newDescription = null;
    newIsAlarmed = null;
    newIsRepeated = null;
    newIsRepeated = null;
    newDate = null;
  }
}
