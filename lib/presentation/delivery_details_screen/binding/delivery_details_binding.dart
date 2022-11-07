import '../controller/delivery_details_controller.dart';
import 'package:get/get.dart';

class DeliveryDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DeliveryDetailsController());
  }
}
