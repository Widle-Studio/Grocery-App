import '../controller/app_navigation_controller.dart';
import 'package:get/get.dart';

class AppNavigationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AppNavigationController());
  }
}
