import '/core/app_export.dart';import 'package:grocery_app/presentation/orders_history_screen/models/orders_history_model.dart';class OrdersHistoryController extends GetxController {Rx<OrdersHistoryModel> ordersHistoryModelObj = OrdersHistoryModel().obs;

@override void onReady() { super.onReady(); } 
@override void onClose() { super.onClose(); } 
 }
