import '../controller/more_wishlist_details_controller.dart';
import 'package:get/get.dart';

class MoreWishlistDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MoreWishlistDetailsController());
  }
}
