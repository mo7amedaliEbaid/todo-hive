import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../../controllers/favorites__controller/favorites__controller.dart';
import '../../../../model/newItemNotificationModel.dart';
import '../../../../utils/extensions/string_extension.dart';
import '../../../general__widgets/nothing__to__show__text.dart';
import '../../../general__widgets/notification__card.dart';

class FavoritesScreen extends GetView<FavoritesController> {
  FavoritesScreen({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(left: 20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 40),

            // Page title
            AutoSizeText(
              "Saved notifications".capitalizeAllWordsFirstLetter(),
              maxLines: 2,
              style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),

            //
            const SizedBox(height: 20),

            // Favorite notifications list
            ValueListenableBuilder(
                valueListenable:
                    Hive.box<NewItemNotifcationModel>("newNotificationsBox")
                        .listenable(),
                builder: (BuildContext context,
                    Box<NewItemNotifcationModel> box, __) {
                  if (box.values
                      .toList()
                      .where((element) => element.isFavorite!)
                      .isEmpty) {
                    return NothingToShow(
                      text: "no favorites",
                    );
                  }
                  return Column(
                    children: <Widget>[
                      ...List.generate(
                        box.values.length,
                        (index) {
                          // reversedIndex
                          int reversedIndex = box.values.length - 1 - index;

                          // currentNotification
                          NewItemNotifcationModel? currentNotification =
                              box.getAt(reversedIndex);

                          // isFavorite condition
                          if (currentNotification!.isFavorite!) {
                            return NotificationCard(
                              currentNotification: currentNotification,
                              reversedIndex: index,
                              // "favoritesController.favoritesItemsNotificationList.length - 1" get us to lase item, with "- index", so like we say we should start from the end
                              title: currentNotification.title,
                              description: currentNotification.description,
                              isFavoriteButtonHidden: true,
                              showDeleteButtonOnFullPage: false,
                            );
                          }

                          // work like nothing
                          return Container();
                        },
                      )
                    ],
                  );
                })
          ],
        ),
      ),
    );
  }
}
