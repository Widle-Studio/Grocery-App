import '../controller/wishlist_filled_controller.dart';
import '../models/listactionshopping_item_model.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/core/app_export.dart';

// ignore: must_be_immutable
class ListactionshoppingItemWidget extends StatelessWidget {
  ListactionshoppingItemWidget(this.listactionshoppingItemModelObj);

  ListactionshoppingItemModel listactionshoppingItemModelObj;

  var controller = Get.find<WishlistFilledController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: getMargin(
        top: 7.5,
        bottom: 7.5,
      ),
      decoration: AppDecoration.fillBluegray50.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder9,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: getPadding(
              left: 16,
              top: 16,
              bottom: 16,
            ),
            child: CommonImageView(
              svgPath: ImageConstant.imgActionShoppingbasket24px,
              height: getSize(
                24.00,
              ),
              width: getSize(
                24.00,
              ),
            ),
          ),
          Padding(
            padding: getPadding(
              left: 20,
              top: 9,
              right: 169,
              bottom: 11,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: getPadding(
                    right: 10,
                  ),
                  child: Text(
                    "lbl_product_name".tr,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                    style: AppStyle.txtPoppinsRegular12Bluegray800,
                  ),
                ),
                Padding(
                  padding: getPadding(
                    top: 7,
                  ),
                  child: Text(
                    "lbl_mountain_dew".tr,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                    style: AppStyle.txtPoppinsRegular16Bluegray800,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
