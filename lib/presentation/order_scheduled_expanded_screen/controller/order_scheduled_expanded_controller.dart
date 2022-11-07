import '/core/app_export.dart';import 'package:grocery_app/presentation/order_scheduled_expanded_screen/models/order_scheduled_expanded_model.dart';import 'package:flutter/material.dart';class OrderScheduledExpandedController extends GetxController {TextEditingController buttonsmobileController = TextEditingController();

Rx<OrderScheduledExpandedModel> orderScheduledExpandedModelObj = OrderScheduledExpandedModel().obs;

@override void onReady() { super.onReady(); } 
@override void onClose() { super.onClose(); buttonsmobileController.dispose(); } 
 }
