import 'package:hive/hive.dart';

import '../../../model/newItemNotificationModel.dart';
import '../main_init_methods.dart';

typedef HiveBoxesInit = Future Function(
    {required bool shouldClearBoxesOnAppRestart});

extension HiveInitBoxedExtension on MainMethodsService {
  /// initialize the boxes that we will need in our project
  Future<void> _initHiveBoxes(
      {required bool shouldClearBoxesOnAppRestart}) async {
    // open the boxes
    Box localBox =
        await Hive.openBox<NewItemNotifcationModel>("newNotificationsBox");
    Box newNotifications = await Hive.openBox("locals");

    // clear the boxes if the app is restarted
    if (shouldClearBoxesOnAppRestart) {
      await localBox.clear();
      await newNotifications.clear();
    }
  }

  HiveBoxesInit get initHiveBoxes => _initHiveBoxes;
}
