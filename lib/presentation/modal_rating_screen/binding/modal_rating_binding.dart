import '../controller/modal_rating_controller.dart';
import 'package:get/get.dart';

class ModalRatingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ModalRatingController());
  }
}
