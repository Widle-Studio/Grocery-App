import '../modal_calendar_screen/widgets/listlabel_eight_item_widget.dart';
import 'controller/modal_calendar_controller.dart';
import 'models/listlabel_eight_item_model.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/core/app_export.dart';
import 'package:grocery_app/widgets/custom_drop_down.dart';

class ModalCalendarScreen extends GetWidget<ModalCalendarController> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: size.width,
          child: SingleChildScrollView(
            child: Container(
              height: getVerticalSize(
                512.00,
              ),
              width: getHorizontalSize(
                312.00,
              ),
              child: Stack(
                alignment: Alignment.centerLeft,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: CommonImageView(
                      svgPath: ImageConstant.imgSurfacemediu,
                      height: getVerticalSize(
                        512.00,
                      ),
                      width: getHorizontalSize(
                        312.00,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            width: size.width,
                            decoration: BoxDecoration(
                              color: ColorConstant.yellow900,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(
                                  getHorizontalSize(
                                    9.00,
                                  ),
                                ),
                                topRight: Radius.circular(
                                  getHorizontalSize(
                                    9.00,
                                  ),
                                ),
                              ),
                            ),
                            child: Padding(
                              padding: getPadding(
                                top: 19,
                                bottom: 13,
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: getPadding(
                                      left: 24,
                                      right: 24,
                                    ),
                                    child: Text(
                                      "lbl_select_date2".tr,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.left,
                                      style: AppStyle.txtPoppinsMedium11,
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.center,
                                    child: Padding(
                                      padding: getPadding(
                                        left: 24,
                                        top: 41,
                                        right: 24,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Text(
                                            "lbl_mon_nov_17".tr,
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.left,
                                            style: AppStyle.txtPoppinsMedium29,
                                          ),
                                          Padding(
                                            padding: getPadding(
                                              top: 3,
                                              bottom: 7,
                                            ),
                                            child: CommonImageView(
                                              svgPath: ImageConstant.imgEdit1,
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
                        ),
                        Padding(
                          padding: getPadding(
                            left: 23,
                            top: 15,
                            right: 23,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              CustomDropDown(
                                width: 139,
                                focusNode: FocusNode(),
                                icon: Container(
                                  margin: getMargin(
                                    left: 4,
                                  ),
                                  child: CommonImageView(
                                    svgPath: ImageConstant
                                        .imgNavigationArrowdropdown,
                                  ),
                                ),
                                hintText: "lbl_november_2020".tr,
                                margin: getMargin(
                                  bottom: 1,
                                ),
                                padding: DropDownPadding.PaddingAll4,
                                fontStyle: DropDownFontStyle.PoppinsMedium14,
                                items: controller.modalCalendarModelObj.value
                                    .dropdownItemList,
                                onChanged: (value) {
                                  controller.onSelected(value);
                                },
                              ),
                              Padding(
                                padding: getPadding(
                                  top: 1,
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    CommonImageView(
                                      svgPath:
                                          ImageConstant.imgArrowleftBluegray800,
                                      height: getSize(
                                        24.00,
                                      ),
                                      width: getSize(
                                        24.00,
                                      ),
                                    ),
                                    Padding(
                                      padding: getPadding(
                                        left: 24,
                                      ),
                                      child: CommonImageView(
                                        svgPath: ImageConstant.imgArrowright,
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
                        Padding(
                          padding: getPadding(
                            left: 23,
                            top: 29,
                            right: 23,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Padding(
                                padding: getPadding(
                                  bottom: 1,
                                ),
                                child: Text(
                                  "lbl_s".tr,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.left,
                                  style:
                                      AppStyle.txtPoppinsRegular12Bluegray800,
                                ),
                              ),
                              Padding(
                                padding: getPadding(
                                  top: 1,
                                ),
                                child: Text(
                                  "lbl_m".tr,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.left,
                                  style:
                                      AppStyle.txtPoppinsRegular12Bluegray800,
                                ),
                              ),
                              Padding(
                                padding: getPadding(
                                  top: 1,
                                  bottom: 1,
                                ),
                                child: Text(
                                  "lbl_t".tr,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.left,
                                  style:
                                      AppStyle.txtPoppinsRegular12Bluegray800,
                                ),
                              ),
                              Padding(
                                padding: getPadding(
                                  top: 1,
                                  bottom: 1,
                                ),
                                child: Text(
                                  "lbl_w".tr,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.left,
                                  style:
                                      AppStyle.txtPoppinsRegular12Bluegray800,
                                ),
                              ),
                              Padding(
                                padding: getPadding(
                                  top: 1,
                                  bottom: 1,
                                ),
                                child: Text(
                                  "lbl_t".tr,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.left,
                                  style:
                                      AppStyle.txtPoppinsRegular12Bluegray800,
                                ),
                              ),
                              Padding(
                                padding: getPadding(
                                  top: 1,
                                  bottom: 1,
                                ),
                                child: Text(
                                  "lbl_f".tr,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.left,
                                  style:
                                      AppStyle.txtPoppinsRegular12Bluegray800,
                                ),
                              ),
                              Padding(
                                padding: getPadding(
                                  bottom: 1,
                                ),
                                child: Text(
                                  "lbl_s".tr,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.left,
                                  style:
                                      AppStyle.txtPoppinsRegular12Bluegray800,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: getPadding(
                              left: 29,
                              top: 27,
                              right: 29,
                            ),
                            child: Text(
                              "lbl_1".tr,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.left,
                              style: AppStyle.txtPoppinsRegular12Bluegray800,
                            ),
                          ),
                        ),
                        Padding(
                          padding: getPadding(
                            left: 23,
                            top: 16,
                            right: 23,
                          ),
                          child: Obx(
                            () => ListView.builder(
                              physics: BouncingScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: controller.modalCalendarModelObj.value
                                  .listlabelEightItemList.length,
                              itemBuilder: (context, index) {
                                ListlabelEightItemModel model = controller
                                    .modalCalendarModelObj
                                    .value
                                    .listlabelEightItemList[index];
                                return ListlabelEightItemWidget(
                                  model,
                                );
                              },
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: getPadding(
                              left: 23,
                              top: 27,
                              right: 23,
                            ),
                            child: Text(
                              "lbl_302".tr,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.left,
                              style: AppStyle.txtPoppinsRegular12Bluegray800,
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: getPadding(
                              left: 20,
                              top: 36,
                              right: 20,
                              bottom: 16,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Padding(
                                  padding: getPadding(
                                    bottom: 4,
                                  ),
                                  child: Text(
                                    "lbl_cancel".tr,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.left,
                                    style: AppStyle.txtPoppinsMedium14RedA200b7,
                                  ),
                                ),
                                Padding(
                                  padding: getPadding(
                                    left: 32,
                                    top: 1,
                                  ),
                                  child: Text(
                                    "lbl_okay".tr,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.left,
                                    style: AppStyle
                                        .txtPoppinsMedium14LightgreenA700,
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
      ),
    );
  }
}
