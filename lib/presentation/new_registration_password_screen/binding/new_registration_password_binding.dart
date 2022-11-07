import '../controller/new_registration_password_controller.dart';
import 'package:get/get.dart';

class NewRegistrationPasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NewRegistrationPasswordController());
  }
}
