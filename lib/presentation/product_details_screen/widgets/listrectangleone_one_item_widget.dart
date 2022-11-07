import '../controller/product_details_controller.dart';
import '../models/listrectangleone_one_item_model.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/core/app_export.dart';

// ignore: must_be_immutable
class ListrectangleoneOneItemWidget extends StatelessWidget {
  ListrectangleoneOneItemWidget(this.listrectangleoneOneItemModelObj);

  ListrectangleoneOneItemModel listrectangleoneOneItemModelObj;

  var controller = Get.find<ProductDetailsController>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: getPadding(
        top: 22.0,
        bottom: 22.0,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(
              getHorizontalSize(
                9.00,
              ),
            ),
            child: CommonImageView(
              imagePath: ImageConstant.imgRectangle1121X115,
              height: getVerticalSize(
                121.00,
              ),
              width: getHorizontalSize(
                115.00,
              ),
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: getPadding(
              left: 17,
              top: 11,
              bottom: 10,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: getHorizontalSize(
                    192.00,
                  ),
                  child: Text(
                    "msg_nestle_nido_ful".tr,
                    maxLines: null,
                    textAlign: TextAlign.left,
                    style: AppStyle.txtPoppinsMedium16.copyWith(
                      letterSpacing: 0.60,
                    ),
                  ),
                ),
                Padding(
                  padding: getPadding(
                    left: 1,
                    top: 17,
                    right: 10,
                  ),
                  child: Text(
                    "lbl_342".tr,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                    style: AppStyle.txtPoppinsSemiBold14.copyWith(
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                ),
                Padding(
                  padding: getPadding(
                    top: 10,
                    right: 10,
                  ),
                  child: Text(
                    "lbl_270".tr,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                    style: AppStyle.txtPoppinsSemiBold20Yellow900,
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
