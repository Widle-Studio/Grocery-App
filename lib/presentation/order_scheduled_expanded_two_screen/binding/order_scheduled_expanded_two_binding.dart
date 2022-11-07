import '../controller/order_scheduled_expanded_two_controller.dart';
import 'package:get/get.dart';

class OrderScheduledExpandedTwoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => OrderScheduledExpandedTwoController());
  }
}
