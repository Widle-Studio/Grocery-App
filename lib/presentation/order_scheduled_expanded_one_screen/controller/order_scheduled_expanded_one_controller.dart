import '/core/app_export.dart';import 'package:grocery_app/presentation/order_scheduled_expanded_one_screen/models/order_scheduled_expanded_one_model.dart';import 'package:flutter/material.dart';class OrderScheduledExpandedOneController extends GetxController {TextEditingController buttonsmobileController = TextEditingController();

TextEditingController buttonsmobileOneController = TextEditingController();

Rx<OrderScheduledExpandedOneModel> orderScheduledExpandedOneModelObj = OrderScheduledExpandedOneModel().obs;

@override void onReady() { super.onReady(); } 
@override void onClose() { super.onClose(); buttonsmobileController.dispose(); buttonsmobileOneController.dispose(); } 
 }
