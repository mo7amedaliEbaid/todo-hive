import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lottie/lottie.dart';

import '../../../../controllers/main__controller.dart';
import '../../../../controllers/search__controller/search__controller.dart';
import '../../../../model/newItemNotificationModel.dart';
import '../../../general__widgets/nothing__to__show__text.dart';
import '../../../general__widgets/notification__card.dart';
import '../../../general__widgets/screen__title.dart';
import '../../../general__widgets/text__field.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);
  // Dependency injection
  final MainController mainController = Get.put(MainController());
  final searchController = Get.lazyPut(() => MySearchController());

  //
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(left: 20),
      child: GetBuilder<MySearchController>(
          init: MySearchController(),
          builder: (searchController) {
            return SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const SizedBox(height: 40),

                    //
                    ScreenTitle(
                      title: "search by title",
                      mainController: mainController,
                    ), //

                    //
                    const SizedBox(height: 30),

                    Container(
                      margin: const EdgeInsets.only(right: 20),
                      child: CustomTextField(
                        key: const Key("search field"),
                        autoFocus: false,
                        counterTextColor: Theme.of(context).primaryColor,
                        counterBpxColor: Theme.of(context).backgroundColor,
                        textColor: Theme.of(context).primaryColor,
                        backgroundColor:
                            Theme.of(context).primaryColor.withOpacity(.2),
                        maxLength: 50,
                        onChanged: (value) {
                          searchController.update();
                        },
                        controller: searchController.searchBarController,
                        hintText: mainController
                            .allFirstWordLetterToUppercase("search"),
                        suffixIcon: const Icon(Icons.search),
                      ),
                    ),
                    //

                    ValueListenableBuilder(
                        valueListenable: Hive.box<NewItemNotifcationModel>(
                                "newNotificationsBox")
                            .listenable(),
                        builder: (BuildContext context,
                            Box<NewItemNotifcationModel> box, __) {
                          return Column(
                            children: <Widget>[
                              if (searchController
                                  .searchBarController.text.isEmpty) ...[
                                const NothingToShow(
                                  key: Key("nothing to show"),
                                  text: "search\nIn your notifications",
                                )
                              ],
                              // const SizedBox(height: 100),
                              if (searchController
                                      .searchBarController.text.isNotEmpty &&
                                  searchController
                                      .filterList(
                                        box.values.toList(),
                                        searchController
                                            .searchBarController.text,
                                      )
                                      .isEmpty) ...[
                                const SizedBox(height: 50),
                                Center(
                                  child: SizedBox(
                                    width: double.infinity,
                                    child: Column(
                                      key: const Key("lottie"),
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Container(
                                          margin:
                                              const EdgeInsets.only(right: 20),
                                          child: Lottie.asset(
                                            "assets/lottie/not_found.json",
                                            width: 120,
                                          ),
                                        ),
                                        NothingToShow(
                                          margin: const EdgeInsets.only(
                                              right: 20, top: 20),
                                          text: "no notifications\nfound",
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                              if (searchController
                                  .searchBarController.text.isNotEmpty) ...[
                                const SizedBox(height: 50),
                                ...List.generate(
                                  box.values.length,
                                  (index) {
                                    // reversedIndex
                                    int reversedIndex =
                                        box.values.length - 1 - index;

                                    // currentNotification
                                    NewItemNotifcationModel?
                                        currentNotification =
                                        box.getAt(reversedIndex);

                                    // *** condition
                                    if (searchController.filterElement(
                                      searchController.searchBarController.text,
                                      currentNotification!,
                                    )) {
                                      return NotificationCard(
                                        currentNotification:
                                            currentNotification,
                                        reversedIndex: index,
                                        // "favoritesController.favoritesItemsNotificationList.length - 1" get us to lase item, with "- index", so like we say we should start from the end
                                        title: currentNotification.title,
                                        description:
                                            currentNotification.description,
                                        isFavoriteButtonHidden: true,
                                        showDeleteButtonOnFullPage: false,
                                      );
                                    }

                                    // work like nothing
                                    return Container();
                                  },
                                )
                              ]
                            ],
                          );
                        })
                  ]),
            );
          }),
    );
  }
}
