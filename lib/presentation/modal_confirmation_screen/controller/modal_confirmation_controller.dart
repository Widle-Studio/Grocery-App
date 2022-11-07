import '/core/app_export.dart';
import 'package:grocery_app/presentation/modal_confirmation_screen/models/modal_confirmation_model.dart';
import 'package:flutter/material.dart';

class ModalConfirmationController extends GetxController {
  TextEditingController buttonsmobileController = TextEditingController();

  Rx<ModalConfirmationModel> modalConfirmationModelObj =
      ModalConfirmationModel().obs;

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    buttonsmobileController.dispose();
  }
}
