import '/core/app_export.dart';
import 'package:grocery_app/presentation/home_page/models/home_model.dart';
import 'package:flutter/material.dart';

class HomeController extends GetxController {
  HomeController(this.homeModelObj);

  TextEditingController group7CopyController = TextEditingController();

  Rx<HomeModel> homeModelObj;

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    group7CopyController.dispose();
  }
}
