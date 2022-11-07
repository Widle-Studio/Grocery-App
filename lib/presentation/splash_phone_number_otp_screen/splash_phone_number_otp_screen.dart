import 'controller/splash_phone_number_otp_controller.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/core/app_export.dart';

class SplashPhoneNumberOtpScreen
    extends GetWidget<SplashPhoneNumberOtpController> {
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
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    height: getVerticalSize(
                      361.00,
                    ),
                    width: getHorizontalSize(
                      374.00,
                    ),
                    margin: getMargin(
                      left: 1,
                    ),
                    child: Stack(
                      alignment: Alignment.bottomCenter,
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
                                    imagePath: ImageConstant.imgMain125,
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
                                  child: CommonImageView(
                                    imagePath: ImageConstant.imgRectangle173,
                                    height: getVerticalSize(
                                      167.00,
                                    ),
                                    width: getHorizontalSize(
                                      374.00,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding: getPadding(
                              left: 10,
                              top: 10,
                              right: 10,
                            ),
                            child: CommonImageView(
                              svgPath: ImageConstant.imgUndrawpersonal293X353,
                              height: getVerticalSize(
                                293.00,
                              ),
                              width: getHorizontalSize(
                                353.00,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: getPadding(
                    left: 16,
                    top: 50,
                    right: 16,
                  ),
                  child: Text(
                    "msg_enter_verificat".tr,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                    style: AppStyle.txtPoppinsMedium20Bluegray800,
                  ),
                ),
                Container(
                  width: getHorizontalSize(
                    146.00,
                  ),
                  margin: getMargin(
                    left: 16,
                    top: 20,
                    right: 16,
                  ),
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "msg_we_have_sent_sm2".tr,
                          style: TextStyle(
                            color: ColorConstant.bluegray800B7,
                            fontSize: getFontSize(
                              14,
                            ),
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        TextSpan(
                          text: "lbl_01xxxxxxxxxx".tr,
                          style: TextStyle(
                            color: ColorConstant.bluegray800,
                            fontSize: getFontSize(
                              16,
                            ),
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    height: getVerticalSize(
                      274.00,
                    ),
                    width: getHorizontalSize(
                      374.00,
                    ),
                    margin: getMargin(
                      left: 1,
                      top: 6,
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
                              imagePath: ImageConstant.imgMain126,
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
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: getPadding(
                                    left: 15,
                                    top: 35,
                                    right: 15,
                                  ),
                                  child: CommonImageView(
                                    svgPath: ImageConstant.imgFormelementsm,
                                    height: getVerticalSize(
                                      56.00,
                                    ),
                                    width: getHorizontalSize(
                                      328.00,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: getPadding(
                                    left: 15,
                                    top: 33,
                                    right: 15,
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
                                          bottom: 4,
                                        ),
                                        child: Text(
                                          "lbl_resend_otp".tr,
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.left,
                                          style: AppStyle
                                              .txtPoppinsRegular14Yellow900,
                                        ),
                                      ),
                                      Padding(
                                        padding: getPadding(
                                          top: 1,
                                        ),
                                        child: Text(
                                          "msg_change_phone_nu".tr,
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.left,
                                          style: AppStyle
                                              .txtPoppinsRegular14Bluegray800b7,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: getMargin(
                                    left: 15,
                                    top: 49,
                                    right: 15,
                                    bottom: 34,
                                  ),
                                  decoration:
                                      AppDecoration.fillLightgreenA700.copyWith(
                                    borderRadius:
                                        BorderRadiusStyle.roundedBorder9,
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Padding(
                                        padding: getPadding(
                                          top: 16,
                                          bottom: 15,
                                        ),
                                        child: Text(
                                          "lbl_next".tr,
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.left,
                                          style: AppStyle
                                              .txtPoppinsMedium16WhiteA700,
                                        ),
                                      ),
                                      Padding(
                                        padding: getPadding(
                                          left: 121,
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
