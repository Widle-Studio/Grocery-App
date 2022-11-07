import '../controller/customer_support_chat_controller.dart';
import 'package:get/get.dart';

class CustomerSupportChatBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CustomerSupportChatController());
  }
}
