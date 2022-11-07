import '../controller/splash_phone_number_preregisterd_controller.dart';
import 'package:get/get.dart';

class SplashPhoneNumberPreregisterdBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SplashPhoneNumberPreregisterdController());
  }
}
