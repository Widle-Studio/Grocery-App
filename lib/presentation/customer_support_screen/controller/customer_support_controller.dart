import '/core/app_export.dart';import 'package:grocery_app/presentation/customer_support_screen/models/customer_support_model.dart';import 'package:grocery_app/widgets/custom_bottom_bar.dart';class CustomerSupportController extends GetxController {Rx<CustomerSupportModel> customerSupportModelObj = CustomerSupportModel().obs;

Rx<BottomBarEnum> type = BottomBarEnum.Imghome.obs;

@override void onReady() { super.onReady(); } 
@override void onClose() { super.onClose(); } 
 }
