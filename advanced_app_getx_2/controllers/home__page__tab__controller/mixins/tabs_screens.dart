import 'package:flutter/material.dart';

import '../../../view/main__page/tabs__screens/favorites/favorites.dart';
import '../../../view/main__page/tabs__screens/home/home.dart';
import '../../../view/main__page/tabs__screens/search/search.dart';
import '../../../view/main__page/tabs__screens/settings/settings.dart';

mixin TabsScreensMixins {
  /// tabs screens
  List<StatelessWidget> tabScreens = [
    HomeScreen(),
    SearchScreen(),
    FavoritesScreen(),
    SettingsScreen(),
  ];
}
