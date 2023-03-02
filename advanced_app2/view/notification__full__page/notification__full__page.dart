// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../../controllers/helpers__controllers/dialogs__controller.dart';
import '../../controllers/helpers__controllers/extensions/show_confirm_with_actions.dart';
import '../../controllers/main__controller.dart';
import '../../controllers/notifications__controllers/date__Controller.dart';
import '../../controllers/notifications__controllers/extensions/assing_dull_date.dart';
import '../../controllers/notifications__controllers/extensions/get_date_and_time_both_full.dart';
import '../../controllers/notifications__controllers/new__item__notification__controller.dart';
import '../../controllers/settings__controller/show__delete__button__for__favorites.dart';
import '../../model/newItemNotificationModel.dart';
import '../add_new_item/widgets/option.dart';
import '../general__widgets/button.dart';
import '../general__widgets/edit__icon__button.dart';
import '../general__widgets/favorite_icon__button.dart';
import 'delete_button.dart';
import 'widgets/dashed__lines__decoration.dart';
import 'widgets/full__screen__notification__description.dart';
import 'widgets/full__screen__notification__title.dart';

class NotificationFullPage extends StatelessWidget {
  NotificationFullPage({Key? key}) : super(key: key);

  // Dependency injection
  final MainController mainController = Get.put(MainController());
  final NewNotificationController newNotificationController =
      Get.put(NewNotificationController());
  final DateController dateController = Get.put(DateController());
  final DialogsController dialogsController = Get.put(DialogsController());
  final ShowDeleteButtonForFavoritesSetting
      showdeleteButtonForFavoritesSetting =
      Get.put(ShowDeleteButtonForFavoritesSetting());

  ///
  // we got those with Get.arguments from previous page
  // it's weird but I see it best solution to pass arguments to a page
  final NewItemNotifcationModel gettedNotification = Get.arguments[0];
  final int reversedIndex = Get.arguments[1];
  final bool showDeleteButtonOnFullPage = Get.arguments[2];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        toolbarHeight: 80,
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
        backgroundColor: Theme.of(context).backgroundColor,
        elevation: 0,
        actions: [
          FavoriteIconButton(
            isChecked: gettedNotification.isFavorite ?? false,
            passedIndex: reversedIndex,
            size: 28,
          ),
          SizedBox(
            width: 10,
          ),
        ],
      ),
      body: Container(
        margin: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: GetBuilder<NewNotificationController>(
                    init: NewNotificationController(),
                    builder: (newNotificationController) {
                      return FullScreenNotificationTitle(
                        text: newNotificationController.newTitle ??
                            gettedNotification.title,
                        mainController: mainController,
                      );
                    },
                  ),
                ),
                EditIconButton(
                  onTap: () {
                    newNotificationController.showEditDialog(
                      mainController.allFirstWordLetterToUppercase("title"),
                      gettedNotification,
                      reversedIndex,
                    );
                  },
                ),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            //
            DashedLinesDecoration(),

            //
            SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: GetBuilder<NewNotificationController>(
                    // we don't have really to re init this controller every time
                    builder: (newNotificationController) {
                      return FullScreenNotificationDescription(
                        mainController: mainController,
                        text: newNotificationController.newDescription ??
                            gettedNotification.description,
                      );
                    },
                  ),
                ),
                EditIconButton(
                  onTap: () {
                    newNotificationController.showEditDescriptionDialog(
                      mainController
                          .allFirstWordLetterToUppercase("description"),
                      gettedNotification,
                    );
                  },
                ),
              ],
            ),
            Spacer(),
            GetBuilder<NewNotificationController>(
              init: NewNotificationController(),
              builder: (newNotificationController) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: GestureDetector(
                        onTap: () async {
                          newNotificationController.newDate =
                              dateController.fullDate(
                            await dateController.getFullDateFromUser(
                                gettedDate: gettedNotification.dateToShow),
                          );
                        },
                        child: Option(
                            mainController: mainController,
                            text: "date",
                            icon: Icons.calendar_month_outlined),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          newNotificationController.newIsRepeated =
                              newNotificationController
                                  .toggleRepeatedOptionBoolean();
                        },
                        child: Opacity(
                          opacity:
                              newNotificationController.isRepeatedOptionEnabled
                                  ? 1
                                  : .55,
                          child: Option(
                              mainController: mainController,
                              text: "repeat",
                              icon: Icons.repeat),
                        ),
                      ),
                    ),
                    // Expanded(
                    //   child: GestureDetector(
                    //     onTap: () {
                    //       newNotificationController.toggleAlarmOptionBoolean();
                    //     },
                    //     child: Opacity(
                    //       opacity:
                    //           newNotificationController.hasAutoDeleteEnabled
                    //               ? 1
                    //               : .55,
                    //       child: Option(
                    //         mainController: mainController,
                    //         text: "auto delete",
                    //         icon: Icons.low_priority,
                    //       ),
                    //     ),
                    //   ),
                    // ),
                  ],
                );
              },
            ),
            SizedBox(
              height: 40,
            ),
            SizedBox(
              height: 55,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    flex: 10,
                    child: CustomButton(
                      radiusValue: 10,
                      shouldReverseColors: true,
                      onPressed: () {
                        dialogsController.showConfirmWithActionsDialog(
                          "are you sure you want to update it ?",
                          mainController.allFirstWordLetterToUppercase("yes"),
                          () {
                            newNotificationController.updateNotification(
                              reversedIndex,
                              newNotificationController.newTitle ??
                                  gettedNotification.title,
                              newNotificationController.newDescription ??
                                  gettedNotification.description,
                              newNotificationController.newDate ??
                                  gettedNotification.dateToShow,
                              newNotificationController.newIsRepeated ??
                                  gettedNotification.isRepeated,
                              newNotificationController.newIsAlarmed ??
                                  gettedNotification.hasAutoDelete,
                              gettedNotification.isFavorite as bool,
                            );
                          },
                        );
                      },
                      text: mainController
                          .allFirstWordLetterToUppercase("update"),
                    ),
                  ),
                  if ((showdeleteButtonForFavoritesSetting
                          .getIsHideDeleteButton()) ||
                      showDeleteButtonOnFullPage) ...[
                    Expanded(
                      flex: 1,
                      child: SizedBox(),
                    ),
                    DeleteButton(
                      newNotificationController: newNotificationController,
                      reversedIndex: reversedIndex,
                      onPressed: () {
                        dialogsController.showConfirmWithActionsDialog(
                            "are you sure to delete this ?", "delete", () {
                          newNotificationController
                              .deleteNotification(reversedIndex);
                          Get.back();
                        }, forDelete: true);
                      },
                    ),
                  ]
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
