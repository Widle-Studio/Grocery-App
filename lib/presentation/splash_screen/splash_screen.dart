import 'controller/splash_controller.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/core/app_export.dart';

class SplashScreen extends GetWidget<SplashController> {
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
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                      Container(
                          height: getVerticalSize(167.00),
                          width: getHorizontalSize(374.00),
                          margin: getMargin(left: 1),
                          child:
                              Stack(alignment: Alignment.centerLeft, children: [
                            Align(
                                alignment: Alignment.centerLeft,
                                child: CommonImageView(
                                    imagePath: ImageConstant.imgMain1167X374,
                                    height: getVerticalSize(167.00),
                                    width: getHorizontalSize(374.00))),
                            Align(
                                alignment: Alignment.centerLeft,
                                child: CommonImageView(
                                    imagePath: ImageConstant.imgRectangle17,
                                    height: getVerticalSize(167.00),
                                    width: getHorizontalSize(374.00)))
                          ])),
                      Padding(
                          padding: getPadding(left: 108, top: 42, right: 108),
                          child: CommonImageView(
                              svgPath: ImageConstant.imgFull1,
                              height: getSize(140.00),
                              width: getSize(140.00))),
                      Padding(
                          padding: getPadding(left: 108, top: 31, right: 108),
                          child: Text("lbl_grocery_plus".tr,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.left,
                              style: AppStyle.txtPoppinsMedium25)),
                      Container(
                          height: getVerticalSize(274.00),
                          width: getHorizontalSize(374.00),
                          margin: getMargin(left: 1, top: 83),
                          child:
                              Stack(alignment: Alignment.centerLeft, children: [
                            Align(
                                alignment: Alignment.bottomLeft,
                                child: Padding(
                                    padding: getPadding(top: 10),
                                    child: CommonImageView(
                                        imagePath:
                                            ImageConstant.imgMain1151X374,
                                        height: getVerticalSize(151.00),
                                        width: getHorizontalSize(374.00)))),
                            Align(
                                alignment: Alignment.centerLeft,
                                child: CommonImageView(
                                    imagePath: ImageConstant.imgRectangle16,
                                    height: getVerticalSize(274.00),
                                    width: getHorizontalSize(374.00)))
                          ]))
                    ])))));
  }
}
