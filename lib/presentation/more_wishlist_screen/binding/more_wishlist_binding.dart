import '../controller/more_wishlist_controller.dart';
import 'package:get/get.dart';

class MoreWishlistBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MoreWishlistController());
  }
}
