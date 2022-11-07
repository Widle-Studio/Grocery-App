import '../controller/new_registration_controller.dart';
import 'package:get/get.dart';

class NewRegistrationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NewRegistrationController());
  }
}
