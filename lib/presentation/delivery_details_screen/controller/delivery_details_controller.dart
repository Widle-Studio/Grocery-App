import '/core/app_export.dart';import 'package:grocery_app/presentation/delivery_details_screen/models/delivery_details_model.dart';import 'package:flutter/material.dart';class DeliveryDetailsController extends GetxController {TextEditingController buttonsmobileController = TextEditingController();

Rx<DeliveryDetailsModel> deliveryDetailsModelObj = DeliveryDetailsModel().obs;

@override void onReady() { super.onReady();Future.delayed(const Duration(milliseconds: 10000), (){
Get.toNamed(AppRoutes.splashScreen);}); } 
@override void onClose() { super.onClose(); buttonsmobileController.dispose(); } 
 }
