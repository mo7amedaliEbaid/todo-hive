//import 'package:bubble_bottom_bar/bubble_bottom_bar.dart'as bubble;
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../../global_widgets/bottom_sheet.dart';
import '../../../theme/text_theme.dart';
import '../controllers/home_controller.dart';


class HomeView extends GetView<HomeController> {
  final controller = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    controller.getUser();
    return Scaffold(
      body: Obx(() => controller.navBarSwitcher()),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.controllerReset();
          showModalBottomSheet(
            backgroundColor: Colors.transparent,
            isScrollControlled: true,
            context: context,
            builder: (context) {
              return BottomSheetContent(
                buttonText: 'Create Task',
                onSubmit: () {
                  controller.addTask();
                },
              );
            },
          );
        },
        child: Icon(
          Icons.add,
          color: Theme.of(context).scaffoldBackgroundColor,
        ),
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 3,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
         // opacity: 0,
         // fabLocation: bubble.BubbleBottomBarFabLocation.end,
          currentIndex: controller.currentIndex,
          backgroundColor: Theme.of(context).primaryColorLight,
        //  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          //hasInk: false,
          elevation: 7,
        //  inkColor: Colors.black54,
          //hasNotch: true,
          onTap: (index) => controller.currentIndex = index,
          items: [
            BottomNavigationBarItem(icon:Icon(
              // FontAwesomeIcons.home,
              FontAwesomeIcons.house,
              color: Theme.of(context).primaryColorDark,
            ),
              backgroundColor: Colors.grey,
              label:
                'Home',
               // style: kSub2HeadTextStyle.copyWith(fontSize: 16),
              ),

       /*     bubble.BubbleBottomBarItem(
              backgroundColor: Colors.grey,
              title: Text(
                'Home',
                style: kSub2HeadTextStyle.copyWith(fontSize: 16),
              ),
              icon: Icon(
                // FontAwesomeIcons.home,
                FontAwesomeIcons.house,
                color: Theme.of(context).primaryColorDark,
              ),
              // activeIcon: Icon(FontAwesomeIcons.home,
              activeIcon: Icon(
                FontAwesomeIcons.house,
                color: Theme.of(context).primaryColor,
              ),
            ),*/
            BottomNavigationBarItem(
              backgroundColor: Colors.grey,
             label: /*Text(*/
                'Tasks',
                //style: kSub2HeadTextStyle.copyWith(fontSize: 16),
             // ),
              icon: Icon(
                FontAwesomeIcons.listUl,
                color: Theme.of(context).primaryColorDark,
              ),
              activeIcon: Icon(FontAwesomeIcons.listUl,
                  color: Theme.of(context).primaryColor),
            ),
            // BubbleBottomBarItem(
            //   backgroundColor: Colors.grey,
            //   title: Text(
            //     'To-do',
            //     style: kSub2HeadTextStyle.copyWith(fontSize: 16),
            //   ),
            //   icon: Icon(
            //     FontAwesomeIcons.tasks,
            //     color: Theme.of(context).primaryColorDark,
            //   ),
            //   activeIcon: Icon(FontAwesomeIcons.tasks,
            //       color: Theme.of(context).primaryColor),
            // ),
          ],
        ),
      ),
    );
  }
}