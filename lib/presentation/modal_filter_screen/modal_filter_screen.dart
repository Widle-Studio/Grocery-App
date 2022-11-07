import 'controller/modal_filter_controller.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/core/app_export.dart';
import 'package:grocery_app/widgets/custom_button.dart';
import 'package:grocery_app/widgets/custom_text_form_field.dart';

class ModalFilterScreen extends GetWidget<ModalFilterController> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorConstant.whiteA700,
        body: Container(
          width: size.width,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: getVerticalSize(
                    215.00,
                  ),
                  width: getHorizontalSize(
                    323.00,
                  ),
                  child: Stack(
                    alignment: Alignment.bottomLeft,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          height: getVerticalSize(
                            211.00,
                          ),
                          width: getHorizontalSize(
                            323.00,
                          ),
                          margin: getMargin(
                            bottom: 3,
                          ),
                          child: Stack(
                            alignment: Alignment.centerLeft,
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: getPadding(
                                    bottom: 1,
                                  ),
                                  child: CommonImageView(
                                    imagePath: ImageConstant.imgMain1211X323,
                                    height: getVerticalSize(
                                      211.00,
                                    ),
                                    width: getHorizontalSize(
                                      323.00,
                                    ),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  decoration:
                                      AppDecoration.gradientGray5099WhiteA70099,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Container(
                                          width: size.width,
                                          margin: getMargin(
                                            top: 60,
                                          ),
                                          child: Padding(
                                            padding: getPadding(
                                              left: 16,
                                              right: 23,
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Padding(
                                                  padding: getPadding(
                                                    top: 3,
                                                  ),
                                                  child: Text(
                                                    "lbl_price_range".tr,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    textAlign: TextAlign.left,
                                                    style: AppStyle
                                                        .txtPoppinsMedium20Bluegray800,
                                                  ),
                                                ),
                                                Padding(
                                                  padding: getPadding(
                                                    bottom: 3,
                                                  ),
                                                  child: CommonImageView(
                                                    svgPath:
                                                        ImageConstant.imgClose1,
                                                    height: getSize(
                                                      24.00,
                                                    ),
                                                    width: getSize(
                                                      24.00,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: getPadding(
                                          left: 16,
                                          top: 23,
                                          right: 16,
                                          bottom: 59,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            CustomTextFormField(
                                              width: 130,
                                              focusNode: FocusNode(),
                                              controller: controller
                                                  .group7CopyController,
                                              hintText: "lbl_minimum".tr,
                                              variant: TextFormFieldVariant
                                                  .FillBluegray50,
                                              padding: TextFormFieldPadding
                                                  .PaddingAll12,
                                              fontStyle: TextFormFieldFontStyle
                                                  .PoppinsRegular16,
                                            ),
                                            Padding(
                                              padding: getPadding(
                                                left: 10,
                                                top: 10,
                                                bottom: 11,
                                              ),
                                              child: Text(
                                                "lbl3".tr,
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.left,
                                                style: AppStyle
                                                    .txtPoppinsMedium20Bluegray800,
                                              ),
                                            ),
                                            CustomTextFormField(
                                              width: 130,
                                              focusNode: FocusNode(),
                                              controller: controller
                                                  .group7CopyOneController,
                                              hintText: "lbl_maximum".tr,
                                              margin: getMargin(
                                                left: 8,
                                              ),
                                              variant: TextFormFieldVariant
                                                  .FillBluegray50,
                                              padding: TextFormFieldPadding
                                                  .PaddingAll12,
                                              fontStyle: TextFormFieldFontStyle
                                                  .PoppinsRegular16,
                                              textInputAction:
                                                  TextInputAction.done,
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
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Padding(
                          padding: getPadding(
                            left: 16,
                            top: 10,
                            right: 16,
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Padding(
                                padding: getPadding(
                                  top: 2,
                                ),
                                child: Text(
                                  "lbl_categories".tr,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.left,
                                  style: AppStyle.txtPoppinsMedium20Bluegray800,
                                ),
                              ),
                              CustomButton(
                                width: 79,
                                text: "lbl_check_all".tr,
                                margin: getMargin(
                                  left: 85,
                                  bottom: 2,
                                ),
                                shape: ButtonShape.CircleBorder12,
                                padding: ButtonPadding.PaddingAll5,
                                fontStyle: ButtonFontStyle.PoppinsRegular12,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    margin: getMargin(
                      top: 7,
                      right: 1,
                    ),
                    decoration: AppDecoration.fillWhiteA700.copyWith(
                      borderRadius: BorderRadiusStyle.roundedBorder9,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: getPadding(
                            left: 16,
                            top: 21,
                            bottom: 24,
                          ),
                          child: Text(
                            "lbl_dairy_products".tr,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.left,
                            style: AppStyle.txtPoppinsMedium14LightgreenA700,
                          ),
                        ),
                        Padding(
                          padding: getPadding(
                            top: 23,
                            right: 20,
                            bottom: 23,
                          ),
                          child: CommonImageView(
                            svgPath: ImageConstant.imgCheckmark20X20,
                            height: getSize(
                              20.00,
                            ),
                            width: getSize(
                              20.00,
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
                  width: getHorizontalSize(
                    322.00,
                  ),
                  margin: getMargin(
                    left: 1,
                    right: 1,
                  ),
                  decoration: BoxDecoration(
                    color: ColorConstant.gray200,
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    margin: getMargin(
                      right: 1,
                    ),
                    decoration: AppDecoration.fillWhiteA700.copyWith(
                      borderRadius: BorderRadiusStyle.roundedBorder9,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: getPadding(
                            left: 16,
                            top: 23,
                            bottom: 28,
                          ),
                          child: Text(
                            "lbl_foods".tr,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.left,
                            style: AppStyle.txtPoppinsMedium14,
                          ),
                        ),
                        Padding(
                          padding: getPadding(
                            top: 23,
                            right: 20,
                            bottom: 23,
                          ),
                          child: CommonImageView(
                            svgPath: ImageConstant.imgRefresh,
                            height: getSize(
                              20.00,
                            ),
                            width: getSize(
                              20.00,
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
                  width: getHorizontalSize(
                    322.00,
                  ),
                  margin: getMargin(
                    left: 1,
                    right: 1,
                  ),
                  decoration: BoxDecoration(
                    color: ColorConstant.gray200,
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    margin: getMargin(
                      right: 1,
                    ),
                    decoration: AppDecoration.fillWhiteA700.copyWith(
                      borderRadius: BorderRadiusStyle.roundedBorder9,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: getPadding(
                            left: 16,
                            top: 25,
                            bottom: 24,
                          ),
                          child: Text(
                            "lbl_vegetables".tr,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.left,
                            style: AppStyle.txtPoppinsMedium14,
                          ),
                        ),
                        Padding(
                          padding: getPadding(
                            top: 23,
                            right: 20,
                            bottom: 23,
                          ),
                          child: CommonImageView(
                            svgPath: ImageConstant.imgRefresh,
                            height: getSize(
                              20.00,
                            ),
                            width: getSize(
                              20.00,
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
                  width: getHorizontalSize(
                    322.00,
                  ),
                  margin: getMargin(
                    left: 1,
                    right: 1,
                  ),
                  decoration: BoxDecoration(
                    color: ColorConstant.gray200,
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    margin: getMargin(
                      right: 1,
                    ),
                    decoration: AppDecoration.fillWhiteA700.copyWith(
                      borderRadius: BorderRadiusStyle.roundedBorder9,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: getPadding(
                            left: 16,
                            top: 23,
                            bottom: 28,
                          ),
                          child: Text(
                            "lbl_snacks".tr,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.left,
                            style: AppStyle.txtPoppinsMedium14LightgreenA700,
                          ),
                        ),
                        Padding(
                          padding: getPadding(
                            top: 23,
                            right: 20,
                            bottom: 23,
                          ),
                          child: CommonImageView(
                            svgPath: ImageConstant.imgCheckmark20X20,
                            height: getSize(
                              20.00,
                            ),
                            width: getSize(
                              20.00,
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
                  width: getHorizontalSize(
                    322.00,
                  ),
                  margin: getMargin(
                    left: 1,
                    right: 1,
                  ),
                  decoration: BoxDecoration(
                    color: ColorConstant.gray200,
                  ),
                ),
                Container(
                  height: getVerticalSize(
                    322.00,
                  ),
                  width: getHorizontalSize(
                    323.00,
                  ),
                  child: Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Container(
                          height: getVerticalSize(
                            274.00,
                          ),
                          width: getHorizontalSize(
                            323.00,
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
                                    imagePath: ImageConstant.imgMain1151X323,
                                    height: getVerticalSize(
                                      151.00,
                                    ),
                                    width: getHorizontalSize(
                                      323.00,
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
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        margin: getMargin(
                                          top: 19,
                                          right: 1,
                                        ),
                                        decoration: AppDecoration.fillWhiteA700
                                            .copyWith(
                                          borderRadius:
                                              BorderRadiusStyle.roundedBorder9,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Padding(
                                              padding: getPadding(
                                                left: 16,
                                                top: 23,
                                                bottom: 28,
                                              ),
                                              child: Text(
                                                "lbl_others".tr,
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.left,
                                                style:
                                                    AppStyle.txtPoppinsMedium14,
                                              ),
                                            ),
                                            Padding(
                                              padding: getPadding(
                                                top: 23,
                                                right: 20,
                                                bottom: 23,
                                              ),
                                              child: CommonImageView(
                                                svgPath:
                                                    ImageConstant.imgRefresh,
                                                height: getSize(
                                                  20.00,
                                                ),
                                                width: getSize(
                                                  20.00,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        height: getVerticalSize(
                                          1.00,
                                        ),
                                        width: getHorizontalSize(
                                          322.00,
                                        ),
                                        margin: getMargin(
                                          left: 1,
                                          right: 1,
                                          bottom: 188,
                                        ),
                                        decoration: BoxDecoration(
                                          color: ColorConstant.gray200,
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
                        alignment: Alignment.topCenter,
                        child: Padding(
                          padding: getPadding(
                            right: 1,
                            bottom: 10,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                margin: getMargin(
                                  right: 1,
                                ),
                                decoration:
                                    AppDecoration.fillWhiteA700.copyWith(
                                  borderRadius:
                                      BorderRadiusStyle.roundedBorder9,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Padding(
                                      padding: getPadding(
                                        left: 16,
                                        top: 23,
                                        bottom: 28,
                                      ),
                                      child: Text(
                                        "lbl_healthcare".tr,
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.left,
                                        style: AppStyle.txtPoppinsMedium14,
                                      ),
                                    ),
                                    Padding(
                                      padding: getPadding(
                                        top: 23,
                                        right: 20,
                                        bottom: 23,
                                      ),
                                      child: CommonImageView(
                                        svgPath: ImageConstant.imgRefresh,
                                        height: getSize(
                                          20.00,
                                        ),
                                        width: getSize(
                                          20.00,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                height: getVerticalSize(
                                  1.00,
                                ),
                                width: getHorizontalSize(
                                  322.00,
                                ),
                                margin: getMargin(
                                  left: 1,
                                ),
                                decoration: BoxDecoration(
                                  color: ColorConstant.gray200,
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
      ),
    );
  }
}
