import '../controller/full_package_details_controller.dart';
import 'package:get/get.dart';

class FullPackageDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FullPackageDetailsController());
  }
}
