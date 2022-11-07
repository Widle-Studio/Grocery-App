import '../controller/order_scheduled_expanded_controller.dart';
import 'package:get/get.dart';

class OrderScheduledExpandedBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => OrderScheduledExpandedController());
  }
}
