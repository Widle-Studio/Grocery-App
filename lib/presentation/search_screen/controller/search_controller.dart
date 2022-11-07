import '/core/app_export.dart';import 'package:grocery_app/presentation/search_screen/models/search_model.dart';import 'package:flutter/material.dart';class SearchController extends GetxController {TextEditingController buttonswebsolController = TextEditingController();

TextEditingController buttonswebsolOneController = TextEditingController();

Rx<SearchModel> searchModelObj = SearchModel().obs;

@override void onReady() { super.onReady(); } 
@override void onClose() { super.onClose(); buttonswebsolController.dispose(); buttonswebsolOneController.dispose(); } 
 }
