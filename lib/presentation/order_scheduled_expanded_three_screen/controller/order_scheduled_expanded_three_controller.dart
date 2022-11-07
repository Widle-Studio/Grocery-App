import '/core/app_export.dart';import 'package:grocery_app/presentation/order_scheduled_expanded_three_screen/models/order_scheduled_expanded_three_model.dart';import 'package:flutter/material.dart';class OrderScheduledExpandedThreeController extends GetxController {TextEditingController buttonsmobileController = TextEditingController();

Rx<OrderScheduledExpandedThreeModel> orderScheduledExpandedThreeModelObj = OrderScheduledExpandedThreeModel().obs;

@override void onReady() { super.onReady(); } 
@override void onClose() { super.onClose(); buttonsmobileController.dispose(); } 
 }
