import 'controller/home_container_controller.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/core/app_export.dart';
import 'package:grocery_app/presentation/categroy_page/categroy_page.dart';
import 'package:grocery_app/presentation/home_page/home_page.dart';
import 'package:grocery_app/presentation/more_page/more_page.dart';
import 'package:grocery_app/presentation/my_bag_page/my_bag_page.dart';
import 'package:grocery_app/widgets/custom_bottom_bar.dart';

class HomeContainerScreen extends GetWidget<HomeContainerController> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: ColorConstant.gray50,
            body: Obx(() => getCurrentWidget(controller.type.value)),
            bottomNavigationBar:
                CustomBottomBar(onChanged: (BottomBarEnum type) {
              controller.type.value = type;
            })));
  }

  Widget getCurrentWidget(BottomBarEnum type) {
    switch (type) {
      case BottomBarEnum.Imghome:
        return HomePage();
      case BottomBarEnum.Imgcomputer24X24:
        return CategroyPage();
      case BottomBarEnum.Imgbag:
        return MyBagPage();
      case BottomBarEnum.Imgmenu:
        return MorePage();
      default:
        return getDefaultWidget();
    }
  }
}
