import '../controller/modal_confirmation_controller.dart';
import 'package:get/get.dart';

class ModalConfirmationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ModalConfirmationController());
  }
}
