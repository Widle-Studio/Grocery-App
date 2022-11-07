import '../controller/search_search_result_controller.dart';
import 'package:get/get.dart';

class SearchSearchResultBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SearchSearchResultController());
  }
}
