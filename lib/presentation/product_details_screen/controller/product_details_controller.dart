import '/core/app_export.dart';import 'package:grocery_app/presentation/product_details_screen/models/product_details_model.dart';import 'package:flutter/material.dart';class ProductDetailsController extends GetxController {TextEditingController buttonsmobileController = TextEditingController();

Rx<ProductDetailsModel> productDetailsModelObj = ProductDetailsModel().obs;

@override void onReady() { super.onReady(); } 
@override void onClose() { super.onClose(); buttonsmobileController.dispose(); } 
 }
