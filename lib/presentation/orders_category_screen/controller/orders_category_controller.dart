import '/core/app_export.dart';
import 'package:grocery_app/presentation/orders_category_screen/models/orders_category_model.dart';

class OrdersCategoryController extends GetxController {
  Rx<OrdersCategoryModel> ordersCategoryModelObj = OrdersCategoryModel().obs;

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
