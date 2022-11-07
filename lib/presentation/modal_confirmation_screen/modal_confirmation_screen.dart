import 'controller/modal_confirmation_controller.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/core/app_export.dart';
import 'package:grocery_app/widgets/custom_text_form_field.dart';

class ModalConfirmationScreen extends GetWidget<ModalConfirmationController> {
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
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    width: getHorizontalSize(
                      277.00,
                    ),
                    margin: getMargin(
                      left: 23,
                      top: 37,
                      right: 23,
                    ),
                    child: Text(
                      "msg_are_you_sure_ab".tr,
                      maxLines: null,
                      textAlign: TextAlign.left,
                      style: AppStyle.txtPoppinsMedium24,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    margin: getMargin(
                      left: 17,
                      top: 48,
                      right: 15,
                    ),
                    decoration: AppDecoration.fillLightgreenA700.copyWith(
                      borderRadius: BorderRadiusStyle.roundedBorder9,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: getPadding(
                            top: 16,
                            bottom: 15,
                          ),
                          child: Text(
                            "lbl_go_back".tr,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.left,
                            style: AppStyle.txtPoppinsMedium16WhiteA700,
                          ),
                        ),
                        Padding(
                          padding: getPadding(
                            left: 106,
                            top: 12,
                            right: 16,
                            bottom: 12,
                          ),
                          child: CommonImageView(
                            svgPath: ImageConstant.imgArrowleftWhiteA700,
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
                CustomTextFormField(
                  width: 343,
                  focusNode: FocusNode(),
                  controller: controller.buttonsmobileController,
                  hintText: "lbl_confirm".tr,
                  margin: getMargin(
                    left: 17,
                    top: 13,
                    right: 15,
                    bottom: 5,
                  ),
                  variant: TextFormFieldVariant.FillRedA200,
                  textInputAction: TextInputAction.done,
                  alignment: Alignment.center,
                  suffix: Container(
                    margin: getMargin(
                      left: 30,
                      top: 12,
                      right: 16,
                      bottom: 12,
                    ),
                    child: CommonImageView(
                      svgPath: ImageConstant.imgActionDeleteoutline24px,
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
