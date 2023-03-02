// ignore_for_file: unused_field, unused_local_variable, depend_on_referenced_packages

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter_native_timezone/flutter_native_timezone.dart';


import '../controllers/notifications__controllers/new__item__notification__controller.dart';
import '../controllers/settings__controller/enable__ongoing__setting.dart';
import '../controllers/settings__controller/enable__sound.dart';
import '../controllers/settings__controller/enable__vibration.dart';
import '../controllers/settings__controller/show__on__lock__screen__setting.dart';
import '../model/newItemNotificationModel.dart';
import '../view/main__page/main__page.dart';

/// PLEASE DON'T RELY ON THIS IF YOUR NEW TO USING THOSE PACKAGE, CHECK THE DOCS FIRST, THEN TRY WORKING WITH THIS .
class NotificationService {
  static ShowOnLockScreenSetting showOnLockScreenSetting =
      Get.put(ShowOnLockScreenSetting());

  static EnableSoundSetting enableSoundSetting = Get.put(EnableSoundSetting());
  static EnableVibrationSetting enableVibrationSetting =
      Get.put(EnableVibrationSetting());
  static final EnableOngoingSetting enableOngoingSetting =
      Get.put(EnableOngoingSetting());

  final NewNotificationController newNotificationController =
      Get.put(NewNotificationController());
// setters

  // Getting instance of the notification plugin
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  // Create the notification with the android settings
  NotificationDetails platformChannelSpecifics = NotificationDetails(
    // you can add other platform but for now, I will use only android
    android: _androidNotificationDetails,

    // to add ios, you  should create iosNotificationDetails and add it to the platformChannelSpecifics
    // iOS: _iOSNotificationDetails,
  );

// Specifying the android settings details
  static final AndroidNotificationDetails _androidNotificationDetails =
      AndroidNotificationDetails(
    // Channel id
    'Notification',
    // Channel name
    'NOTIFICATION',
    // Channel description
    channelDescription: 'responsible for showing notifications',
    // Notification sound
    playSound: enableSoundSetting.getEnabledSoundBool(),

    enableVibration: enableVibrationSetting.getEnabledVibration(),
    // Priority level
    priority: Priority.max,
    // Importance level
    importance: Importance.max,
    //
    ongoing: enableOngoingSetting.getEnabledOngoing(),
    autoCancel: true,

    visibility: showOnLockScreenSetting.getNotificationVisibilityOnLockScreen(),

    showWhen: true,

    ticker: "ticker",
    colorized: true, color: Colors.red[800],
  );

  // ios notification details
  static const IOSNotificationDetails _iOSNotificationDetails =
      IOSNotificationDetails();

  // Init method
  Future<void> init() async {
    // Declaring the android settings with icon
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@drawable/ic_stat_notification_logo');

    // Declaring the ios permission settings
    IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings(
      // settings to false, no request for now
      requestSoundPermission: false,
      requestBadgePermission: false,
      requestAlertPermission: false,

      // settings to true, request for now
      onDidReceiveLocalNotification: onDidReceiveLocalNotification,
    );

// Request now
    await requestIOSpermission();

    // Now, init them
    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
      // I don't target macOs for now
      macOS: null,
    );

    // Init this, when I will understand this, i'll explain hah
    tz.initializeTimeZones();
    final String currentTimeZone =
        await FlutterNativeTimezone.getLocalTimezone();

    tz.setLocalLocation(tz.getLocation(currentTimeZone));

    // Init the big one
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onSelectNotification: onSelectNotification,
    );

    /// only for tests, in production comment or delete it
    //  Instant notification on app open
    // await createInstantNotification(
    //   Random().nextInt(1000),
    //   'test title',
    //   'test description',
    //   "payload text example for instant notification",
    // );

    // schedule notification for the next 5 secondes
    // createScheduledNotification(
    //   Random().nextInt(1000),
    //   'test title',
    //   'test description',
    //   // this will show it after 5 secondes from the current time
    //   tz.TZDateTime.now(tz.local).add(
    //     const Duration(seconds: 5),
    //   ),
    //   "payload text example for scheduled notification",
    // );
  }

  // if you don't want to request the permission on the app open, you can use this method to request it whenever you want

  Future<void> requestIOSpermission() async {
    final bool? result = await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
  }

// (there is another methods to do same things for MacOS on docs page)

  // call the instant notification creating
  Future<void> createInstantNotification(
      int id, String? title, String? description, String? payload) async {
    // Create the notification
    await flutterLocalNotificationsPlugin.show(
      id,
      title,
      description,
      // this is from the service class(this class)
      platformChannelSpecifics,
      payload: payload,
    );
  }

// call the scheduled notification creating
  Future<void> createScheduledNotification(
    int id,
    String? title,
    String? description,
    dynamic tzDateTime,
    String? payload,
    bool isRepeated,
  ) async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      description,
      tzDateTime,
      payload: payload,
      platformChannelSpecifics,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: isRepeated ? DateTimeComponents.time : null,
    );
  }

  void setPeriodically(
    int id,
    String? title,
    String? description,
    String? payload,
  ) {
    flutterLocalNotificationsPlugin.periodicallyShow(
      id,
      title,
      description,
      RepeatInterval.daily,
      platformChannelSpecifics,
      payload: payload,
    );
  }

//
  void onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload) async {
    // Display a dialog with the notification details, tap ok to go to another page
    showDialog(
      context: Get.context as BuildContext,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: Text(title ?? "title error"),
        content: Text(body ?? "title error"),
        actions: [
          CupertinoDialogAction(
            isDefaultAction: true,
            child: const Text('Ok'),
            onPressed: () async {
              Navigator.of(context, rootNavigator: true).pop();
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const MainPage(),
                ),
              );
            },
          )
        ],
      ),
    );
  }

  void onSelectNotification(String? payload) async {
    // if (payload != null) {
    //   debugPrint('notification payload: $payload');
    // }
    // declaring the boc
    Box newNotificationsBox =
        Hive.box<NewItemNotifcationModel>('newNotificationsBox');

    // actually it will cancel automatically because autoCancel is set to true in android details for notification
    // await flutterLocalNotificationsPlugin.cancel(int.parse("$payload"));

    // Setting value
    Iterable newNotificationsBoxValues = newNotificationsBox.values;

    // Get matchingElement
    NewItemNotifcationModel matchingItem = newNotificationsBoxValues
        .firstWhere((element) => element.id == int.parse("$payload"));
    if (matchingItem.hasAutoDelete) {
      // Remove it from the box (remove it's card)
      newNotificationsBox
          .deleteAt(newNotificationsBoxValues.toList().indexOf(matchingItem));

      Get.offNamed("mainPage", arguments: payload);
    }
  }

  //
  Future<void> getPendingNotifications() async {
    final List<PendingNotificationRequest> pendingNotificationRequests =
        await flutterLocalNotificationsPlugin.pendingNotificationRequests();
  }

  // Specific for android,
  Future<void> getActiveNotifications() async {
    final List<ActiveNotification>? activeNotifications =
        await flutterLocalNotificationsPlugin
            .resolvePlatformSpecificImplementation<
                AndroidFlutterLocalNotificationsPlugin>()
            ?.getActiveNotifications();
  }

  Future<void> cancelNotificationWithId(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
  }

  Future<void> cancelAllNotifications() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }

  get isAppOPenedViaNotification async {
    NotificationAppLaunchDetails? notificationAppLaunchDetails =
        await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();

    return notificationAppLaunchDetails;
  }

  checkIfNotificationOpenedTheApp() async {
    final NotificationAppLaunchDetails? details =
        await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
    return details!.didNotificationLaunchApp;
  }
}
