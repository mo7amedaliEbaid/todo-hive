import 'package:flutter/material.dart';

mixin TabsIconsListMixin {
  
  /// note: the number of tabIcons, tabScreens should be equal, otherwise the framework will throw error
  // and for production, no icon should not be repeated(why do you need duplicated icons in tabBar)
  // icons
  List<Map<String, dynamic>> tabsIcons = [
    {
      "icon": Icons.home,
      "tooltip": "Home",
    },
    {
      "icon": Icons.search,
      "tooltip": "Search",
    },
    {
      "icon": Icons.favorite,
      "tooltip": "Favorites",
    },
    {
      "icon": Icons.settings,
      "tooltip": "Settings",
    },
  ];

}