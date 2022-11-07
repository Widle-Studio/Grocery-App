import '../controller/orders_history_controller.dart';
import 'package:get/get.dart';

class OrdersHistoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => OrdersHistoryController());
  }
}
