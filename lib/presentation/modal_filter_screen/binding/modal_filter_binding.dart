import '../controller/modal_filter_controller.dart';
import 'package:get/get.dart';

class ModalFilterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ModalFilterController());
  }
}
