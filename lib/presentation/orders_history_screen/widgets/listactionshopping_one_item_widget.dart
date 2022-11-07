import '../controller/orders_history_controller.dart';
import '../models/listactionshopping_one_item_model.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/core/app_export.dart';
import 'package:grocery_app/widgets/custom_icon_button.dart';

// ignore: must_be_immutable
class ListactionshoppingOneItemWidget extends StatelessWidget {
  ListactionshoppingOneItemWidget(this.listactionshoppingOneItemModelObj);

  ListactionshoppingOneItemModel listactionshoppingOneItemModelObj;

  var controller = Get.find<OrdersHistoryController>();

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: getPadding(
          top: 20.574997,
          bottom: 20.574997,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomIconButton(
                  height: 44,
                  width: 44,
                  margin: getMargin(
                    top: 3,
                    bottom: 12,
                  ),
                  variant: IconButtonVariant.FillYellow900,
                  padding: IconButtonPadding.PaddingAll10,
                  child: CommonImageView(
                    svgPath: ImageConstant.imgActionshopping,
                  ),
                ),
                Padding(
                  padding: getPadding(
                    left: 19,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "lbl_order_345".tr,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                        style: AppStyle.txtPoppinsMedium16.copyWith(
                          letterSpacing: 0.60,
                        ),
                      ),
                      Padding(
                        padding: getPadding(
                          top: 8,
                          right: 10,
                        ),
                        child: Text(
                          "lbl_cancelled".tr,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                          style: AppStyle.txtPoppinsRegular12RedA200,
                        ),
                      ),
                      Padding(
                        padding: getPadding(
                          top: 8,
                          right: 5,
                        ),
                        child: Text(
                          "msg_october_14_201".tr,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                          style: AppStyle.txtPoppinsRegular12Bluegray800b7,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: getPadding(
                left: 126,
                top: 13,
                bottom: 26,
              ),
              child: Text(
                "lbl_452".tr,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.left,
                style: AppStyle.txtPoppinsSemiBold20Yellow900,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
