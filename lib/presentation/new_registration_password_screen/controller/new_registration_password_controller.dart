import '/core/app_export.dart';import 'package:grocery_app/presentation/new_registration_password_screen/models/new_registration_password_model.dart';import 'package:flutter/material.dart';class NewRegistrationPasswordController extends GetxController {TextEditingController group7CopyController = TextEditingController();

TextEditingController group7CopyOneController = TextEditingController();

Rx<NewRegistrationPasswordModel> newRegistrationPasswordModelObj = NewRegistrationPasswordModel().obs;

Rx<bool> isShowPassword = false.obs;

Rx<bool> isShowPassword1 = false.obs;

@override void onReady() { super.onReady(); } 
@override void onClose() { super.onClose(); group7CopyController.dispose(); group7CopyOneController.dispose(); } 
 }
