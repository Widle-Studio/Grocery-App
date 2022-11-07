import '../controller/home_container_controller.dart';
import 'package:get/get.dart';

class HomeContainerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeContainerController());
  }
}
