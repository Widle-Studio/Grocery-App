import '../controller/my_addresses_controller.dart';
import 'package:get/get.dart';

class MyAddressesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MyAddressesController());
  }
}
