import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/main__controller.dart';
import '../../model/newItemNotificationModel.dart';
import 'favorite_icon__button.dart';

class NotificationCard extends StatefulWidget {
  const NotificationCard({
    Key? key,
    this.showDeleteButtonOnFullPage = false,
    required this.currentNotification,
    required this.reversedIndex,
    required this.title,
    required this.description,
    this.isFavoriteButtonHidden = false,
  }) : super(key: key);

  final NewItemNotifcationModel? currentNotification;
  final int reversedIndex;

  final String title, description;
  final bool isFavoriteButtonHidden, showDeleteButtonOnFullPage;

  @override
  State<NotificationCard> createState() => _NotificationCardState();
}

class _NotificationCardState extends State<NotificationCard> {
  double scale = 1;

  final MainController mainController = Get.put(MainController());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (details) {
        setState(() {
          scale = 1.05;
        });
      },
      onTapCancel: () {
        setState(() {
          scale = 1;
        });
      },
      onTapUp: (details) {
        setState(() {
          scale = 1;
        });
      },
      onTap: () {
        Get.toNamed('/notificationFullPage', arguments: [
          widget.currentNotification,
          widget.reversedIndex,
          widget.showDeleteButtonOnFullPage,
        ]);
      },
      child: AnimatedScale(
        duration: const Duration(milliseconds: 100),
        scale: scale,
        curve: Curves.easeInOutQuart,
        child: Container(
          width: double.infinity,
          margin: const EdgeInsets.only(bottom: 20),
          height: 120,
          child: Row(
            children: <Widget>[
              AnimatedOpacity(
                opacity: scale == 1 ? 1 : 0.1,
                duration: const Duration(milliseconds: 100),
                curve: Curves.easeInOutQuart,
                child: Row(
                  children: <Widget>[
                    Container(
                      width: 15,
                      height: 15,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(
                            width: 3.5, color: Theme.of(context).primaryColor),
                      ),
                    ),
                    Container(
                      width: 7,
                      height: 2,
                      color: Theme.of(context).primaryColor,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Stack(
                  fit: StackFit.expand,
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor.withOpacity(.04),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          const Spacer(
                            flex: 2,
                          ),
                          AutoSizeText(
                            mainController
                                .allFirstWordLetterToUppercase(widget.title),
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                            maxFontSize: 20,
                            maxLines: 1,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          AutoSizeText(
                            widget.description,
                            style: TextStyle(
                                color: Theme.of(context)
                                    .primaryColor
                                    .withOpacity(.6),
                                fontSize: 15),
                            maxFontSize: 15,
                            maxLines: 2,
                          ),
                          const Spacer(),
                        ],
                      ),
                    ),
                    Positioned(
                      top: 4,
                      right: 4,
                      child: Transform.scale(
                        scale: widget.isFavoriteButtonHidden ? 0 : 1,
                        child: FavoriteIconButton(
                          size: 23,
                          isChecked:
                              widget.currentNotification?.isFavorite ?? false,
                          passedIndex: widget.reversedIndex,
                        ),
                      ),
                    ),
                    Positioned(
                      right: 10,
                      bottom: 3,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          if (widget.currentNotification!.isRepeated) ...[
                            Icon(
                              Icons.repeat,
                              size: 12,
                              color: Theme.of(context)
                                  .primaryColor
                                  .withOpacity(.3),
                            ),
                            const SizedBox(
                              width: 7,
                            ),
                          ],
                          if (widget.currentNotification!.hasAutoDelete) ...[
                            Icon(
                              Icons.auto_delete,
                              size: 12,
                              color: Theme.of(context)
                                  .primaryColor
                                  .withOpacity(.3),
                            ),
                            const SizedBox(
                              width: 7,
                            ),
                          ],
                          Icon(
                            Icons.schedule,
                            size: 12,
                            color:
                                Theme.of(context).primaryColor.withOpacity(.3),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          AutoSizeText(
                            mainController.setDateShow(
                                widget.currentNotification!.dateToShow),
                            style: TextStyle(
                              color: Theme.of(context)
                                  .primaryColor
                                  .withOpacity(.3),
                              fontSize: 8,
                            ),
                            maxLines: 1,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              AnimatedOpacity(
                opacity: scale == 1 ? 1 : 0.1,
                duration: const Duration(milliseconds: 100),
                curve: Curves.easeInOutQuart,
                child: Container(
                  width: 7 * 2,
                  height: 2,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
