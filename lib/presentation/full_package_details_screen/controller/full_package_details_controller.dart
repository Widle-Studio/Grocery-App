import '/core/app_export.dart';import 'package:grocery_app/presentation/full_package_details_screen/models/full_package_details_model.dart';import 'package:flutter/material.dart';class FullPackageDetailsController extends GetxController {TextEditingController buttonsmobileController = TextEditingController();

Rx<FullPackageDetailsModel> fullPackageDetailsModelObj = FullPackageDetailsModel().obs;

@override void onReady() { super.onReady(); } 
@override void onClose() { super.onClose(); buttonsmobileController.dispose(); } 
 }
