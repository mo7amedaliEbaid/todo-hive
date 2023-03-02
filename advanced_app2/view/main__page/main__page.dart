import 'package:flutter_point_tab_bar/pointTabBar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/helpers__controllers/on__notification__click.dart';
import '../../controllers/home__page__tab__controller/home__page__tab__controller.dart.dart';

class MainPage extends StatelessWidget {
  const MainPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    final BottomBarController bottomBarController =
        Get.put(BottomBarController(context: context));
    // even this is marked unused, it's not
    final onNotificationClick =
        Get.lazyPut(() => OnNotificationClick(payload: Get.arguments));
    return SafeArea(
      child: Scaffold(
        backgroundColor: theme.backgroundColor,
        extendBody: true,
        bottomNavigationBar: Container(
          height: 60,
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
          ),
          child: BottomAppBar(
            color: theme.primaryColor,
            child: Theme(
              data: ThemeData(
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
              ),
              child: RepaintBoundary(
                child: TabBar(
                  key: const Key("tabBar"),
                  automaticIndicatorColorAdjustment: true,
                  indicator: PointTabIndicator(
                    position: PointTabIndicatorPosition.bottom,
                    color: theme.indicatorColor,
                    insets: const EdgeInsets.only(bottom: 10),
                  ),
                  labelStyle: const TextStyle(fontSize: 12),
                  controller: bottomBarController.tabController,
                  tabs: bottomBarController.tabs,
                  unselectedLabelColor: theme.indicatorColor.withOpacity(.6),
                  labelColor: theme.indicatorColor,
                ),
              ),
            ),
          ),
        ),
        body: ScrollConfiguration(
          behavior: const ScrollBehavior().copyWith(
            overscroll: false,
          ),
          child: TabBarView(
            controller: bottomBarController.tabController,
            children: <Widget>[
              ...List.generate(
                bottomBarController.tabScreens.length,
                (index) => bottomBarController.tabScreens[index],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
