import 'controller/home_controller.dart';
import 'models/home_model.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/core/app_export.dart';
import 'package:grocery_app/widgets/custom_search_view.dart';

// ignore_for_file: must_be_immutable
class HomePage extends StatelessWidget {
  HomeController controller = Get.put(HomeController(HomeModel().obs));

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorConstant.gray50,
        body: Container(
          decoration: AppDecoration.fillGray50,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Align(
                alignment: Alignment.center,
                child: Container(
                  height: getVerticalSize(
                    187.00,
                  ),
                  width: getHorizontalSize(
                    374.00,
                  ),
                  margin: getMargin(
                    left: 1,
                  ),
                  child: Stack(
                    alignment: Alignment.centerLeft,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: CommonImageView(
                          imagePath: ImageConstant.imgMain1187X374,
                          height: getVerticalSize(
                            187.00,
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
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                width: size.width,
                                margin: getMargin(
                                  top: 4,
                                ),
                                child: Padding(
                                  padding: getPadding(
                                    left: 17,
                                    right: 15,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Padding(
                                        padding: getPadding(
                                          top: 10,
                                        ),
                                        child: Text(
                                          "lbl_grocery_plus".tr,
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.left,
                                          style: AppStyle.txtPoppinsSemiBold20,
                                        ),
                                      ),
                                      Padding(
                                        padding: getPadding(
                                          bottom: 9,
                                        ),
                                        child: CommonImageView(
                                          svgPath:
                                              ImageConstant.imgNotification,
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
                              Padding(
                                padding: getPadding(
                                  left: 13,
                                  top: 15,
                                  right: 13,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Container(
                                      height: getSize(
                                        45.00,
                                      ),
                                      width: getSize(
                                        45.00,
                                      ),
                                      child: Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: CommonImageView(
                                              svgPath: ImageConstant.imgClose,
                                              height: getSize(
                                                45.00,
                                              ),
                                              width: getSize(
                                                45.00,
                                              ),
                                            ),
                                          ),
                                          Align(
                                            alignment: Alignment.center,
                                            child: Padding(
                                              padding: getPadding(
                                                left: 10,
                                                top: 11,
                                                right: 11,
                                                bottom: 10,
                                              ),
                                              child: CommonImageView(
                                                svgPath:
                                                    ImageConstant.imgLocation,
                                                height: getSize(
                                                  24.00,
                                                ),
                                                width: getSize(
                                                  24.00,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: getPadding(
                                        left: 11,
                                        top: 5,
                                        bottom: 3,
                                      ),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
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
                                              "lbl_your_location".tr,
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.left,
                                              style:
                                                  AppStyle.txtPoppinsRegular11,
                                            ),
                                          ),
                                          Padding(
                                            padding: getPadding(
                                              top: 4,
                                            ),
                                            child: Text(
                                              "msg_32_llanberis_cl".tr,
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.left,
                                              style:
                                                  AppStyle.txtPoppinsMedium14,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: getPadding(
                                        left: 18,
                                        top: 13,
                                        bottom: 12,
                                      ),
                                      child: CommonImageView(
                                        svgPath: ImageConstant.imgArrowright,
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
                              CustomSearchView(
                                width: 343,
                                focusNode: FocusNode(),
                                controller: controller.group7CopyController,
                                hintText: "lbl_search_anything".tr,
                                margin: getMargin(
                                  left: 13,
                                  top: 24,
                                  right: 13,
                                  bottom: 13,
                                ),
                                prefix: Container(
                                  margin: getMargin(
                                    left: 16,
                                    top: 14,
                                    right: 20,
                                    bottom: 14,
                                  ),
                                  child: CommonImageView(
                                    svgPath: ImageConstant.imgSearch,
                                  ),
                                ),
                                prefixConstraints: BoxConstraints(
                                  minWidth: getSize(
                                    24.00,
                                  ),
                                  minHeight: getSize(
                                    24.00,
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
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: getPadding(
                      left: 1,
                      top: 20,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: getPadding(
                            left: 15,
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
                                        left: 19,
                                        top: 14,
                                        right: 19,
                                      ),
                                      child: CommonImageView(
                                        imagePath:
                                            ImageConstant.imgYqtmbqbktaremo,
                                        height: getVerticalSize(
                                          110.00,
                                        ),
                                        width: getHorizontalSize(
                                          66.00,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: getPadding(
                                        left: 19,
                                        top: 9,
                                        right: 19,
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
                              Container(
                                decoration:
                                    AppDecoration.outlineBlack9000c.copyWith(
                                  borderRadius:
                                      BorderRadiusStyle.roundedBorder9,
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: getPadding(
                                        left: 25,
                                        top: 11,
                                        right: 25,
                                      ),
                                      child: CommonImageView(
                                        imagePath:
                                            ImageConstant.imgKfmobju1rgr39ia,
                                        height: getVerticalSize(
                                          117.00,
                                        ),
                                        width: getHorizontalSize(
                                          113.00,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: getPadding(
                                        left: 25,
                                        top: 4,
                                        right: 25,
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
                            ],
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            height: getVerticalSize(
                              459.00,
                            ),
                            width: getHorizontalSize(
                              374.00,
                            ),
                            margin: getMargin(
                              top: 18,
                            ),
                            child: Stack(
                              alignment: Alignment.topRight,
                              children: [
                                Align(
                                  alignment: Alignment.bottomLeft,
                                  child: Container(
                                    height: getVerticalSize(
                                      300.00,
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
                                              imagePath:
                                                  ImageConstant.imgMain1166X374,
                                              height: getVerticalSize(
                                                166.00,
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
                                                AppDecoration.fillWhiteA7008c,
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Container(
                                                  margin: getMargin(
                                                    left: 15,
                                                    top: 19,
                                                    bottom: 121,
                                                  ),
                                                  decoration: AppDecoration
                                                      .outlineBlack9000c
                                                      .copyWith(
                                                    borderRadius:
                                                        BorderRadiusStyle
                                                            .roundedBorder9,
                                                  ),
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      Padding(
                                                        padding: getPadding(
                                                          left: 37,
                                                          top: 22,
                                                          right: 37,
                                                        ),
                                                        child: CommonImageView(
                                                          imagePath: ImageConstant
                                                              .imgAt2xy9onj6remo,
                                                          height:
                                                              getVerticalSize(
                                                            94.00,
                                                          ),
                                                          width:
                                                              getHorizontalSize(
                                                            90.00,
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding: getPadding(
                                                          left: 37,
                                                          top: 16,
                                                          right: 37,
                                                          bottom: 14,
                                                        ),
                                                        child: Text(
                                                          "lbl_snacks".tr,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          textAlign:
                                                              TextAlign.left,
                                                          style: AppStyle
                                                              .txtPoppinsMedium13,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  height: getVerticalSize(
                                                    166.00,
                                                  ),
                                                  width: getHorizontalSize(
                                                    165.00,
                                                  ),
                                                  margin: getMargin(
                                                    left: 14,
                                                    top: 13,
                                                    right: 15,
                                                    bottom: 121,
                                                  ),
                                                  child: Stack(
                                                    alignment:
                                                        Alignment.topCenter,
                                                    children: [
                                                      Align(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Container(
                                                          margin: getMargin(
                                                            top: 6,
                                                          ),
                                                          decoration: AppDecoration
                                                              .outlineBlack9000c
                                                              .copyWith(
                                                            borderRadius:
                                                                BorderRadiusStyle
                                                                    .roundedBorder9,
                                                          ),
                                                          child: Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .end,
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    getPadding(
                                                                  left: 64,
                                                                  top: 133,
                                                                  right: 64,
                                                                  bottom: 11,
                                                                ),
                                                                child: Text(
                                                                  "lbl_dairy"
                                                                      .tr,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  textAlign:
                                                                      TextAlign
                                                                          .left,
                                                                  style: AppStyle
                                                                      .txtPoppinsMedium13,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      Align(
                                                        alignment:
                                                            Alignment.topCenter,
                                                        child: Padding(
                                                          padding: getPadding(
                                                            left: 8,
                                                            right: 8,
                                                            bottom: 10,
                                                          ),
                                                          child:
                                                              CommonImageView(
                                                            imagePath: ImageConstant
                                                                .imgUmrmremovebg,
                                                            height:
                                                                getVerticalSize(
                                                              137.00,
                                                            ),
                                                            width:
                                                                getHorizontalSize(
                                                              149.00,
                                                            ),
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
                                    decoration: AppDecoration.outlineBlack9000c
                                        .copyWith(
                                      borderRadius:
                                          BorderRadiusStyle.roundedBorder9,
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: Padding(
                                            padding: getPadding(
                                              left: 18,
                                              top: 18,
                                              right: 10,
                                            ),
                                            child: CommonImageView(
                                              imagePath: ImageConstant
                                                  .imgYdxycnvw3gyrwlm,
                                              height: getVerticalSize(
                                                101.00,
                                              ),
                                              width: getHorizontalSize(
                                                137.00,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: getPadding(
                                            left: 18,
                                            top: 13,
                                            right: 18,
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
                                ),
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Container(
                                    margin: getMargin(
                                      left: 15,
                                      right: 15,
                                      bottom: 10,
                                    ),
                                    decoration: AppDecoration.outlineBlack9000c
                                        .copyWith(
                                      borderRadius:
                                          BorderRadiusStyle.roundedBorder9,
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: getPadding(
                                            left: 42,
                                            top: 16,
                                            right: 42,
                                          ),
                                          child: CommonImageView(
                                            imagePath:
                                                ImageConstant.imgM31sgmeremove,
                                            height: getVerticalSize(
                                              114.00,
                                            ),
                                            width: getHorizontalSize(
                                              80.00,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: getPadding(
                                            left: 42,
                                            top: 4,
                                            right: 42,
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
            ],
          ),
        ),
      ),
    );
  }
}
