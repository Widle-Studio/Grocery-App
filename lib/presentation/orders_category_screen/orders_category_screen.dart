import 'controller/orders_category_controller.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/core/app_export.dart';

class OrdersCategoryScreen extends GetWidget<OrdersCategoryController> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorConstant.whiteA700,
        body: Container(
          width: size.width,
          child: SingleChildScrollView(
            child: Container(
              height: getVerticalSize(
                768.00,
              ),
              width: size.width,
              child: Stack(
                alignment: Alignment.topLeft,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: getPadding(
                        left: 1,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            height: getVerticalSize(
                              167.00,
                            ),
                            width: getHorizontalSize(
                              374.00,
                            ),
                            child: Stack(
                              alignment: Alignment.centerLeft,
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: CommonImageView(
                                    imagePath: ImageConstant.imgMain130,
                                    height: getVerticalSize(
                                      167.00,
                                    ),
                                    width: getHorizontalSize(
                                      374.00,
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Container(
                                    decoration: AppDecoration
                                        .gradientGray5099WhiteA70099,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Padding(
                                            padding: getPadding(
                                              left: 16,
                                              top: 12,
                                              right: 16,
                                              bottom: 135,
                                            ),
                                            child: Text(
                                              "lbl_orders".tr,
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.left,
                                              style:
                                                  AppStyle.txtPoppinsSemiBold20,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: getVerticalSize(
                              274.00,
                            ),
                            width: getHorizontalSize(
                              374.00,
                            ),
                            margin: getMargin(
                              top: 326,
                            ),
                            child: Stack(
                              alignment: Alignment.centerLeft,
                              children: [
                                Align(
                                  alignment: Alignment.bottomLeft,
                                  child: Padding(
                                    padding: getPadding(
                                      top: 10,
                                    ),
                                    child: CommonImageView(
                                      imagePath: ImageConstant.imgMain131,
                                      height: getVerticalSize(
                                        151.00,
                                      ),
                                      width: getHorizontalSize(
                                        374.00,
                                      ),
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Container(
                                    decoration: AppDecoration.fillWhiteA7008c,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: getHorizontalSize(
                                            298.00,
                                          ),
                                          margin: getMargin(
                                            left: 37,
                                            top: 48,
                                            right: 37,
                                            bottom: 188,
                                          ),
                                          child: Text(
                                            "msg_there_is_n_ongo".tr,
                                            maxLines: null,
                                            textAlign: TextAlign.center,
                                            style: AppStyle.txtPoppinsMedium16
                                                .copyWith(
                                              letterSpacing: 0.60,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      height: getVerticalSize(
                        37.00,
                      ),
                      width: size.width,
                      margin: getMargin(
                        top: 72,
                        bottom: 72,
                      ),
                      child: Stack(
                        alignment: Alignment.bottomLeft,
                        children: [
                          Align(
                            alignment: Alignment.topRight,
                            child: Padding(
                              padding: getPadding(
                                left: 86,
                                top: 6,
                                right: 86,
                                bottom: 10,
                              ),
                              child: Text(
                                "lbl_history".tr,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.left,
                                style: AppStyle.txtPoppinsMedium14Bluegray8008f
                                    .copyWith(
                                  letterSpacing: 0.10,
                                  height: 1.00,
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: Container(
                              height: getVerticalSize(
                                31.00,
                              ),
                              width: size.width,
                              margin: getMargin(
                                top: 10,
                              ),
                              child: Stack(
                                alignment: Alignment.bottomLeft,
                                children: [
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: getPadding(
                                        left: 55,
                                        right: 55,
                                        bottom: 1,
                                      ),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: getPadding(
                                              left: 25,
                                              right: 25,
                                            ),
                                            child: Text(
                                              "lbl_ongoing".tr,
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.left,
                                              style: AppStyle
                                                  .txtPoppinsMedium14LightgreenA700a9
                                                  .copyWith(
                                                letterSpacing: 0.10,
                                                height: 1.00,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            height: getVerticalSize(
                                              3.00,
                                            ),
                                            width: getHorizontalSize(
                                              114.00,
                                            ),
                                            margin: getMargin(
                                              top: 10,
                                            ),
                                            decoration: BoxDecoration(
                                              color:
                                                  ColorConstant.lightGreenA700,
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(
                                                  getHorizontalSize(
                                                    29.00,
                                                  ),
                                                ),
                                                topRight: Radius.circular(
                                                  getHorizontalSize(
                                                    29.00,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: getVerticalSize(
                                      1.00,
                                    ),
                                    width: size.width,
                                    margin: getMargin(
                                      top: 10,
                                    ),
                                    decoration: BoxDecoration(
                                      color: ColorConstant.bluegray8002b,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: getPadding(
                        top: 122,
                        bottom: 122,
                      ),
                      child: CommonImageView(
                        imagePath: ImageConstant.imgEmptyrafiki1,
                        height: getVerticalSize(
                          415.00,
                        ),
                        width: getHorizontalSize(
                          375.00,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
