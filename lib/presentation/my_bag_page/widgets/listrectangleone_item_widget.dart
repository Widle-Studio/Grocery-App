import '../controller/my_bag_controller.dart';
import '../models/listrectangleone_item_model.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/core/app_export.dart';
import 'package:grocery_app/widgets/custom_icon_button.dart';

// ignore: must_be_immutable
class ListrectangleoneItemWidget extends StatelessWidget {
  ListrectangleoneItemWidget(this.listrectangleoneItemModelObj);

  ListrectangleoneItemModel listrectangleoneItemModelObj;

  var controller = Get.find<MyBagController>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: getPadding(
        top: 21.5,
        bottom: 21.5,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            height: getVerticalSize(
              121.00,
            ),
            width: getHorizontalSize(
              117.00,
            ),
            child: Stack(
              alignment: Alignment.topLeft,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: getPadding(
                      left: 2,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(
                        getHorizontalSize(
                          9.00,
                        ),
                      ),
                      child: CommonImageView(
                        imagePath: ImageConstant.imgRectangle18,
                        height: getVerticalSize(
                          121.00,
                        ),
                        width: getHorizontalSize(
                          115.00,
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    margin: getMargin(
                      right: 10,
                      bottom: 10,
                    ),
                    decoration: AppDecoration.fillYellow900.copyWith(
                      borderRadius: BorderRadiusStyle.circleBorder27,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: getPadding(
                              left: 13,
                              top: 12,
                              right: 13,
                            ),
                            child: Text(
                              "lbl_20".tr,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.left,
                              style: AppStyle.txtPoppinsRegular14WhiteA700,
                            ),
                          ),
                        ),
                        Padding(
                          padding: getPadding(
                            left: 15,
                            top: 4,
                            right: 14,
                            bottom: 10,
                          ),
                          child: Text(
                            "lbl_off".tr,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.left,
                            style: AppStyle.txtPoppinsRegular14WhiteA700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: getPadding(
              left: 17,
              top: 12,
              bottom: 9,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: getHorizontalSize(
                    183.00,
                  ),
                  margin: getMargin(
                    right: 10,
                  ),
                  child: Text(
                    "msg_arla_dano_full".tr,
                    maxLines: null,
                    textAlign: TextAlign.left,
                    style: AppStyle.txtPoppinsMedium16.copyWith(
                      letterSpacing: 0.60,
                    ),
                  ),
                ),
                Padding(
                  padding: getPadding(
                    top: 17,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: getPadding(
                          bottom: 1,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: getPadding(
                                left: 1,
                                right: 10,
                              ),
                              child: Text(
                                "lbl_200".tr,
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
                              ),
                              child: Text(
                                "lbl_182".tr,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.left,
                                style: AppStyle.txtPoppinsSemiBold20Yellow900,
                              ),
                            ),
                          ],
                        ),
                      ),
                      CustomIconButton(
                        height: 35,
                        width: 35,
                        margin: getMargin(
                          left: 46,
                          top: 11,
                        ),
                        variant: IconButtonVariant.FillRedA200,
                        shape: IconButtonShape.RoundedBorder8,
                        padding: IconButtonPadding.PaddingAll10,
                        child: CommonImageView(
                          svgPath: ImageConstant.imgActionminimize,
                        ),
                      ),
                      Padding(
                        padding: getPadding(
                          left: 23,
                          top: 21,
                          bottom: 10,
                        ),
                        child: Text(
                          "lbl_1".tr,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                          style: AppStyle.txtPoppinsMedium14,
                        ),
                      ),
                      CustomIconButton(
                        height: 35,
                        width: 35,
                        margin: getMargin(
                          left: 23,
                          top: 11,
                        ),
                        shape: IconButtonShape.RoundedBorder8,
                        padding: IconButtonPadding.PaddingAll10,
                        child: CommonImageView(
                          svgPath: ImageConstant.imgPlus,
                        ),
                      ),
                    ],
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
