import '../my_bag_page/widgets/listrectangleone_item_widget.dart';
import '../my_bag_page/widgets/listtime_item_widget.dart';
import 'controller/my_bag_controller.dart';
import 'models/listrectangleone_item_model.dart';
import 'models/listtime_item_model.dart';
import 'models/my_bag_model.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/core/app_export.dart';
import 'package:grocery_app/widgets/custom_button.dart';
import 'package:grocery_app/widgets/custom_drop_down.dart';
import 'package:grocery_app/widgets/custom_icon_button.dart';

// ignore_for_file: must_be_immutable
class MyBagPage extends StatelessWidget {
  MyBagController controller = Get.put(MyBagController(MyBagModel().obs));

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
                  child: Container(
                    height: getVerticalSize(
                      1459.00,
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
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Container(
                                    height: getVerticalSize(
                                      347.00,
                                    ),
                                    width: getHorizontalSize(
                                      374.00,
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
                                              imagePath:
                                                  ImageConstant.imgMain1347X374,
                                              height: getVerticalSize(
                                                347.00,
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
                                            decoration: AppDecoration
                                                .gradientGray5099WhiteA70099,
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding: getPadding(
                                                    left: 16,
                                                    top: 15,
                                                    right: 16,
                                                  ),
                                                  child: Text(
                                                    "lbl_my_bag".tr,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    textAlign: TextAlign.left,
                                                    style: AppStyle
                                                        .txtPoppinsSemiBold20,
                                                  ),
                                                ),
                                                Padding(
                                                  padding: getPadding(
                                                    left: 16,
                                                    top: 43,
                                                    right: 16,
                                                    bottom: 250,
                                                  ),
                                                  child: Text(
                                                    "lbl_products".tr,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    textAlign: TextAlign.left,
                                                    style: AppStyle
                                                        .txtPoppinsMedium16
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
                                ),
                                CustomButton(
                                  width: 343,
                                  text: "msg_add_more_produc".tr,
                                  margin: getMargin(
                                    left: 15,
                                    top: 119,
                                    right: 15,
                                  ),
                                  padding: ButtonPadding.PaddingAll15,
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: getPadding(
                                      left: 16,
                                      top: 46,
                                      right: 16,
                                    ),
                                    child: Text(
                                      "msg_expected_date".tr,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.left,
                                      style:
                                          AppStyle.txtPoppinsMedium16.copyWith(
                                        letterSpacing: 0.60,
                                      ),
                                    ),
                                  ),
                                ),
                                CustomDropDown(
                                  width: 343,
                                  focusNode: FocusNode(),
                                  icon: Container(
                                    margin: getMargin(
                                      left: 30,
                                      right: 17,
                                    ),
                                    child: CommonImageView(
                                      svgPath: ImageConstant.imgArrowdown,
                                    ),
                                  ),
                                  hintText: "lbl_select_date".tr,
                                  margin: getMargin(
                                    left: 15,
                                    top: 20,
                                    right: 15,
                                  ),
                                  items: controller
                                      .myBagModelObj.value.dropdownItemList,
                                  prefix: Container(
                                    margin: getMargin(
                                      left: 16,
                                      top: 14,
                                      right: 20,
                                      bottom: 14,
                                    ),
                                    child: CommonImageView(
                                      svgPath: ImageConstant.imgCalendar,
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
                                  onChanged: (value) {
                                    controller.onSelected(value);
                                  },
                                ),
                                Padding(
                                  padding: getPadding(
                                    left: 15,
                                    top: 19,
                                    right: 15,
                                  ),
                                  child: Obx(
                                    () => ListView.builder(
                                      physics: NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: controller.myBagModelObj.value
                                          .listtimeItemList.length,
                                      itemBuilder: (context, index) {
                                        ListtimeItemModel model = controller
                                            .myBagModelObj
                                            .value
                                            .listtimeItemList[index];
                                        return ListtimeItemWidget(
                                          model,
                                        );
                                      },
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: getPadding(
                                    left: 15,
                                    top: 55,
                                    right: 15,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Text(
                                        "msg_delivery_locati".tr,
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.left,
                                        style: AppStyle.txtPoppinsMedium16
                                            .copyWith(
                                          letterSpacing: 0.60,
                                        ),
                                      ),
                                      Padding(
                                        padding: getPadding(
                                          top: 1,
                                        ),
                                        child: Text(
                                          "lbl_change".tr,
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.left,
                                          style: AppStyle
                                              .txtPoppinsMedium16LightgreenA700
                                              .copyWith(
                                            letterSpacing: 0.60,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: getPadding(
                                      left: 15,
                                      top: 20,
                                      right: 15,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        CustomIconButton(
                                          height: 42,
                                          width: 42,
                                          variant:
                                              IconButtonVariant.FillBlue7001e,
                                          child: CommonImageView(
                                            svgPath:
                                                ImageConstant.imgLocation42X42,
                                          ),
                                        ),
                                        Container(
                                          width: getHorizontalSize(
                                            237.00,
                                          ),
                                          margin: getMargin(
                                            left: 16,
                                            top: 5,
                                            bottom: 4,
                                          ),
                                          child: Text(
                                            "msg_floor_4_wakil".tr,
                                            maxLines: null,
                                            textAlign: TextAlign.left,
                                            style: AppStyle.txtPoppinsRegular14,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Container(
                                    height: getVerticalSize(
                                      507.00,
                                    ),
                                    width: getHorizontalSize(
                                      374.00,
                                    ),
                                    margin: getMargin(
                                      top: 25,
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
                                                  ImageConstant.imgMain1281X374,
                                              height: getVerticalSize(
                                                281.00,
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
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Align(
                                                  alignment: Alignment.center,
                                                  child: Padding(
                                                    padding: getPadding(
                                                      left: 15,
                                                      top: 25,
                                                      right: 15,
                                                    ),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      children: [
                                                        Padding(
                                                          padding: getPadding(
                                                            bottom: 1,
                                                          ),
                                                          child: Text(
                                                            "lbl_subtotal".tr,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            textAlign:
                                                                TextAlign.left,
                                                            style: AppStyle
                                                                .txtPoppinsRegular15
                                                                .copyWith(
                                                              letterSpacing:
                                                                  0.60,
                                                            ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding: getPadding(
                                                            top: 1,
                                                          ),
                                                          child: Text(
                                                            "lbl_bdt362".tr,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            textAlign:
                                                                TextAlign.left,
                                                            style: AppStyle
                                                                .txtPoppinsRegular15
                                                                .copyWith(
                                                              letterSpacing:
                                                                  0.60,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Align(
                                                  alignment: Alignment.center,
                                                  child: Padding(
                                                    padding: getPadding(
                                                      left: 15,
                                                      top: 25,
                                                      right: 15,
                                                    ),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      children: [
                                                        Padding(
                                                          padding: getPadding(
                                                            top: 1,
                                                          ),
                                                          child: Text(
                                                            "lbl_delivery_charge"
                                                                .tr,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            textAlign:
                                                                TextAlign.left,
                                                            style: AppStyle
                                                                .txtPoppinsRegular15
                                                                .copyWith(
                                                              letterSpacing:
                                                                  0.60,
                                                            ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding: getPadding(
                                                            bottom: 3,
                                                          ),
                                                          child: Text(
                                                            "lbl_bdt50".tr,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            textAlign:
                                                                TextAlign.left,
                                                            style: AppStyle
                                                                .txtPoppinsRegular15
                                                                .copyWith(
                                                              letterSpacing:
                                                                  0.60,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Align(
                                                  alignment: Alignment.center,
                                                  child: Padding(
                                                    padding: getPadding(
                                                      left: 15,
                                                      top: 21,
                                                      right: 15,
                                                    ),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      children: [
                                                        Padding(
                                                          padding: getPadding(
                                                            bottom: 1,
                                                          ),
                                                          child: Text(
                                                            "lbl_total".tr,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            textAlign:
                                                                TextAlign.left,
                                                            style: AppStyle
                                                                .txtPoppinsMedium15
                                                                .copyWith(
                                                              letterSpacing:
                                                                  0.60,
                                                            ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding: getPadding(
                                                            top: 1,
                                                          ),
                                                          child: Text(
                                                            "lbl_bdt412".tr,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            textAlign:
                                                                TextAlign.left,
                                                            style: AppStyle
                                                                .txtPoppinsMedium15
                                                                .copyWith(
                                                              letterSpacing:
                                                                  0.60,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: getPadding(
                                                    left: 25,
                                                    top: 48,
                                                    right: 25,
                                                  ),
                                                  child: Text(
                                                    "lbl_payment_method".tr,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    textAlign: TextAlign.left,
                                                    style: AppStyle
                                                        .txtPoppinsMedium16
                                                        .copyWith(
                                                      letterSpacing: 0.60,
                                                    ),
                                                  ),
                                                ),
                                                Align(
                                                  alignment:
                                                      Alignment.centerRight,
                                                  child: Container(
                                                    margin: getMargin(
                                                      left: 25,
                                                      top: 17,
                                                      right: 7,
                                                    ),
                                                    decoration: AppDecoration
                                                        .fillTeal40023
                                                        .copyWith(
                                                      borderRadius:
                                                          BorderRadiusStyle
                                                              .roundedBorder12,
                                                    ),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      children: [
                                                        Padding(
                                                          padding: getPadding(
                                                            top: 22,
                                                            bottom: 21,
                                                          ),
                                                          child: Row(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            children: [
                                                              CustomIconButton(
                                                                height: 42,
                                                                width: 42,
                                                                child:
                                                                    CommonImageView(
                                                                  svgPath:
                                                                      ImageConstant
                                                                          .imgCall42X42,
                                                                ),
                                                              ),
                                                              Container(
                                                                width:
                                                                    getHorizontalSize(
                                                                  160.00,
                                                                ),
                                                                margin:
                                                                    getMargin(
                                                                  left: 14,
                                                                  top: 4,
                                                                  bottom: 1,
                                                                ),
                                                                child: Text(
                                                                  "msg_tap_here_to_sel"
                                                                      .tr,
                                                                  maxLines:
                                                                      null,
                                                                  textAlign:
                                                                      TextAlign
                                                                          .left,
                                                                  style: AppStyle
                                                                      .txtPoppinsRegular14,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding: getPadding(
                                                            left: 62,
                                                            top: 31,
                                                            right: 21,
                                                            bottom: 30,
                                                          ),
                                                          child:
                                                              CommonImageView(
                                                            svgPath: ImageConstant
                                                                .imgArrowright,
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
                                                Align(
                                                  alignment: Alignment.center,
                                                  child: Container(
                                                    margin: getMargin(
                                                      left: 15,
                                                      top: 30,
                                                      right: 15,
                                                      bottom: 141,
                                                    ),
                                                    decoration: AppDecoration
                                                        .fillLightgreenA700
                                                        .copyWith(
                                                      borderRadius:
                                                          BorderRadiusStyle
                                                              .roundedBorder9,
                                                    ),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      children: [
                                                        Padding(
                                                          padding: getPadding(
                                                            top: 16,
                                                            bottom: 15,
                                                          ),
                                                          child: Text(
                                                            "lbl_place_order"
                                                                .tr,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            textAlign:
                                                                TextAlign.left,
                                                            style: AppStyle
                                                                .txtPoppinsMedium16WhiteA700,
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding: getPadding(
                                                            left: 92,
                                                            top: 12,
                                                            right: 16,
                                                            bottom: 12,
                                                          ),
                                                          child:
                                                              CommonImageView(
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
                        Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: getPadding(
                              top: 111,
                              bottom: 111,
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: getPadding(
                                    left: 14,
                                    top: 21,
                                    right: 14,
                                  ),
                                  child: Obx(
                                    () => ListView.separated(
                                      physics: NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      separatorBuilder: (context, index) {
                                        return Container(
                                          height: getVerticalSize(
                                            2.00,
                                          ),
                                          width: size.width,
                                          decoration: BoxDecoration(
                                            color: ColorConstant.gray200,
                                          ),
                                        );
                                      },
                                      itemCount: controller.myBagModelObj.value
                                          .listrectangleoneItemList.length,
                                      itemBuilder: (context, index) {
                                        ListrectangleoneItemModel model =
                                            controller.myBagModelObj.value
                                                    .listrectangleoneItemList[
                                                index];
                                        return ListrectangleoneItemWidget(
                                          model,
                                        );
                                      },
                                    ),
                                  ),
                                ),
                                Container(
                                  height: getVerticalSize(
                                    2.00,
                                  ),
                                  width: size.width,
                                  margin: getMargin(
                                    top: 20,
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
