import '/core/app_export.dart';import 'package:grocery_app/presentation/my_addresses_screen/models/my_addresses_model.dart';import 'package:flutter/material.dart';class MyAddressesController extends GetxController {TextEditingController buttonsmobileController = TextEditingController();

Rx<MyAddressesModel> myAddressesModelObj = MyAddressesModel().obs;

@override void onReady() { super.onReady(); } 
@override void onClose() { super.onClose(); buttonsmobileController.dispose(); } 
 }
