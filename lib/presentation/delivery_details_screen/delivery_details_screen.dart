import '../delivery_details_screen/widgets/listcheckmark_item_widget.dart';
import 'controller/delivery_details_controller.dart';
import 'models/listcheckmark_item_model.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/core/app_export.dart';
import 'package:grocery_app/widgets/custom_icon_button.dart';
import 'package:grocery_app/widgets/custom_text_form_field.dart';

class DeliveryDetailsScreen extends GetWidget<DeliveryDetailsController> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: ColorConstant.whiteA700,
            body: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Align(
                      alignment: Alignment.center,
                      child: Container(
                          height: getVerticalSize(175.00),
                          width: getHorizontalSize(374.00),
                          margin: getMargin(left: 1),
                          child:
                              Stack(alignment: Alignment.centerLeft, children: [
                            Align(
                                alignment: Alignment.centerLeft,
                                child: CommonImageView(
                                    imagePath: ImageConstant.imgMain1,
                                    height: getVerticalSize(175.00),
                                    width: getHorizontalSize(374.00))),
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
                                          Container(
                                              width: size.width,
                                              margin: getMargin(top: 9),
                                              child: Padding(
                                                  padding: getPadding(
                                                      left: 17, right: 158),
                                                  child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      children: [
                                                        Padding(
                                                            padding: getPadding(
                                                                bottom: 6),
                                                            child: InkWell(
                                                                onTap: () {
                                                                  onTapImgArrowleft();
                                                                },
                                                                child: CommonImageView(
                                                                    svgPath:
                                                                        ImageConstant
                                                                            .imgArrowleft,
                                                                    height:
                                                                        getSize(
                                                                            24.00),
                                                                    width: getSize(
                                                                        24.00)))),
                                                        Padding(
                                                            padding: getPadding(
                                                                left: 18,
                                                                top: 6),
                                                            child: Text(
                                                                "msg_delivery_detail"
                                                                    .tr,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                textAlign:
                                                                    TextAlign
                                                                        .left,
                                                                style: AppStyle
                                                                    .txtPoppinsSemiBold20))
                                                      ]))),
                                          Padding(
                                              padding: getPadding(
                                                  left: 15, top: 47, right: 15),
                                              child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    Padding(
                                                        padding: getPadding(
                                                            bottom: 6),
                                                        child: Text(
                                                            "lbl_delivered_on"
                                                                .tr,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            textAlign:
                                                                TextAlign.left,
                                                            style: AppStyle
                                                                .txtPoppinsMedium16
                                                                .copyWith(
                                                                    letterSpacing:
                                                                        0.60))),
                                                    Padding(
                                                        padding:
                                                            getPadding(top: 5),
                                                        child: Text(
                                                            "lbl_6_30_pm".tr,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            textAlign:
                                                                TextAlign.left,
                                                            style: AppStyle
                                                                .txtPoppinsMedium17
                                                                .copyWith(
                                                                    letterSpacing:
                                                                        0.98,
                                                                    height:
                                                                        1.00)))
                                                  ])),
                                          Align(
                                              alignment: Alignment.centerLeft,
                                              child: Padding(
                                                  padding: getPadding(
                                                      left: 15,
                                                      top: 21,
                                                      right: 15,
                                                      bottom: 5),
                                                  child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      children: [
                                                        Padding(
                                                            padding: getPadding(
                                                                bottom: 11),
                                                            child: CommonImageView(
                                                                svgPath:
                                                                    ImageConstant
                                                                        .imgCalendar,
                                                                height: getSize(
                                                                    28.00),
                                                                width: getSize(
                                                                    28.00))),
                                                        Padding(
                                                            padding: getPadding(
                                                                left: 14,
                                                                top: 1),
                                                            child: Text(
                                                                "lbl_march_5_2019"
                                                                    .tr,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                textAlign:
                                                                    TextAlign
                                                                        .left,
                                                                style: AppStyle
                                                                    .txtPoppinsRegular32
                                                                    .copyWith(
                                                                        letterSpacing:
                                                                            1.28)))
                                                      ])))
                                        ])))
                          ]))),
                  Expanded(
                      child: SingleChildScrollView(
                          child: Container(
                              height: getVerticalSize(582.00),
                              width: getHorizontalSize(374.00),
                              margin: getMargin(left: 1, top: 24),
                              child: Stack(
                                  alignment: Alignment.bottomRight,
                                  children: [
                                    Align(
                                        alignment: Alignment.bottomLeft,
                                        child: Container(
                                            height: getVerticalSize(277.00),
                                            width: getHorizontalSize(374.00),
                                            margin: getMargin(top: 10),
                                            child: Stack(
                                                alignment: Alignment.centerLeft,
                                                children: [
                                                  Align(
                                                      alignment:
                                                          Alignment.bottomLeft,
                                                      child: Padding(
                                                          padding: getPadding(
                                                              top: 10),
                                                          child: CommonImageView(
                                                              imagePath:
                                                                  ImageConstant
                                                                      .imgMain1153X374,
                                                              height:
                                                                  getVerticalSize(
                                                                      153.00),
                                                              width:
                                                                  getHorizontalSize(
                                                                      374.00)))),
                                                  Align(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Container(
                                                          decoration: AppDecoration
                                                              .fillWhiteA7008c,
                                                          child: Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .end,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Container(
                                                                    width: double
                                                                        .infinity,
                                                                    margin: getMargin(
                                                                        left:
                                                                            16,
                                                                        top: 79,
                                                                        right:
                                                                            16),
                                                                    decoration: AppDecoration
                                                                        .fillRedA20023
                                                                        .copyWith(
                                                                            borderRadius: BorderRadiusStyle
                                                                                .roundedBorder12),
                                                                    child: Column(
                                                                        mainAxisSize:
                                                                            MainAxisSize
                                                                                .min,
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment
                                                                                .start,
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.center,
                                                                        children: [
                                                                          Padding(
                                                                              padding: getPadding(left: 24, top: 18, right: 24),
                                                                              child: Text("msg_your_order_is_r".tr, overflow: TextOverflow.ellipsis, textAlign: TextAlign.left, style: AppStyle.txtPoppinsMedium16.copyWith(letterSpacing: 0.60))),
                                                                          Padding(
                                                                              padding: getPadding(left: 24, top: 12, right: 24, bottom: 20),
                                                                              child: Text("msg_november_19_20".tr, overflow: TextOverflow.ellipsis, textAlign: TextAlign.left, style: AppStyle.txtPoppinsRegular14))
                                                                        ])),
                                                                CustomTextFormField(
                                                                    width: 343,
                                                                    focusNode:
                                                                        FocusNode(),
                                                                    controller:
                                                                        controller
                                                                            .buttonsmobileController,
                                                                    hintText:
                                                                        "msg_contact_with_su"
                                                                            .tr,
                                                                    margin: getMargin(
                                                                        left:
                                                                            16,
                                                                        top: 24,
                                                                        right:
                                                                            15,
                                                                        bottom:
                                                                            41),
                                                                    variant: TextFormFieldVariant
                                                                        .FillYellow900,
                                                                    padding: TextFormFieldPadding
                                                                        .PaddingAll12,
                                                                    textInputAction:
                                                                        TextInputAction
                                                                            .done,
                                                                    alignment:
                                                                        Alignment
                                                                            .center,
                                                                    suffix: Container(
                                                                        margin: getMargin(
                                                                            left:
                                                                                30,
                                                                            top:
                                                                                12,
                                                                            right:
                                                                                16,
                                                                            bottom:
                                                                                12),
                                                                        child: CommonImageView(
                                                                            svgPath: ImageConstant
                                                                                .imgComputer)),
                                                                    suffixConstraints: BoxConstraints(
                                                                        minWidth:
                                                                            getHorizontalSize(
                                                                                24.00),
                                                                        minHeight:
                                                                            getVerticalSize(24.00)))
                                                              ])))
                                                ]))),
                                    Align(
                                        alignment: Alignment.bottomRight,
                                        child: Container(
                                            width: getHorizontalSize(302.00),
                                            margin: getMargin(
                                                left: 16,
                                                top: 209,
                                                right: 16,
                                                bottom: 209),
                                            decoration: AppDecoration
                                                .fillYellow90023
                                                .copyWith(
                                                    borderRadius:
                                                        BorderRadiusStyle
                                                            .roundedBorder12),
                                            child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Padding(
                                                      padding: getPadding(
                                                          left: 24,
                                                          top: 18,
                                                          right: 24),
                                                      child: Text(
                                                          "msg_your_order_is_c"
                                                              .tr,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          textAlign:
                                                              TextAlign.left,
                                                          style: AppStyle
                                                              .txtPoppinsMedium16
                                                              .copyWith(
                                                                  letterSpacing:
                                                                      0.60))),
                                                  Padding(
                                                      padding: getPadding(
                                                          left: 24,
                                                          top: 12,
                                                          right: 24,
                                                          bottom: 20),
                                                      child: Text(
                                                          "msg_november_19_20"
                                                              .tr,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          textAlign:
                                                              TextAlign.left,
                                                          style: AppStyle
                                                              .txtPoppinsRegular14))
                                                ]))),
                                    Align(
                                        alignment: Alignment.topRight,
                                        child: Container(
                                            width: getHorizontalSize(302.00),
                                            margin: getMargin(
                                                left: 16,
                                                right: 16,
                                                bottom: 10),
                                            decoration: AppDecoration
                                                .fillBluegray80023
                                                .copyWith(
                                                    borderRadius:
                                                        BorderRadiusStyle
                                                            .roundedBorder12),
                                            child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Padding(
                                                      padding: getPadding(
                                                          left: 24,
                                                          top: 20,
                                                          right: 24),
                                                      child: Text(
                                                          "msg_waiting_of_conf"
                                                              .tr,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          textAlign:
                                                              TextAlign.left,
                                                          style: AppStyle
                                                              .txtPoppinsMedium16
                                                              .copyWith(
                                                                  letterSpacing:
                                                                      0.60))),
                                                  Padding(
                                                      padding: getPadding(
                                                          left: 24,
                                                          top: 8,
                                                          right: 24,
                                                          bottom: 20),
                                                      child: Text(
                                                          "msg_november_19_20"
                                                              .tr,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          textAlign:
                                                              TextAlign.left,
                                                          style: AppStyle
                                                              .txtPoppinsRegular14))
                                                ]))),
                                    Align(
                                        alignment: Alignment.topCenter,
                                        child: Padding(
                                            padding: getPadding(
                                                left: 16,
                                                top: 96,
                                                right: 16,
                                                bottom: 96),
                                            child: Obx(() => ListView.builder(
                                                physics:
                                                    NeverScrollableScrollPhysics(),
                                                shrinkWrap: true,
                                                itemCount: controller
                                                    .deliveryDetailsModelObj
                                                    .value
                                                    .listcheckmarkItemList
                                                    .length,
                                                itemBuilder: (context, index) {
                                                  ListcheckmarkItemModel model =
                                                      controller
                                                          .deliveryDetailsModelObj
                                                          .value
                                                          .listcheckmarkItemList[index];
                                                  return ListcheckmarkItemWidget(
                                                      model);
                                                })))),
                                    Container(
                                        height: getVerticalSize(384.00),
                                        width: getHorizontalSize(1.00),
                                        margin: getMargin(
                                            left: 26,
                                            top: 43,
                                            right: 26,
                                            bottom: 43),
                                        decoration: BoxDecoration(
                                            color: ColorConstant.gray400)),
                                    CustomIconButton(
                                        height: 17,
                                        width: 17,
                                        margin: getMargin(
                                            left: 18,
                                            top: 247,
                                            right: 18,
                                            bottom: 247),
                                        shape: IconButtonShape.RoundedBorder8,
                                        padding: IconButtonPadding.PaddingAll2,
                                        alignment: Alignment.bottomLeft,
                                        child: CommonImageView(
                                            svgPath:
                                                ImageConstant.imgCheckmark)),
                                    CustomIconButton(
                                        height: 17,
                                        width: 17,
                                        margin: getMargin(
                                            left: 18,
                                            top: 146,
                                            right: 18,
                                            bottom: 146),
                                        shape: IconButtonShape.RoundedBorder8,
                                        padding: IconButtonPadding.PaddingAll2,
                                        alignment: Alignment.bottomLeft,
                                        child: CommonImageView(
                                            svgPath:
                                                ImageConstant.imgCheckmark)),
                                    CustomIconButton(
                                        height: 17,
                                        width: 17,
                                        margin: getMargin(
                                            left: 18,
                                            top: 35,
                                            right: 18,
                                            bottom: 35),
                                        variant: IconButtonVariant
                                            .OutlineBluegray800,
                                        shape: IconButtonShape.RoundedBorder8,
                                        padding: IconButtonPadding.PaddingAll2,
                                        alignment: Alignment.topLeft,
                                        child: CommonImageView(
                                            svgPath:
                                                ImageConstant.imgCheckmark))
                                  ]))))
                ])));
  }

  onTapImgArrowleft() {
    Get.back();
  }
}
