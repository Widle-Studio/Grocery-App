import '../controller/customer_support_chat_keyboard_controller.dart';
import 'package:get/get.dart';

class CustomerSupportChatKeyboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CustomerSupportChatKeyboardController());
  }
}
