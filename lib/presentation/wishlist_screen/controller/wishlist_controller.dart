import '/core/app_export.dart';import 'package:grocery_app/presentation/wishlist_screen/models/wishlist_model.dart';import 'package:flutter/material.dart';class WishlistController extends GetxController {TextEditingController group7CopyController = TextEditingController();

TextEditingController group7CopyOneController = TextEditingController();

TextEditingController group7CopyTwoController = TextEditingController();

TextEditingController buttonsmobileController = TextEditingController();

Rx<WishlistModel> wishlistModelObj = WishlistModel().obs;

@override void onReady() { super.onReady(); } 
@override void onClose() { super.onClose(); group7CopyController.dispose(); group7CopyOneController.dispose(); group7CopyTwoController.dispose(); buttonsmobileController.dispose(); } 
 }
