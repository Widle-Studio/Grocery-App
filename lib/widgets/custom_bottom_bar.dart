import 'package:flutter/material.dart';
import 'package:grocery_app/core/app_export.dart';

class CustomBottomBar extends StatelessWidget {
  CustomBottomBar({this.onChanged});

  RxInt selectedIndex = 0.obs;

  List<BottomMenuModel> bottomMenuList = [
    BottomMenuModel(
      icon: ImageConstant.imgHome,
      type: BottomBarEnum.Imghome,
    ),
    BottomMenuModel(
      icon: ImageConstant.imgComputer24X24,
      type: BottomBarEnum.Imgcomputer24X24,
    ),
    BottomMenuModel(
      icon: ImageConstant.imgBag,
      type: BottomBarEnum.Imgbag,
    ),
    BottomMenuModel(
      icon: ImageConstant.imgMenu,
      type: BottomBarEnum.Imgmenu,
    )
  ];

  Function(BottomBarEnum)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        decoration: BoxDecoration(
          color: ColorConstant.whiteA700,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(
              getHorizontalSize(
                20.00,
              ),
            ),
            topRight: Radius.circular(
              getHorizontalSize(
                20.00,
              ),
            ),
          ),
          boxShadow: [
            BoxShadow(
              color: ColorConstant.black9003d,
              spreadRadius: getHorizontalSize(
                2.00,
              ),
              blurRadius: getHorizontalSize(
                2.00,
              ),
              offset: Offset(
                0,
                2,
              ),
            ),
          ],
        ),
        child: BottomNavigationBar(
          backgroundColor: Colors.transparent,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          elevation: 0,
          currentIndex: selectedIndex.value,
          type: BottomNavigationBarType.fixed,
          items: List.generate(bottomMenuList.length, (index) {
            return BottomNavigationBarItem(
              icon: CommonImageView(
                svgPath: bottomMenuList[index].icon,
                height: getSize(
                  24.00,
                ),
                width: getSize(
                  24.00,
                ),
                color: ColorConstant.bluegray800,
              ),
              activeIcon: Card(
                clipBehavior: Clip.antiAlias,
                elevation: 0,
                margin: EdgeInsets.all(0),
                color: ColorConstant.lightGreenA700,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusStyle.circleBorder27,
                ),
                child: Container(
                  height: getSize(
                    54.00,
                  ),
                  width: getSize(
                    54.00,
                  ),
                  decoration: AppDecoration.fillLightgreenA700.copyWith(
                    borderRadius: BorderRadiusStyle.circleBorder27,
                  ),
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: getPadding(
                            left: 15,
                            top: 14,
                            right: 15,
                            bottom: 16,
                          ),
                          child: CommonImageView(
                            svgPath: bottomMenuList[index].icon,
                            height: getSize(
                              24.00,
                            ),
                            width: getSize(
                              24.00,
                            ),
                            color: ColorConstant.whiteA700,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              label: '',
            );
          }),
          onTap: (index) {
            selectedIndex.value = index;
            onChanged!(bottomMenuList[index].type);
          },
        ),
      ),
    );
  }
}

enum BottomBarEnum {
  Imghome,
  Imgcomputer24X24,
  Imgbag,
  Imgmenu,
}

class BottomMenuModel {
  BottomMenuModel({required this.icon, required this.type});

  String icon;

  BottomBarEnum type;
}

///Set default widget when screen is not configured with bottom menu
Widget getDefaultWidget() {
  return Container(
    color: Colors.white,
    padding: EdgeInsets.all(10),
    child: Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Please replace the respective Widget here',
            style: TextStyle(
              fontSize: 18,
            ),
          ),
        ],
      ),
    ),
  );
}
