class TabErrorsController {
  TabErrorsController({
    required this.activateOnCondition,
    required this.tabsIcons,
    required this.tabsScreens,
  });

  bool activateOnCondition;
  List tabsIcons, tabsScreens;
  checkTabsIconsIfRepeated(List tabsIcons) {
    if (tabsIcons.toSet().toList().length != tabsIcons.length) {
      throw "there's repeated icons, why you would use same icons in production";
    }
  }

  checkTabsScreensIfRepeated(List tabsScreens) {
    if (tabsScreens.toSet().toList().length != tabsScreens.length) {
      throw "there's repeated screens, why you would put the same screen from different tabs in production";
    }
  }

  init() {
    if (activateOnCondition) {
      checkTabsIconsIfRepeated(tabsIcons);
      checkTabsScreensIfRepeated(tabsScreens);
    }
  }
}
