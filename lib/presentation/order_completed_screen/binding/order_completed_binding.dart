import '../controller/order_completed_controller.dart';
import 'package:get/get.dart';

class OrderCompletedBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => OrderCompletedController());
  }
}
