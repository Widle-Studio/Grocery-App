import '../controller/orders_category_controller.dart';
import 'package:get/get.dart';

class OrdersCategoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => OrdersCategoryController());
  }
}
