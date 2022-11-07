import '../controller/splash_phone_number_otp_controller.dart';
import 'package:get/get.dart';

class SplashPhoneNumberOtpBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SplashPhoneNumberOtpController());
  }
}
