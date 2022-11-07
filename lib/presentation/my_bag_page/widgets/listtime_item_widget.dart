import '../controller/my_bag_controller.dart';
import '../models/listtime_item_model.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/core/app_export.dart';

// ignore: must_be_immutable
class ListtimeItemWidget extends StatelessWidget {
  ListtimeItemWidget(this.listtimeItemModelObj);

  ListtimeItemModel listtimeItemModelObj;

  var controller = Get.find<MyBagController>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: getPadding(
        top: 8.0,
        bottom: 8.0,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            padding: getPadding(
              left: 16,
              top: 19,
              right: 16,
              bottom: 19,
            ),
            decoration: AppDecoration.txtFillBluegray50.copyWith(
              borderRadius: BorderRadiusStyle.txtRoundedBorder9,
            ),
            child: Text(
              "lbl_8_am_11_am".tr,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.left,
              style: AppStyle.txtPoppinsRegular12Bluegray800b7,
            ),
          ),
          Container(
            margin: getMargin(
              left: 16,
            ),
            padding: getPadding(
              left: 16,
              top: 19,
              right: 16,
              bottom: 19,
            ),
            decoration: AppDecoration.txtOutlineLightgreenA700.copyWith(
              borderRadius: BorderRadiusStyle.txtRoundedBorder9,
            ),
            child: Text(
              "lbl_11_am_12_pm".tr,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.left,
              style: AppStyle.txtPoppinsRegular12,
            ),
          ),
          Container(
            margin: getMargin(
              left: 16,
            ),
            padding: getPadding(
              left: 16,
              top: 19,
              right: 16,
              bottom: 19,
            ),
            decoration: AppDecoration.txtFillBluegray50.copyWith(
              borderRadius: BorderRadiusStyle.txtRoundedBorder9,
            ),
            child: Text(
              "lbl_12_pm_2_pm".tr,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.left,
              style: AppStyle.txtPoppinsRegular12Bluegray800b7,
            ),
          ),
        ],
      ),
    );
  }
}
