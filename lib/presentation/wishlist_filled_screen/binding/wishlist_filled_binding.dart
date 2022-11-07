import '../controller/wishlist_filled_controller.dart';
import 'package:get/get.dart';

class WishlistFilledBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => WishlistFilledController());
  }
}
