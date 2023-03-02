import 'package:get/get_navigation/src/routes/get_route.dart';

import '../bindings/favorites_binding.dart';
import '../bindings/get_started_binding.dart';
import '../view/get__started/get__started__page.dart';
import '../view/get__username__from__user/get__username__page.dart';
import '../view/main__page/main__page.dart';
import '../view/main__page/tabs__screens/favorites/favorites.dart';
import '../view/notification__full__page/notification__full__page.dart';

List<GetPage> getPages = [
  GetPage(
    name: '/getStarted',
    page: () => const GetStartedPage(),
  ),
  GetPage(
    name: '/getUsername',
    page: () => const GetUsernamePage(),
    binding: GetUsernameBinding(),
  ),
  GetPage(
    name: '/main',
    page: () => const MainPage(),
  ),
  GetPage(
    name: '/notificationFull',
    page: () => NotificationFullPage(),
  ),
  GetPage(
    name: '/favorites',
    page: () => FavoritesScreen(),
    binding: FavoritesBinding(),
  ),
];

class Paths {
  static const String getStartedPath = '/getStarted';
  static const String getUsernamePage = '/getUsername';
  static const String mainPath = '/main';
  static const String notificationFullPage = '/notificationFull';
}
