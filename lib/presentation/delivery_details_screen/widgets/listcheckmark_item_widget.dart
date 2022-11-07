import '../controller/delivery_details_controller.dart';
import '../models/listcheckmark_item_model.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/core/app_export.dart';
import 'package:grocery_app/widgets/custom_icon_button.dart';

// ignore: must_be_immutable
class ListcheckmarkItemWidget extends StatelessWidget {
  ListcheckmarkItemWidget(this.listcheckmarkItemModelObj);

  ListcheckmarkItemModel listcheckmarkItemModelObj;

  var controller = Get.find<DeliveryDetailsController>();

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Padding(
        padding: getPadding(
          top: 5.5,
          bottom: 5.5,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            CustomIconButton(
              height: 17,
              width: 17,
              margin: getMargin(
                top: 35,
                bottom: 33,
              ),
              shape: IconButtonShape.RoundedBorder8,
              padding: IconButtonPadding.PaddingAll2,
              child: CommonImageView(
                svgPath: ImageConstant.imgCheckmark,
              ),
            ),
            Container(
              margin: getMargin(
                left: 21,
              ),
              decoration: AppDecoration.fillTeal40023.copyWith(
                borderRadius: BorderRadiusStyle.roundedBorder12,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: getPadding(
                      left: 24,
                      top: 20,
                      right: 24,
                    ),
                    child: Text(
                      "msg_delivering_to_h".tr,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.left,
                      style: AppStyle.txtPoppinsMedium16.copyWith(
                        letterSpacing: 0.60,
                      ),
                    ),
                  ),
                  Padding(
                    padding: getPadding(
                      left: 24,
                      top: 9,
                      right: 24,
                      bottom: 20,
                    ),
                    child: Text(
                      "msg_april_19_2012".tr,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.left,
                      style: AppStyle.txtPoppinsRegular14,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
