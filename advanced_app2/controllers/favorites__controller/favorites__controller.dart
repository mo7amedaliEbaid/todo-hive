import 'package:get/get.dart';
import '../helpers__controllers/dialogs__controller.dart';

class FavoritesController extends GetxController {
  // Dependency injection
  DialogsController dialogsController = Get.find();

  // ! Initializing the fav. list always to get it from the box by filtering it with where method, in first start of the app it will be just empty list so there is no need to null check for it
  // ! ignore_if_you_know_where_method_very_well: the where return is iterable, so toList() make it list

}
