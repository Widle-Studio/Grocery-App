import '/core/app_export.dart';
import 'package:grocery_app/presentation/modal_filter_screen/models/modal_filter_model.dart';
import 'package:flutter/material.dart';

class ModalFilterController extends GetxController {
  TextEditingController group7CopyController = TextEditingController();

  TextEditingController group7CopyOneController = TextEditingController();

  Rx<ModalFilterModel> modalFilterModelObj = ModalFilterModel().obs;

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    group7CopyController.dispose();
    group7CopyOneController.dispose();
  }
}
