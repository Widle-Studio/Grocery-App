import '../controller/edit_profile_controller.dart';
import '../models/edit_profile_item_model.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/core/app_export.dart';

// ignore: must_be_immutable
class EditProfileItemWidget extends StatelessWidget {
  EditProfileItemWidget(this.editProfileItemModelObj);

  EditProfileItemModel editProfileItemModelObj;

  var controller = Get.find<EditProfileController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: getMargin(
        top: 7.5,
        bottom: 7.5,
      ),
      decoration: AppDecoration.fillBluegray50.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder9,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: getPadding(
              left: 16,
              top: 16,
              bottom: 12,
            ),
            child: CommonImageView(
              svgPath: ImageConstant.imgUser,
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
              left: 20,
              top: 9,
              right: 187,
              bottom: 7,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: getPadding(
                    right: 10,
                  ),
                  child: Text(
                    "lbl_full_name".tr,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                    style: AppStyle.txtPoppinsRegular12Bluegray800,
                  ),
                ),
                Padding(
                  padding: getPadding(
                    top: 7,
                  ),
                  child: Text(
                    "lbl_robert_miles".tr,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                    style: AppStyle.txtPoppinsRegular16Bluegray800,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
