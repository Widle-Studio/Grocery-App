import '../controller/select_loaction_controller.dart';
import 'package:get/get.dart';

class SelectLoactionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SelectLoactionController());
  }
}
