import '/core/app_export.dart';import 'package:grocery_app/presentation/order_scheduled_expanded_two_screen/models/order_scheduled_expanded_two_model.dart';import 'package:flutter/material.dart';class OrderScheduledExpandedTwoController extends GetxController {TextEditingController buttonsmobileController = TextEditingController();

Rx<OrderScheduledExpandedTwoModel> orderScheduledExpandedTwoModelObj = OrderScheduledExpandedTwoModel().obs;

@override void onReady() { super.onReady(); } 
@override void onClose() { super.onClose(); buttonsmobileController.dispose(); } 
 }
