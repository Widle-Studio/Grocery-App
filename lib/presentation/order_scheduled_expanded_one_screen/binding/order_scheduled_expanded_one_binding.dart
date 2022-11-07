import '../controller/order_scheduled_expanded_one_controller.dart';
import 'package:get/get.dart';

class OrderScheduledExpandedOneBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => OrderScheduledExpandedOneController());
  }
}
