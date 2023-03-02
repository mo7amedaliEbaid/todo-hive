import 'package:flutter/material.dart';

mixin TabsFromMethodMixin {
  /// This function will return a list of tabs wrapped with tooltip from
  List<Tooltip> tabsFrom(List<Map<String, dynamic>> tabsIcons, context) {
    return tabsIcons
        .map(
          (item) => Tooltip(
            message: item["tooltip"],
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(3),
            ),
            textStyle: TextStyle(
              color: Theme.of(context).backgroundColor,
              fontSize: 12,
            ),
            margin: const EdgeInsets.only(bottom: 10),
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 7),
            child: Tab(
              icon: Icon(
                item["icon"],
              ),
            ),
          ),
        )
        .toList();
  }
}
