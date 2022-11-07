import '../controller/splash_phone_number_controller.dart';
import 'package:get/get.dart';

class SplashPhoneNumberBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SplashPhoneNumberController());
  }
}
