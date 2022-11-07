import '/core/app_export.dart';import 'package:grocery_app/presentation/search_search_result_not_availabale_screen/models/search_search_result_not_availabale_model.dart';import 'package:flutter/material.dart';class SearchSearchResultNotAvailabaleController extends GetxController {TextEditingController buttonsmobileController = TextEditingController();

Rx<SearchSearchResultNotAvailabaleModel> searchSearchResultNotAvailabaleModelObj = SearchSearchResultNotAvailabaleModel().obs;

@override void onReady() { super.onReady(); } 
@override void onClose() { super.onClose(); buttonsmobileController.dispose(); } 
 }
