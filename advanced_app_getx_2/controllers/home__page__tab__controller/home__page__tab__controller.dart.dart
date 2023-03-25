import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utils/strict__mode__for production.dart';
import 'mixins/tabs_from.dart';
import 'home__page__tab__errors_controller.dart';
import 'mixins/tabs_icons.dart';
import 'mixins/tabs_screens.dart';

// TickerProvider help us listen to changes of every frame at 60fps or higher
class BottomBarController extends GetxController
    with
        TabsScreensMixins,
        TabsIconsListMixin,
        GetSingleTickerProviderStateMixin,
        TabsFromMethodMixin {
  //
  BottomBarController({required this.context}) {
    tabs = tabsFrom(tabsIcons, context);
  }

  late final TabController tabController;
  late final List<Tooltip> tabs;
  final BuildContext context;

///////////////////////////////

  @override
  void onInit() {
    // this initialize the tabController when the app open
    tabController = TabController(vsync: this, length: tabs.length);

    super.onInit();
  }

  @override
  void onReady() {
    TabErrorsController(
      activateOnCondition: isStrictProductionMode,
      tabsIcons: tabsIcons,
      tabsScreens: tabScreens,
    ).init();

    super.onReady();
  }

  @override
  void onClose() {
    // since the screens navigation controlled with the tabs this is actually just an important sugar
    tabController.dispose();
    super.onClose();
  }
}
