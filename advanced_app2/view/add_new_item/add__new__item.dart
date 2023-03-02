import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/main__controller.dart';
import '../../controllers/notifications__controllers/date__Controller.dart';
import '../../controllers/notifications__controllers/extensions/assing_dull_date.dart';
import '../../controllers/notifications__controllers/extensions/get_date_and_time_both_full.dart';
import '../../controllers/notifications__controllers/new__item__notification__controller.dart';
import '../general__widgets/action__button.dart';
import '../general__widgets/button.dart';
import '../general__widgets/text__field.dart';
import 'widgets/description.dart';
import 'widgets/new__title.dart';
import 'widgets/option.dart';

class AddNewItemScreen extends StatelessWidget {
  AddNewItemScreen({Key? key}) : super(key: key);

  // Dependencies injection
  final MainController mainController = Get.put(MainController());
  final DateController dateController = Get.put(DateController());
  final NewNotificationController newNotificationController =
      Get.put(NewNotificationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      // The column should be scrollable so :
      body: SingleChildScrollView(
        // But in this case it will be scrollable to infinity, so we need to set constraints so:
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height,
            maxWidth: MediaQuery.of(context).size.width,
          ),
          child: Container(
            padding: const EdgeInsets.all(20),
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: const Align(
                        alignment: Alignment.centerRight,
                        child: CustomActionIconButton(
                          shouldReverseColors: true,
                          icon: Icons.close,
                        ),
                      ),
                    ),
                  ],
                ),
                NewTitle(
                  mainController: mainController,
                  text: 'new',
                ),
                const SizedBox(
                  height: 10,
                ),
                Description(
                  text:
                      "write the title and description of your notification and set a schedule",
                  mainController: mainController,
                ),
                const Spacer(),
                //one init of controller is enough

                GetBuilder<NewNotificationController>(
                  init: NewNotificationController(),
                  builder: (newNotificationController) {
                    return CustomTextField(
                      key: const Key("title field"),
                      counterTextColor: Theme.of(context).backgroundColor,
                      counterBpxColor: Theme.of(context).primaryColor,
                      textColor: Theme.of(context).primaryColor,
                      backgroundColor:
                          Theme.of(context).primaryColor.withOpacity(.2),
                      // key: newNotificationController.titleTextFieldKey,
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
                const SizedBox(height: 20),
                GetBuilder<NewNotificationController>(
                  builder: (newNotificationController) {
                    return CustomTextField(
                      key: const Key("description field"),
                      counterBpxColor: Theme.of(context).primaryColor,
                      counterTextColor: Theme.of(context).backgroundColor,
                      textColor: Theme.of(context).primaryColor,
                      backgroundColor:
                          Theme.of(context).primaryColor.withOpacity(.2),
                      // key: newNotificationController.descriptionTextFieldKey,
                      showCounter: true,
                      counterBoxScale:
                          newNotificationController.descriptionCountBoxScale,
                      titleWrittenLength:
                          newNotificationController.descriptionWrittenLength,
                      onChanged: (value) {
                        newNotificationController.countDescriptionLength(value);
                      },
                      maxLength: newNotificationController.descriptionMaxLength,
                      controller:
                          newNotificationController.descriptionController,
                      hintText: mainController
                          .allFirstWordLetterToUppercase("description"),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 30, horizontal: 15),
                    );
                  },
                ),
                const Spacer(),
                GetBuilder<NewNotificationController>(
                  builder: (newNotificationController) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          key: const Key("date icon"),
                          child: GestureDetector(
                            onTap: () async {
                              var gettedDate =
                                  await dateController.getFullDateFromUser();
                              dateController.fullDate(gettedDate);
                            },
                            child: Option(
                              mainController: mainController,
                              text: "date",
                              icon: Icons.calendar_month_outlined,
                            ),
                          ),
                        ),
                        Expanded(
                          key: const Key("daily icon"),
                          child: GestureDetector(
                            onTap: () {
                              newNotificationController
                                  .toggleRepeatedOptionBoolean();

                              // print(
                              //     "${newNotificationController.isRepeatedOptionEnabled}, ${newNotificationController.isAlarmOptionEnabled}");
                            },
                            child: Opacity(
                              opacity: newNotificationController
                                      .isRepeatedOptionEnabled
                                  ? 1
                                  : .55,
                              child: Option(
                                mainController: mainController,
                                text: "repeat",
                                icon: Icons.repeat,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          key: const Key("auto delete icon"),
                          child: GestureDetector(
                            onTap: () {
                              newNotificationController
                                  .toggleAlarmOptionBoolean();
                            },
                            child: Opacity(
                              opacity:
                                  newNotificationController.hasAutoDeleteEnabled
                                      ? 1
                                      : .55,
                              child: Option(
                                mainController: mainController,
                                text: "auto delete",
                                icon: Icons.auto_delete,
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),

                const Spacer(),
                SizedBox(
                  width: double.infinity,
                  child: CustomButton(
                    key: const Key("create button"),
                    onPressed: () {
                      newNotificationController.addNewNotification(
                        newNotificationController.titleController.text.trim(),
                        newNotificationController.descriptionController.text
                            .trim(),
                        dateController.date,
                        newNotificationController.isRepeatedOptionEnabled,
                        newNotificationController.hasAutoDeleteEnabled,
                      );
                    },
                    text:
                        mainController.allFirstWordLetterToUppercase("create"),
                    shouldReverseColors: true,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
