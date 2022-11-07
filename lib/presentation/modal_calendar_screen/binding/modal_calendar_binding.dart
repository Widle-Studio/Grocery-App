import '../controller/modal_calendar_controller.dart';
import 'package:get/get.dart';

class ModalCalendarBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ModalCalendarController());
  }
}
