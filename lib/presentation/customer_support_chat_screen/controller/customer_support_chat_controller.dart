import '/core/app_export.dart';import 'package:grocery_app/presentation/customer_support_chat_screen/models/customer_support_chat_model.dart';import 'package:grocery_app/widgets/custom_bottom_bar.dart';class CustomerSupportChatController extends GetxController {Rx<CustomerSupportChatModel> customerSupportChatModelObj = CustomerSupportChatModel().obs;

Rx<BottomBarEnum> type = BottomBarEnum.Imghome.obs;

@override void onReady() { super.onReady(); } 
@override void onClose() { super.onClose(); } 
 }
