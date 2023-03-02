import 'package:get/get.dart';

import '../controllers/favorites__controller/favorites__controller.dart';

class FavoritesBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<FavoritesController>(FavoritesController());
  }
}
