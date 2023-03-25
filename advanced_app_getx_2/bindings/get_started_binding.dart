import 'package:get/get.dart';

import '../controllers/get__username__controller/get__username__controller.dart';

class GetUsernameBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<GetUsernameController>(GetUsernameController());
  }
}
