import 'controller/more_controller.dart';
import 'models/more_model.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/core/app_export.dart';

// ignore_for_file: must_be_immutable
class MorePage extends StatelessWidget {
  MoreController controller = Get.put(MoreController(MoreModel().obs));

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
                              child: Padding(
                                  padding: getPadding(left: 1),
                                  child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Container(
                                            height: getVerticalSize(235.00),
                                            width: getHorizontalSize(374.00),
                                            child: Stack(
                                                alignment:
                                                    Alignment.bottomCenter,
                                                children: [
                                                  Align(
                                                      alignment:
                                                          Alignment.topLeft,
                                                      child: Container(
                                                          height:
                                                              getVerticalSize(
                                                                  204.00),
                                                          width:
                                                              getHorizontalSize(
                                                                  374.00),
                                                          margin: getMargin(
                                                              bottom: 10),
                                                          child: Stack(
                                                              alignment: Alignment
                                                                  .centerLeft,
                                                              children: [
                                                                Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .centerLeft,
                                                                    child: Padding(
                                                                        padding: getPadding(
                                                                            bottom:
                                                                                1),
                                                                        child: CommonImageView(
                                                                            imagePath:
                                                                                ImageConstant.imgMain1204X374,
                                                                            height: getVerticalSize(204.00),
                                                                            width: getHorizontalSize(374.00)))),
                                                                Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .centerLeft,
                                                                    child: Container(
                                                                        decoration: AppDecoration.gradientGray5099WhiteA70099,
                                                                        child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.start, children: [
                                                                          Padding(
                                                                              padding: getPadding(left: 16, top: 12, right: 16),
                                                                              child: Text("lbl_more".tr, overflow: TextOverflow.ellipsis, textAlign: TextAlign.left, style: AppStyle.txtPoppinsSemiBold20)),
                                                                          Padding(
                                                                              padding: getPadding(left: 17, top: 46, right: 17, bottom: 75),
                                                                              child: Row(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.center, mainAxisSize: MainAxisSize.max, children: [
                                                                                ClipRRect(borderRadius: BorderRadius.circular(getHorizontalSize(25.00)), child: CommonImageView(imagePath: ImageConstant.imgOval, height: getSize(50.00), width: getSize(50.00), fit: BoxFit.cover)),
                                                                                Padding(
                                                                                    padding: getPadding(left: 16, top: 2, bottom: 4),
                                                                                    child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.start, children: [
                                                                                      Text("lbl_shafikul_islam".tr, overflow: TextOverflow.ellipsis, textAlign: TextAlign.left, style: AppStyle.txtPoppinsSemiBold18),
                                                                                      Align(alignment: Alignment.center, child: Padding(padding: getPadding(top: 9, right: 1), child: Text("lbl_01xxxxxxxxxxxx".tr, overflow: TextOverflow.ellipsis, textAlign: TextAlign.left, style: AppStyle.txtPoppinsMedium15Gray700.copyWith(height: 1.00))))
                                                                                    ]))
                                                                              ]))
                                                                        ])))
                                                              ]))),
                                                  Align(
                                                      alignment: Alignment
                                                          .bottomCenter,
                                                      child: Padding(
                                                          padding: getPadding(
                                                              left: 1, top: 10),
                                                          child: Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .end,
                                                              children: [
                                                                Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .centerLeft,
                                                                    child: Padding(
                                                                        padding: getPadding(left: 16, top: 10, right: 16),
                                                                        child: Row(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min, children: [
                                                                          CommonImageView(
                                                                              svgPath: ImageConstant.imgEdit24X24,
                                                                              height: getSize(24.00),
                                                                              width: getSize(24.00)),
                                                                          Padding(
                                                                              padding: getPadding(left: 20, top: 1, bottom: 5),
                                                                              child: Text("lbl_edit_profile".tr, overflow: TextOverflow.ellipsis, textAlign: TextAlign.left, style: AppStyle.txtPoppinsMedium14))
                                                                        ]))),
                                                                Container(
                                                                    height:
                                                                        getVerticalSize(
                                                                            2.00),
                                                                    width: getHorizontalSize(
                                                                        373.00),
                                                                    margin: getMargin(
                                                                        top:
                                                                            21),
                                                                    decoration:
                                                                        BoxDecoration(
                                                                            color:
                                                                                ColorConstant.gray200))
                                                              ])))
                                                ])),
                                        Align(
                                            alignment: Alignment.center,
                                            child: Container(
                                                margin: getMargin(left: 1),
                                                decoration: AppDecoration
                                                    .fillWhiteA700
                                                    .copyWith(
                                                        borderRadius:
                                                            BorderRadiusStyle
                                                                .roundedBorder9),
                                                child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      Padding(
                                                          padding: getPadding(
                                                              left: 17,
                                                              top: 21,
                                                              bottom: 21),
                                                          child: CommonImageView(
                                                              svgPath: ImageConstant
                                                                  .imgLocation24X24,
                                                              height: getSize(
                                                                  24.00),
                                                              width: getSize(
                                                                  24.00))),
                                                      Padding(
                                                          padding: getPadding(
                                                              left: 20,
                                                              top: 27,
                                                              bottom: 22),
                                                          child: Text(
                                                              "lbl_my_address"
                                                                  .tr,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                              style: AppStyle
                                                                  .txtPoppinsMedium14))
                                                    ]))),
                                        Container(
                                            height: getVerticalSize(2.00),
                                            width: getHorizontalSize(373.00),
                                            margin: getMargin(left: 1),
                                            decoration: BoxDecoration(
                                                color: ColorConstant.gray200)),
                                        Align(
                                            alignment: Alignment.center,
                                            child: Container(
                                                margin: getMargin(left: 1),
                                                decoration: AppDecoration
                                                    .fillWhiteA700
                                                    .copyWith(
                                                        borderRadius:
                                                            BorderRadiusStyle
                                                                .roundedBorder9),
                                                child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      Padding(
                                                          padding: getPadding(
                                                              left: 17,
                                                              top: 21,
                                                              bottom: 21),
                                                          child: CommonImageView(
                                                              svgPath: ImageConstant
                                                                  .imgActionShoppingbasket24px,
                                                              height: getSize(
                                                                  24.00),
                                                              width: getSize(
                                                                  24.00))),
                                                      Padding(
                                                          padding: getPadding(
                                                              left: 20,
                                                              top: 27,
                                                              bottom: 22),
                                                          child: Text(
                                                              "lbl_my_orders"
                                                                  .tr,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                              style: AppStyle
                                                                  .txtPoppinsMedium14))
                                                    ]))),
                                        Container(
                                            height: getVerticalSize(2.00),
                                            width: getHorizontalSize(373.00),
                                            margin: getMargin(left: 1),
                                            decoration: BoxDecoration(
                                                color: ColorConstant.gray200)),
                                        Align(
                                            alignment: Alignment.center,
                                            child: Container(
                                                margin: getMargin(left: 1),
                                                decoration: AppDecoration
                                                    .fillWhiteA700
                                                    .copyWith(
                                                        borderRadius:
                                                            BorderRadiusStyle
                                                                .roundedBorder9),
                                                child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      Padding(
                                                          padding: getPadding(
                                                              left: 17,
                                                              top: 21,
                                                              bottom: 21),
                                                          child: CommonImageView(
                                                              svgPath: ImageConstant
                                                                  .imgLocation1,
                                                              height: getSize(
                                                                  24.00),
                                                              width: getSize(
                                                                  24.00))),
                                                      Padding(
                                                          padding: getPadding(
                                                              left: 20,
                                                              top: 22,
                                                              bottom: 22),
                                                          child: Text(
                                                              "lbl_my_wishlist"
                                                                  .tr,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                              style: AppStyle
                                                                  .txtPoppinsMedium14))
                                                    ]))),
                                        Container(
                                            height: getVerticalSize(2.00),
                                            width: getHorizontalSize(373.00),
                                            margin: getMargin(left: 1),
                                            decoration: BoxDecoration(
                                                color: ColorConstant.gray200)),
                                        Align(
                                            alignment: Alignment.center,
                                            child: Container(
                                                margin: getMargin(left: 1),
                                                decoration: AppDecoration
                                                    .fillWhiteA700
                                                    .copyWith(
                                                        borderRadius:
                                                            BorderRadiusStyle
                                                                .roundedBorder9),
                                                child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      Padding(
                                                          padding: getPadding(
                                                              left: 17,
                                                              top: 21,
                                                              bottom: 21),
                                                          child: CommonImageView(
                                                              svgPath: ImageConstant
                                                                  .imgComputer1,
                                                              height: getSize(
                                                                  24.00),
                                                              width: getSize(
                                                                  24.00))),
                                                      Padding(
                                                          padding: getPadding(
                                                              left: 20,
                                                              top: 22,
                                                              bottom: 26),
                                                          child: Text(
                                                              "lbl_chat_with_us"
                                                                  .tr,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                              style: AppStyle
                                                                  .txtPoppinsMedium14))
                                                    ]))),
                                        Container(
                                            height: getVerticalSize(2.00),
                                            width: getHorizontalSize(373.00),
                                            margin: getMargin(left: 1),
                                            decoration: BoxDecoration(
                                                color: ColorConstant.gray200)),
                                        Align(
                                            alignment: Alignment.center,
                                            child: Container(
                                                margin: getMargin(left: 1),
                                                decoration: AppDecoration
                                                    .fillWhiteA700
                                                    .copyWith(
                                                        borderRadius:
                                                            BorderRadiusStyle
                                                                .roundedBorder9),
                                                child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      Padding(
                                                          padding: getPadding(
                                                              left: 17,
                                                              top: 21,
                                                              bottom: 21),
                                                          child: CommonImageView(
                                                              svgPath:
                                                                  ImageConstant
                                                                      .imgCall1,
                                                              height: getSize(
                                                                  24.00),
                                                              width: getSize(
                                                                  24.00))),
                                                      Padding(
                                                          padding: getPadding(
                                                              left: 20,
                                                              top: 27,
                                                              bottom: 22),
                                                          child: Text(
                                                              "msg_talk_to_our_sup"
                                                                  .tr,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                              style: AppStyle
                                                                  .txtPoppinsMedium14))
                                                    ]))),
                                        Container(
                                            height: getVerticalSize(2.00),
                                            width: getHorizontalSize(373.00),
                                            margin: getMargin(left: 1),
                                            decoration: BoxDecoration(
                                                color: ColorConstant.gray200)),
                                        Container(
                                            height: getVerticalSize(335.00),
                                            width: getHorizontalSize(374.00),
                                            child: Stack(
                                                alignment: Alignment.topCenter,
                                                children: [
                                                  Align(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Container(
                                                          height:
                                                              getVerticalSize(
                                                                  322.00),
                                                          width:
                                                              getHorizontalSize(
                                                                  374.00),
                                                          margin: getMargin(
                                                              top: 10),
                                                          child: Stack(
                                                              alignment: Alignment
                                                                  .centerLeft,
                                                              children: [
                                                                Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .bottomLeft,
                                                                    child: Padding(
                                                                        padding: getPadding(
                                                                            top:
                                                                                10),
                                                                        child: CommonImageView(
                                                                            imagePath:
                                                                                ImageConstant.imgMain1178X374,
                                                                            height: getVerticalSize(178.00),
                                                                            width: getHorizontalSize(374.00)))),
                                                                Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .centerLeft,
                                                                    child: Container(
                                                                        decoration: AppDecoration.fillWhiteA7008c,
                                                                        child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.start, children: [
                                                                          Align(
                                                                              alignment: Alignment.center,
                                                                              child: Container(
                                                                                  margin: getMargin(left: 1, top: 55),
                                                                                  decoration: AppDecoration.fillWhiteA700.copyWith(borderRadius: BorderRadiusStyle.roundedBorder9),
                                                                                  child: Row(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.center, mainAxisSize: MainAxisSize.max, children: [
                                                                                    Padding(
                                                                                        padding: getPadding(left: 17, top: 21, bottom: 21),
                                                                                        child: InkWell(
                                                                                            onTap: () {
                                                                                              onTapImgFacebook();
                                                                                            },
                                                                                            child: CommonImageView(svgPath: ImageConstant.imgFacebook24X24, height: getSize(24.00), width: getSize(24.00)))),
                                                                                    Padding(padding: getPadding(left: 20, top: 26, bottom: 22), child: Text("msg_message_to_face".tr, overflow: TextOverflow.ellipsis, textAlign: TextAlign.left, style: AppStyle.txtPoppinsMedium14))
                                                                                  ]))),
                                                                          Container(
                                                                              height: getVerticalSize(2.00),
                                                                              width: getHorizontalSize(373.00),
                                                                              margin: getMargin(left: 1),
                                                                              decoration: BoxDecoration(color: ColorConstant.gray200)),
                                                                          Padding(
                                                                              padding: getPadding(left: 17, top: 21, right: 17, bottom: 154),
                                                                              child: Row(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.end, mainAxisSize: MainAxisSize.min, children: [
                                                                                CommonImageView(svgPath: ImageConstant.imgVolume24X24, height: getSize(24.00), width: getSize(24.00)),
                                                                                Padding(padding: getPadding(left: 20, top: 6, bottom: 1), child: Text("lbl_log_out".tr, overflow: TextOverflow.ellipsis, textAlign: TextAlign.left, style: AppStyle.txtPoppinsMedium14))
                                                                              ]))
                                                                        ])))
                                                              ]))),
                                                  Align(
                                                      alignment:
                                                          Alignment.topCenter,
                                                      child: Padding(
                                                          padding: getPadding(
                                                              left: 1,
                                                              bottom: 10),
                                                          child: Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Container(
                                                                    decoration: AppDecoration
                                                                        .fillWhiteA700
                                                                        .copyWith(
                                                                            borderRadius: BorderRadiusStyle
                                                                                .roundedBorder9),
                                                                    child: Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment
                                                                                .start,
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment
                                                                                .center,
                                                                        mainAxisSize:
                                                                            MainAxisSize.max,
                                                                        children: [
                                                                          Padding(
                                                                              padding: getPadding(left: 17, top: 21, bottom: 21),
                                                                              child: CommonImageView(svgPath: ImageConstant.imgMail, height: getSize(24.00), width: getSize(24.00))),
                                                                          Padding(
                                                                              padding: getPadding(left: 20, top: 22, bottom: 26),
                                                                              child: Text("lbl_mail_to_us".tr, overflow: TextOverflow.ellipsis, textAlign: TextAlign.left, style: AppStyle.txtPoppinsMedium14))
                                                                        ])),
                                                                Container(
                                                                    height:
                                                                        getVerticalSize(
                                                                            2.00),
                                                                    width: getHorizontalSize(
                                                                        373.00),
                                                                    margin: getMargin(
                                                                        left:
                                                                            1),
                                                                    decoration:
                                                                        BoxDecoration(
                                                                            color:
                                                                                ColorConstant.gray200))
                                                              ])))
                                                ]))
                                      ]))))
                    ]))));
  }

  onTapImgFacebook() async {
    var url = 'https://www.facebook.com/login/';
    if (!await launch(url)) {
      throw 'Could not launch https://www.facebook.com/login/';
    }
  }
}
