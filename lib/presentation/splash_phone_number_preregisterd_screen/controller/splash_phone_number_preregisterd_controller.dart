import '/core/app_export.dart';import 'package:grocery_app/presentation/splash_phone_number_preregisterd_screen/models/splash_phone_number_preregisterd_model.dart';import 'package:flutter/material.dart';class SplashPhoneNumberPreregisterdController extends GetxController {TextEditingController group7CopyController = TextEditingController();

Rx<SplashPhoneNumberPreregisterdModel> splashPhoneNumberPreregisterdModelObj = SplashPhoneNumberPreregisterdModel().obs;

Rx<bool> isShowPassword = false.obs;

@override void onReady() { super.onReady(); } 
@override void onClose() { super.onClose(); group7CopyController.dispose(); } 
 }
