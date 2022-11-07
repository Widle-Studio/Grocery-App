import '../controller/order_processing_collapsed_controller.dart';
import 'package:get/get.dart';

class OrderProcessingCollapsedBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => OrderProcessingCollapsedController());
  }
}
