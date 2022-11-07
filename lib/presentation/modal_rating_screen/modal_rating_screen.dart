import 'controller/modal_rating_controller.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/core/app_export.dart';
import 'package:grocery_app/widgets/custom_text_form_field.dart';

class ModalRatingScreen extends GetWidget<ModalRatingController> {
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
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: getVerticalSize(
                    183.00,
                  ),
                  width: getHorizontalSize(
                    374.00,
                  ),
                  margin: getMargin(
                    left: 1,
                    top: 1,
                  ),
                  child: Stack(
                    alignment: Alignment.bottomLeft,
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Container(
                          height: getVerticalSize(
                            173.00,
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
                                child: Padding(
                                  padding: getPadding(
                                    bottom: 1,
                                  ),
                                  child: CommonImageView(
                                    imagePath: ImageConstant.imgMain1173X374,
                                    height: getVerticalSize(
                                      173.00,
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
                                  decoration:
                                      AppDecoration.gradientGray5099WhiteA70099,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: getHorizontalSize(
                                          226.00,
                                        ),
                                        margin: getMargin(
                                          left: 75,
                                          top: 52,
                                          right: 72,
                                          bottom: 57,
                                        ),
                                        child: Text(
                                          "msg_please_share_yo".tr,
                                          maxLines: null,
                                          textAlign: TextAlign.center,
                                          style: AppStyle.txtPoppinsMedium24,
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
                            left: 153,
                            top: 10,
                            right: 153,
                          ),
                          child: Text(
                            "lbl_3_02".tr,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.left,
                            style: AppStyle.txtPoppinsSemiBold35,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: getPadding(
                    left: 56,
                    top: 21,
                    right: 56,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        height: getSize(
                          36.00,
                        ),
                        width: getSize(
                          36.00,
                        ),
                        margin: getMargin(
                          top: 1,
                          bottom: 1,
                        ),
                        child: Stack(
                          alignment: Alignment.centerLeft,
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: CommonImageView(
                                svgPath: ImageConstant.imgStar,
                                height: getSize(
                                  36.00,
                                ),
                                width: getSize(
                                  36.00,
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: CommonImageView(
                                svgPath: ImageConstant.imgStar36X36,
                                height: getSize(
                                  36.00,
                                ),
                                width: getSize(
                                  36.00,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: getSize(
                          36.00,
                        ),
                        width: getSize(
                          36.00,
                        ),
                        margin: getMargin(
                          left: 19,
                          top: 1,
                          bottom: 1,
                        ),
                        child: Stack(
                          alignment: Alignment.centerLeft,
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: CommonImageView(
                                svgPath: ImageConstant.imgStar,
                                height: getSize(
                                  36.00,
                                ),
                                width: getSize(
                                  36.00,
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: CommonImageView(
                                svgPath: ImageConstant.imgStar36X36,
                                height: getSize(
                                  36.00,
                                ),
                                width: getSize(
                                  36.00,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: getSize(
                          36.00,
                        ),
                        width: getSize(
                          36.00,
                        ),
                        margin: getMargin(
                          left: 19,
                          top: 1,
                          bottom: 1,
                        ),
                        child: Stack(
                          alignment: Alignment.centerLeft,
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: CommonImageView(
                                svgPath: ImageConstant.imgStar,
                                height: getSize(
                                  36.00,
                                ),
                                width: getSize(
                                  36.00,
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: CommonImageView(
                                svgPath: ImageConstant.imgStar36X36,
                                height: getSize(
                                  36.00,
                                ),
                                width: getSize(
                                  36.00,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: getPadding(
                          left: 19,
                          top: 1,
                          bottom: 1,
                        ),
                        child: CommonImageView(
                          svgPath: ImageConstant.imgStar,
                          height: getSize(
                            36.00,
                          ),
                          width: getSize(
                            36.00,
                          ),
                        ),
                      ),
                      Padding(
                        padding: getPadding(
                          left: 19,
                        ),
                        child: CommonImageView(
                          svgPath: ImageConstant.imgStar,
                          height: getSize(
                            39.00,
                          ),
                          width: getSize(
                            39.00,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: getVerticalSize(
                    360.00,
                  ),
                  width: getHorizontalSize(
                    374.00,
                  ),
                  margin: getMargin(
                    left: 1,
                    top: 63,
                  ),
                  child: Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Container(
                          height: getVerticalSize(
                            225.00,
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
                                    imagePath: ImageConstant.imgMain1124X374,
                                    height: getVerticalSize(
                                      124.00,
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
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CustomTextFormField(
                                        width: 343,
                                        focusNode: FocusNode(),
                                        controller:
                                            controller.buttonsmobileController,
                                        hintText: "lbl_submit".tr,
                                        margin: getMargin(
                                          left: 16,
                                          top: 83,
                                          right: 15,
                                        ),
                                        textInputAction: TextInputAction.done,
                                        suffix: Container(
                                          margin: getMargin(
                                            left: 30,
                                            top: 12,
                                            right: 16,
                                            bottom: 12,
                                          ),
                                          child: CommonImageView(
                                            svgPath: ImageConstant.imgCheckmark,
                                          ),
                                        ),
                                        suffixConstraints: BoxConstraints(
                                          minWidth: getHorizontalSize(
                                            24.00,
                                          ),
                                          minHeight: getVerticalSize(
                                            24.00,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin: getMargin(
                                          left: 16,
                                          top: 13,
                                          right: 15,
                                          bottom: 33,
                                        ),
                                        decoration: AppDecoration.fillYellow900
                                            .copyWith(
                                          borderRadius:
                                              BorderRadiusStyle.roundedBorder9,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Padding(
                                              padding: getPadding(
                                                top: 17,
                                                bottom: 12,
                                              ),
                                              child: Text(
                                                "lbl_skip".tr,
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.left,
                                                style: AppStyle
                                                    .txtPoppinsMedium16WhiteA700,
                                              ),
                                            ),
                                            Padding(
                                              padding: getPadding(
                                                left: 122,
                                                top: 12,
                                                right: 16,
                                                bottom: 12,
                                              ),
                                              child: CommonImageView(
                                                svgPath: ImageConstant
                                                    .imgArrowrightWhiteA700,
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
                        child: Container(
                          height: getVerticalSize(
                            181.00,
                          ),
                          width: getHorizontalSize(
                            343.00,
                          ),
                          margin: getMargin(
                            left: 15,
                            right: 15,
                            bottom: 10,
                          ),
                          child: Stack(
                            alignment: Alignment.bottomLeft,
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: CommonImageView(
                                  svgPath: ImageConstant.imgGroup7copy,
                                  height: getVerticalSize(
                                    181.00,
                                  ),
                                  width: getHorizontalSize(
                                    343.00,
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.bottomLeft,
                                child: Padding(
                                  padding: getPadding(
                                    top: 10,
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Padding(
                                          padding: getPadding(
                                            left: 16,
                                            right: 16,
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Padding(
                                                padding: getPadding(
                                                  top: 6,
                                                  bottom: 6,
                                                ),
                                                child: CommonImageView(
                                                  svgPath:
                                                      ImageConstant.imgMenu4,
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
                                                  left: 12,
                                                ),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding: getPadding(
                                                        right: 10,
                                                      ),
                                                      child: Text(
                                                        "lbl_review".tr,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        textAlign:
                                                            TextAlign.left,
                                                        style: AppStyle
                                                            .txtPoppinsRegular12Blue700a9,
                                                      ),
                                                    ),
                                                    Container(
                                                      height: getVerticalSize(
                                                        18.00,
                                                      ),
                                                      width: getHorizontalSize(
                                                        76.00,
                                                      ),
                                                      margin: getMargin(
                                                        top: 6,
                                                      ),
                                                      child: Stack(
                                                        alignment:
                                                            Alignment.topRight,
                                                        children: [
                                                          Align(
                                                            alignment: Alignment
                                                                .centerLeft,
                                                            child: Padding(
                                                              padding:
                                                                  getPadding(
                                                                top: 1,
                                                              ),
                                                              child: Text(
                                                                "lbl_okay_i_am"
                                                                    .tr,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                textAlign:
                                                                    TextAlign
                                                                        .left,
                                                                style: AppStyle
                                                                    .txtPoppinsRegular16Bluegray800,
                                                              ),
                                                            ),
                                                          ),
                                                          Container(
                                                            height:
                                                                getVerticalSize(
                                                              17.00,
                                                            ),
                                                            width:
                                                                getHorizontalSize(
                                                              1.00,
                                                            ),
                                                            margin: getMargin(
                                                              left: 10,
                                                              right: 2,
                                                              bottom: 10,
                                                            ),
                                                            decoration:
                                                                BoxDecoration(
                                                              color:
                                                                  ColorConstant
                                                                      .gray801,
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
                                      ),
                                      Container(
                                        height: getVerticalSize(
                                          2.00,
                                        ),
                                        width: getHorizontalSize(
                                          343.00,
                                        ),
                                        margin: getMargin(
                                          top: 132,
                                        ),
                                        decoration: BoxDecoration(
                                          color: ColorConstant.blue700,
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
