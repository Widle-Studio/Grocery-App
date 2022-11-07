import '/core/app_export.dart';import 'package:grocery_app/presentation/new_registration_screen/models/new_registration_model.dart';import 'package:flutter/material.dart';class NewRegistrationController extends GetxController {TextEditingController buttonsmobileController = TextEditingController();

TextEditingController group7CopyController = TextEditingController();

Rx<NewRegistrationModel> newRegistrationModelObj = NewRegistrationModel().obs;

@override void onReady() { super.onReady(); } 
@override void onClose() { super.onClose(); buttonsmobileController.dispose(); group7CopyController.dispose(); } 
 }
