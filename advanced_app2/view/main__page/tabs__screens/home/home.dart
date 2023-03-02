import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../../controllers/get__username__controller/get__username__controller.dart';
import '../../../../controllers/home__page__tab__controller/extensions/goto_search_tab_screen.dart';
import '../../../../controllers/home__page__tab__controller/home__page__tab__controller.dart.dart';
import '../../../../controllers/main__controller.dart';
import '../../../../controllers/notifications__controllers/new__item__notification__controller.dart';
import '../../../../model/newItemNotificationModel.dart';
import '../../../general__widgets/nothing__to__show__text.dart';
import '../../../general__widgets/notification__card.dart';
import '../../../add_new_item/add__new__item.dart';
import '../../../general__widgets/screen__title.dart';
import 'widgets/open__Container__button.dart';
import 'widgets/username__welcome.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  // Notification payload
  static dynamic payloadFromOpenedNotification = Get.arguments;

  // Dependency injection
  final MainController mainController =
      Get.put(MainController(payload: payloadFromOpenedNotification));
  final NewNotificationController newNotificationController =
      Get.put(NewNotificationController());
  final GetUsernameController getUsernameController =
      Get.put(GetUsernameController());

  @override
  Widget build(BuildContext context) {
    final BottomBarController bottomBarController =
        Get.put(BottomBarController(context: context));
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(left: 20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 20),
            Container(
              height: 60,
              margin: const EdgeInsets.only(right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  // Avatar
                  // GetBuilder<ThemeController>(
                  //   init: ThemeController(),
                  //   builder: (themeController) => CircleAvatar(
                  //     backgroundColor: Colors.transparent,
                  //     radius: 27,
                  //     backgroundImage: AssetImage(
                  //       themeController.logoBasedOnTheme,
                  //     ),
                  //   ),
                  // ),

                  GestureDetector(
                    onTap: () {
                      bottomBarController.gotoSearchScreen();
                    },
                    child: const Padding(
                      padding: EdgeInsets.only(bottom: 10, right: 10, top: 10),
                      child: Icon(
                        Icons.search,
                        size: 25,
                      ),
                    ),
                  ),

                  // Add button
                  OpenContainerButton(
                    key: const Key("create notification button"),
                    screenToOpen: AddNewItemScreen(),
                    icon: Icons.add,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Username welcome
            UsernameWelcome(
              textToShowBeforeUsername: "hi, ",
              mainController: mainController,
              getUsernameController: getUsernameController,
            ),
            ValueListenableBuilder(
                valueListenable:
                    Hive.box<NewItemNotifcationModel>("newNotificationsBox")
                        .listenable(),
                builder: (BuildContext context,
                    Box<NewItemNotifcationModel> notificationsBox, child) {
                  return AutoSizeText(
                    mainController.allFirstWordLetterToUppercase(
                        "you have ${notificationsBox.values.length} notifications"),
                    style: TextStyle(
                      fontSize: 13,
                      color: Theme.of(context).primaryColor.withOpacity(.6),
                    ),
                  );
                }),
            const SizedBox(height: 20),

            Container(
              margin: const EdgeInsets.only(right: 20),
              child: Divider(
                color: Theme.of(context).primaryColor,
                thickness: 1,
              ),
            ),
            const SizedBox(height: 20),

            //
            ScreenTitle(
              mainController: mainController,
              title: "All your notification",
            ),

            const SizedBox(height: 20),
            // Items list
            ValueListenableBuilder(
                valueListenable:
                    Hive.box<NewItemNotifcationModel>("newNotificationsBox")
                        .listenable(),
                builder: (BuildContext context,
                    Box<NewItemNotifcationModel> box, __) {
                  if (box.values.isEmpty) {
                    return Container(
                      margin: const EdgeInsets.only(right: 20),
                      child: NothingToShow(
                        text: "schedule your first\n notification",
                      ),
                    );
                  }
                  return Column(
                    children: <Widget>[
                      ...List.generate(
                        box.values.length,
                        (index) {
                          // making the read of the iterable start from the end
                          // ...length -1 get us to last element, since index start from 0, this will work as we want
                          int reversedIndex = box.values.length - 1 - index;
                          NewItemNotifcationModel? currentNotification =
                              box.getAt(reversedIndex);

                          return NotificationCard(
                            showDeleteButtonOnFullPage: true,
                            currentNotification: currentNotification,
                            reversedIndex: reversedIndex,
                            title: currentNotification!.title,
                            description: currentNotification.description,
                          );
                        },
                      ),
                      const SizedBox(height: 100),
                    ],
                  );
                }),
          ],
        ),
      ),
    );
  }
}
