import '/core/app_export.dart';import 'package:grocery_app/presentation/more_wishlist_details_screen/models/more_wishlist_details_model.dart';import 'package:flutter/material.dart';class MoreWishlistDetailsController extends GetxController {TextEditingController buttonsmobileController = TextEditingController();

TextEditingController buttonsmobileOneController = TextEditingController();

Rx<MoreWishlistDetailsModel> moreWishlistDetailsModelObj = MoreWishlistDetailsModel().obs;

@override void onReady() { super.onReady(); } 
@override void onClose() { super.onClose(); buttonsmobileController.dispose(); buttonsmobileOneController.dispose(); } 
 }
