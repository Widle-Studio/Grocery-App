import '../controller/search_search_result_controller.dart';
import '../models/listrectangleone1_item_model.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/core/app_export.dart';
import 'package:grocery_app/widgets/custom_button.dart';

// ignore: must_be_immutable
class Listrectangleone1ItemWidget extends StatelessWidget {
  Listrectangleone1ItemWidget(this.listrectangleone1ItemModelObj);

  Listrectangleone1ItemModel listrectangleone1ItemModelObj;

  var controller = Get.find<SearchSearchResultController>();

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Container(
        margin: getMargin(
          top: 2.5,
          bottom: 2.5,
        ),
        decoration: AppDecoration.fillWhiteA700,
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
              margin: getMargin(
                left: 15,
                top: 21,
                bottom: 20,
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
                top: 33,
                right: 16,
                bottom: 29,
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
                  Container(
                    width: getHorizontalSize(
                      210.00,
                    ),
                    margin: getMargin(
                      top: 17,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                        CustomButton(
                          width: 89,
                          text: "lbl_add".tr,
                          margin: getMargin(
                            top: 11,
                          ),
                          variant: ButtonVariant.FillLightgreenA700,
                          fontStyle: ButtonFontStyle.PoppinsMedium12,
                          prefixWidget: Container(
                            margin: getMargin(
                              right: 9,
                            ),
                            child: CommonImageView(
                              svgPath: ImageConstant.imgBag24X24,
                            ),
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
      ),
    );
  }
}
