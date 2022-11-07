import '/core/app_export.dart';import 'package:grocery_app/presentation/select_loaction_screen/models/select_loaction_model.dart';import 'package:flutter/material.dart';class SelectLoactionController extends GetxController {TextEditingController group7CopyController = TextEditingController();

TextEditingController buttonsmobileController = TextEditingController();

Rx<SelectLoactionModel> selectLoactionModelObj = SelectLoactionModel().obs;

@override void onReady() { super.onReady(); } 
@override void onClose() { super.onClose(); group7CopyController.dispose(); buttonsmobileController.dispose(); } 
 }
