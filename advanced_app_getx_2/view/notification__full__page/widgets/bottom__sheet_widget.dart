// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/main__controller.dart';
import '../../../controllers/notifications__controllers/new__item__notification__controller.dart';
import '../../../model/newItemNotificationModel.dart';
import '../../general__widgets/action__button.dart';
import '../../general__widgets/text__field.dart';

class BottomSheetWidget extends StatelessWidget {
  BottomSheetWidget({
    Key? key,
    required this.hint,
    this.forDescription = false,
    this.forTitle = false,
    required this.gettedNotification,
    required this.onSuccess,
  })  : assert(forDescription ^ forTitle,
            "you should specify for what this bottomsheet should be, forDescription or forTitle"),
        super(key: key);
  final MainController mainController = Get.put(MainController());
  String hint;
  void Function() onSuccess;
  NewItemNotifcationModel gettedNotification;
  bool forTitle, forDescription;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 30,
      ),
      color: Theme.of(context).backgroundColor,
      child: GetBuilder<NewNotificationController>(
        init: NewNotificationController(),
        builder: (newNotificationController) => Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            if (forTitle) ...[
              GetBuilder<NewNotificationController>(
                init: NewNotificationController(),
                builder: (newNotificationController) {
                  return CustomTextField(
                    textColor: Theme.of(context).primaryColor,
                    counterBpxColor: Theme.of(context).primaryColor,
                    counterTextColor: Theme.of(context).backgroundColor,
                    backgroundColor:
                        Theme.of(context).primaryColor.withOpacity(.2),
                    showCounter: true,
                    counterBoxScale:
                        newNotificationController.titleCountBoxScale,
                    titleWrittenLength:
                        newNotificationController.titleWrittenLength,
                    onChanged: (value) {
                      newNotificationController.countTitleLength(value);
                    },
                    maxLength: newNotificationController.titleMaxLength,
                    controller: newNotificationController.titleController,
                    hintText:
                        mainController.allFirstWordLetterToUppercase("title"),
                  );
                },
              ),
            ],
            if (forDescription) ...[
              GetBuilder<NewNotificationController>(
                builder: (newNotificationController) {
                  return CustomTextField(
                    textColor: Theme.of(context).primaryColor,
                    counterTextColor: Theme.of(context).backgroundColor,
                    counterBpxColor: Theme.of(context).primaryColor,
                    backgroundColor:
                        Theme.of(context).primaryColor.withOpacity(.2),
                    key: newNotificationController.descriptionTextFieldKey,
                    showCounter: true,
                    counterBoxScale:
                        newNotificationController.descriptionCountBoxScale,
                    titleWrittenLength:
                        newNotificationController.descriptionWrittenLength,
                    onChanged: (value) {
                      newNotificationController.countDescriptionLength(value);
                    },
                    maxLength: newNotificationController.descriptionMaxLength,
                    controller: newNotificationController.descriptionController,
                    hintText: mainController
                        .allFirstWordLetterToUppercase("description"),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 30, horizontal: 15),
                  );
                },
              ),
            ],
            SizedBox(
              height: 20,
            ),
            // ignore: avoid_unnecessary_containers
            Container(
              // this is for that the counter box will be aligned with success button
              // margin: EdgeInsets.only(right: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  GetBuilder<NewNotificationController>(
                    init: NewNotificationController(),
                    builder: (newNotificationController) {
                      return GestureDetector(
                        onTap: () {
                          if (forTitle) {
                            newNotificationController.titleController.text = "";
                            newNotificationController.countTitleLength("");
                            newNotificationController.titleWrittenLength = 0;
                          }

                          if (forDescription) {
                            newNotificationController
                                .descriptionController.text = "";
                            newNotificationController
                                .countDescriptionLength("");
                            newNotificationController.descriptionWrittenLength =
                                0;
                          }
                        },
                        child: CustomActionIconButton(
                            icon: Icons.restart_alt,
                            shouldReverseColors: false),
                      );
                    },
                  ),
                  GestureDetector(
                    onTap: onSuccess,
                    child: CustomActionIconButton(
                        icon: Icons.done, shouldReverseColors: true),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
