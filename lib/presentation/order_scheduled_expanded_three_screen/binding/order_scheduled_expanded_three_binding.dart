import '../controller/order_scheduled_expanded_three_controller.dart';
import 'package:get/get.dart';

class OrderScheduledExpandedThreeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => OrderScheduledExpandedThreeController());
  }
}
