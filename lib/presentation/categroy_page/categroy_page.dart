import 'controller/categroy_controller.dart';
import 'models/categroy_model.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/core/app_export.dart';

// ignore_for_file: must_be_immutable
class CategroyPage extends StatelessWidget {
  CategroyController controller =
      Get.put(CategroyController(CategroyModel().obs));

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorConstant.whiteA700,
        body: Container(
          decoration: AppDecoration.fillWhiteA700,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        height: getVerticalSize(
                          236.00,
                        ),
                        width: getHorizontalSize(
                          374.00,
                        ),
                        margin: getMargin(
                          left: 1,
                        ),
                        child: Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: Container(
                                height: getVerticalSize(
                                  167.00,
                                ),
                                width: getHorizontalSize(
                                  374.00,
                                ),
                                margin: getMargin(
                                  bottom: 10,
                                ),
                                child: Stack(
                                  alignment: Alignment.centerLeft,
                                  children: [
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: CommonImageView(
                                        imagePath: ImageConstant.imgMain11,
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
                                        decoration: AppDecoration.fillGray5099,
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
                                                  top: 15,
                                                  right: 16,
                                                  bottom: 129,
                                                ),
                                                child: Text(
                                                  "lbl_category".tr,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  textAlign: TextAlign.left,
                                                  style: AppStyle
                                                      .txtPoppinsSemiBold20,
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
                            ),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: Container(
                                width: getHorizontalSize(
                                  165.00,
                                ),
                                margin: getMargin(
                                  left: 15,
                                  top: 10,
                                  right: 15,
                                ),
                                decoration:
                                    AppDecoration.outlineBlack9000c.copyWith(
                                  borderRadius:
                                      BorderRadiusStyle.roundedBorder9,
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: getPadding(
                                        left: 11,
                                        top: 8,
                                        right: 11,
                                      ),
                                      child: CommonImageView(
                                        imagePath: ImageConstant.imgImage2,
                                        height: getVerticalSize(
                                          111.00,
                                        ),
                                        width: getHorizontalSize(
                                          143.00,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: getPadding(
                                        left: 11,
                                        top: 13,
                                        right: 11,
                                        bottom: 14,
                                      ),
                                      child: Text(
                                        "lbl_breakfast".tr,
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.left,
                                        style: AppStyle.txtPoppinsMedium13,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomLeft,
                              child: Container(
                                margin: getMargin(
                                  left: 15,
                                  top: 10,
                                  right: 15,
                                ),
                                decoration:
                                    AppDecoration.outlineBlack9000c.copyWith(
                                  borderRadius:
                                      BorderRadiusStyle.roundedBorder9,
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: getPadding(
                                        left: 11,
                                        top: 8,
                                        right: 11,
                                      ),
                                      child: CommonImageView(
                                        imagePath:
                                            ImageConstant.imgImage2111X143,
                                        height: getVerticalSize(
                                          111.00,
                                        ),
                                        width: getHorizontalSize(
                                          143.00,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: getPadding(
                                        left: 11,
                                        top: 14,
                                        right: 11,
                                        bottom: 11,
                                      ),
                                      child: Text(
                                        "msg_fruits_vegeta".tr,
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.left,
                                        style: AppStyle.txtPoppinsMedium13,
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
                          left: 16,
                          top: 38,
                          right: 15,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Container(
                              decoration:
                                  AppDecoration.outlineBlack9000c.copyWith(
                                borderRadius: BorderRadiusStyle.roundedBorder9,
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: getPadding(
                                      left: 11,
                                      top: 8,
                                      right: 11,
                                    ),
                                    child: CommonImageView(
                                      imagePath: ImageConstant.imgImage21,
                                      height: getVerticalSize(
                                        111.00,
                                      ),
                                      width: getHorizontalSize(
                                        143.00,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: getPadding(
                                      left: 11,
                                      top: 15,
                                      right: 11,
                                      bottom: 11,
                                    ),
                                    child: Text(
                                      "lbl_beverages".tr,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.left,
                                      style: AppStyle.txtPoppinsMedium13,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              decoration:
                                  AppDecoration.outlineBlack9000c.copyWith(
                                borderRadius: BorderRadiusStyle.roundedBorder9,
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: getPadding(
                                      left: 11,
                                      top: 8,
                                      right: 11,
                                    ),
                                    child: CommonImageView(
                                      imagePath: ImageConstant.imgImage22,
                                      height: getVerticalSize(
                                        111.00,
                                      ),
                                      width: getHorizontalSize(
                                        143.00,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: getPadding(
                                      left: 11,
                                      top: 13,
                                      right: 11,
                                      bottom: 14,
                                    ),
                                    child: Text(
                                      "lbl_meat_fish".tr,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.left,
                                      style: AppStyle.txtPoppinsMedium13,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: getVerticalSize(
                          296.00,
                        ),
                        width: getHorizontalSize(
                          374.00,
                        ),
                        margin: getMargin(
                          left: 1,
                          top: 38,
                        ),
                        child: Stack(
                          alignment: Alignment.topRight,
                          children: [
                            Align(
                              alignment: Alignment.bottomLeft,
                              child: Container(
                                height: getVerticalSize(
                                  274.00,
                                ),
                                width: getHorizontalSize(
                                  374.00,
                                ),
                                margin: getMargin(
                                  top: 10,
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
                                          imagePath: ImageConstant.imgMain12,
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
                                        height: getVerticalSize(
                                          274.00,
                                        ),
                                        width: getHorizontalSize(
                                          374.00,
                                        ),
                                        decoration: BoxDecoration(
                                          color: ColorConstant.whiteA7008c,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.topRight,
                              child: Container(
                                width: getHorizontalSize(
                                  165.00,
                                ),
                                margin: getMargin(
                                  left: 15,
                                  right: 15,
                                  bottom: 10,
                                ),
                                decoration:
                                    AppDecoration.outlineBlack9000c.copyWith(
                                  borderRadius:
                                      BorderRadiusStyle.roundedBorder9,
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: getPadding(
                                        left: 11,
                                        top: 8,
                                        right: 11,
                                      ),
                                      child: CommonImageView(
                                        imagePath: ImageConstant.imgImage23,
                                        height: getVerticalSize(
                                          111.00,
                                        ),
                                        width: getHorizontalSize(
                                          143.00,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: getPadding(
                                        left: 11,
                                        top: 14,
                                        right: 11,
                                        bottom: 11,
                                      ),
                                      child: Text(
                                        "lbl_dairy".tr,
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.left,
                                        style: AppStyle.txtPoppinsMedium13,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Container(
                                margin: getMargin(
                                  left: 15,
                                  right: 15,
                                  bottom: 10,
                                ),
                                decoration:
                                    AppDecoration.outlineBlack9000c.copyWith(
                                  borderRadius:
                                      BorderRadiusStyle.roundedBorder9,
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: getPadding(
                                        left: 11,
                                        top: 8,
                                        right: 11,
                                      ),
                                      child: CommonImageView(
                                        imagePath: ImageConstant.imgImage24,
                                        height: getVerticalSize(
                                          111.00,
                                        ),
                                        width: getHorizontalSize(
                                          143.00,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: getPadding(
                                        left: 11,
                                        top: 13,
                                        right: 11,
                                        bottom: 14,
                                      ),
                                      child: Text(
                                        "lbl_snacks".tr,
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.left,
                                        style: AppStyle.txtPoppinsMedium13,
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
            ],
          ),
        ),
      ),
    );
  }
}
