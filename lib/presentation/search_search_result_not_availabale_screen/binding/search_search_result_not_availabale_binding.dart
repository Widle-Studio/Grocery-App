import '../controller/search_search_result_not_availabale_controller.dart';
import 'package:get/get.dart';

class SearchSearchResultNotAvailabaleBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SearchSearchResultNotAvailabaleController());
  }
}
