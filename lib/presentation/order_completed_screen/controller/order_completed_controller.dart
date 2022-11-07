import '/core/app_export.dart';import 'package:grocery_app/presentation/order_completed_screen/models/order_completed_model.dart';import 'package:flutter/material.dart';class OrderCompletedController extends GetxController {TextEditingController buttonsmobileController = TextEditingController();

Rx<OrderCompletedModel> orderCompletedModelObj = OrderCompletedModel().obs;

@override void onReady() { super.onReady(); } 
@override void onClose() { super.onClose(); buttonsmobileController.dispose(); } 
 }
