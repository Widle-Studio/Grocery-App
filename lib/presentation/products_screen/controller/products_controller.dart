import '/core/app_export.dart';import 'package:grocery_app/presentation/products_screen/models/products_model.dart';import 'package:flutter/material.dart';class ProductsController extends GetxController {TextEditingController buttonswebsolController = TextEditingController();

TextEditingController buttonswebsolOneController = TextEditingController();

TextEditingController buttonswebsolTwoController = TextEditingController();

TextEditingController buttonswebsolThreeController = TextEditingController();

Rx<ProductsModel> productsModelObj = ProductsModel().obs;

@override void onReady() { super.onReady(); } 
@override void onClose() { super.onClose(); buttonswebsolController.dispose(); buttonswebsolOneController.dispose(); buttonswebsolTwoController.dispose(); buttonswebsolThreeController.dispose(); } 
 }
