import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/main__controller.dart';
import '../../../utils/AppColors.dart';

class FavoriteBox extends StatelessWidget {
  FavoriteBox({Key? key, required this.dataList, required this.indexPass})
      : super(key: key);
  int indexPass;
  List dataList;
  final MainController mainController = Get.put(MainController());
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 70,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        fit: StackFit.expand,
        clipBehavior: Clip.hardEdge,
        children: <Widget>[
          Image.asset(dataList[indexPass]["image"], fit: BoxFit.cover),
          Material(
            animationDuration: const Duration(milliseconds: 400),
            color: Theme.of(context).primaryColor.withOpacity(.55),
            child: InkWell(
              onTap: () {},
              highlightColor: Colors.transparent,
              splashColor: Theme.of(context).primaryColor.withOpacity(.5),
              child: Container(
                width: double.infinity,
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: AutoSizeText(
              mainController
                  .allFirstWordLetterToUppercase(dataList[indexPass]["name"]),
              style: TextStyle(
                letterSpacing: 1.5,
                color: AppColors.white,
                fontSize: 25,
                fontWeight: FontWeight.w500,
              ),
              maxLines: 1,
            ),
          ),
        ],
      ),
    );
  }
}
