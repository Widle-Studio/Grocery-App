import '../controller/search_search_result_controller.dart';
import '../models/listframe_item_model.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/core/app_export.dart';

// ignore: must_be_immutable
class ListframeItemWidget extends StatelessWidget {
  ListframeItemWidget(this.listframeItemModelObj);

  ListframeItemModel listframeItemModelObj;

  var controller = Get.find<SearchSearchResultController>();

  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      child: Container(
        margin: getMargin(
          right: 24,
        ),
        padding: getPadding(
          left: 20,
          top: 12,
          right: 20,
          bottom: 12,
        ),
        decoration: AppDecoration.txtFillBluegray50.copyWith(
          borderRadius: BorderRadiusStyle.txtRoundedBorder9,
        ),
        child: Text(
          "lbl_dano2".tr,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.left,
          style: AppStyle.txtPoppinsRegular12Bluegray800,
        ),
      ),
    );
  }
}
