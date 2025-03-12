import 'package:get/get.dart';
import 'package:kamala_update/controller/home_controller.dart';

class homebinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => HomeController(),
    );
  }
}
