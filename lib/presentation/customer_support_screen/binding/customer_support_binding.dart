import '../controller/customer_support_controller.dart';
import 'package:get/get.dart';

class CustomerSupportBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CustomerSupportController());
  }
}
