import '../controller/modal_calendar_controller.dart';
import '../models/listlabel_eight_item_model.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/core/app_export.dart';

// ignore: must_be_immutable
class ListlabelEightItemWidget extends StatelessWidget {
  ListlabelEightItemWidget(this.listlabelEightItemModelObj);

  ListlabelEightItemModel listlabelEightItemModelObj;

  var controller = Get.find<ModalCalendarController>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: getPadding(
        left: 3,
        top: 8.1150055,
        right: 3,
        bottom: 8.1150055,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: getPadding(
              top: 11,
              bottom: 12,
            ),
            child: Text(
              "lbl_22".tr,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.left,
              style: AppStyle.txtPoppinsRegular12Bluegray800,
            ),
          ),
          Padding(
            padding: getPadding(
              left: 34,
              top: 11,
              bottom: 12,
            ),
            child: Text(
              "lbl_3".tr,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.left,
              style: AppStyle.txtPoppinsRegular12Bluegray800,
            ),
          ),
          Padding(
            padding: getPadding(
              left: 33,
              top: 11,
              bottom: 12,
            ),
            child: Text(
              "lbl_4".tr,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.left,
              style: AppStyle.txtPoppinsRegular12Bluegray800,
            ),
          ),
          Container(
            margin: getMargin(
              left: 19,
            ),
            padding: getPadding(
              left: 14,
              top: 11,
              right: 14,
              bottom: 11,
            ),
            decoration: AppDecoration.txtOutlineBluegray800.copyWith(
              borderRadius: BorderRadiusStyle.txtCircleBorder18,
            ),
            child: Text(
              "lbl_5".tr,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.left,
              style: AppStyle.txtPoppinsRegular12Bluegray800,
            ),
          ),
          Padding(
            padding: getPadding(
              left: 20,
              top: 11,
              bottom: 12,
            ),
            child: Text(
              "lbl_6".tr,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.left,
              style: AppStyle.txtPoppinsRegular12Bluegray800,
            ),
          ),
          Padding(
            padding: getPadding(
              left: 34,
              top: 11,
              bottom: 12,
            ),
            child: Text(
              "lbl_7".tr,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.left,
              style: AppStyle.txtPoppinsRegular12Bluegray800,
            ),
          ),
          Padding(
            padding: getPadding(
              left: 34,
              top: 11,
              bottom: 12,
            ),
            child: Text(
              "lbl_8".tr,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.left,
              style: AppStyle.txtPoppinsRegular12Bluegray800,
            ),
          ),
        ],
      ),
    );
  }
}
