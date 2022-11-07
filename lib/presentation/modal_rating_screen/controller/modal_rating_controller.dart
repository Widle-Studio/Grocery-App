import '/core/app_export.dart';
import 'package:grocery_app/presentation/modal_rating_screen/models/modal_rating_model.dart';
import 'package:flutter/material.dart';

class ModalRatingController extends GetxController {
  TextEditingController buttonsmobileController = TextEditingController();

  Rx<ModalRatingModel> modalRatingModelObj = ModalRatingModel().obs;

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
