import 'package:flutter/material.dart';
import 'package:grocery_app/core/app_export.dart';

class CustomIconButton extends StatelessWidget {
  CustomIconButton(
      {this.shape,
      this.padding,
      this.variant,
      this.alignment,
      this.margin,
      this.height,
      this.width,
      this.child,
      this.onTap});

  IconButtonShape? shape;

  IconButtonPadding? padding;

  IconButtonVariant? variant;

  Alignment? alignment;

  EdgeInsetsGeometry? margin;

  double? height;

  double? width;

  Widget? child;

  VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
            alignment: alignment ?? Alignment.center,
            child: _buildIconButtonWidget(),
          )
        : _buildIconButtonWidget();
  }

  _buildIconButtonWidget() {
    return Padding(
      padding: margin ?? EdgeInsets.zero,
      child: IconButton(
        constraints: BoxConstraints(
          minHeight: getSize(height ?? 0),
          minWidth: getSize(width ?? 0),
        ),
        padding: EdgeInsets.all(0),
        icon: Container(
          alignment: Alignment.center,
          width: getSize(width ?? 0),
          height: getSize(height ?? 0),
          padding: _setPadding(),
          decoration: _buildDecoration(),
          child: child,
        ),
        onPressed: onTap,
      ),
    );
  }

  _buildDecoration() {
    return BoxDecoration(
      color: _setColor(),
      border: _setBorder(),
      borderRadius: _setBorderRadius(),
      boxShadow: _setBoxShadow(),
    );
  }

  _setPadding() {
    switch (padding) {
      case IconButtonPadding.PaddingAll2:
        return getPadding(
          all: 2,
        );
      case IconButtonPadding.PaddingAll10:
        return getPadding(
          all: 10,
        );
      case IconButtonPadding.PaddingAll13:
        return getPadding(
          all: 13,
        );
      default:
        return getPadding(
          all: 7,
        );
    }
  }

  _setColor() {
    switch (variant) {
      case IconButtonVariant.OutlineBluegray800:
        return ColorConstant.whiteA700;
      case IconButtonVariant.FillYellow900:
        return ColorConstant.yellow900;
      case IconButtonVariant.FillTeal400:
        return ColorConstant.teal400;
      case IconButtonVariant.FillRedA200:
        return ColorConstant.redA200;
      case IconButtonVariant.FillRedA20023:
        return ColorConstant.redA20023;
      case IconButtonVariant.OutlineBlack9003d:
        return ColorConstant.whiteA700;
      case IconButtonVariant.FillBlue7001e:
        return ColorConstant.blue7001e;
      case IconButtonVariant.FillYellow90023:
        return ColorConstant.yellow90023;
      default:
        return ColorConstant.lightGreenA700;
    }
  }

  _setBorder() {
    switch (variant) {
      case IconButtonVariant.OutlineBluegray800:
        return Border.all(
          color: ColorConstant.bluegray800,
          width: getHorizontalSize(
            1.00,
          ),
        );
      case IconButtonVariant.FillLightgreenA700:
      case IconButtonVariant.FillYellow900:
      case IconButtonVariant.FillTeal400:
      case IconButtonVariant.FillRedA200:
      case IconButtonVariant.FillRedA20023:
      case IconButtonVariant.OutlineBlack9003d:
      case IconButtonVariant.FillBlue7001e:
      case IconButtonVariant.FillYellow90023:
        return null;
      default:
        return null;
    }
  }

  _setBorderRadius() {
    switch (shape) {
      case IconButtonShape.RoundedBorder8:
        return BorderRadius.circular(
          getHorizontalSize(
            8.50,
          ),
        );
      case IconButtonShape.CircleBorder18:
        return BorderRadius.circular(
          getHorizontalSize(
            18.00,
          ),
        );
      case IconButtonShape.CircleBorder14:
        return BorderRadius.circular(
          getHorizontalSize(
            14.00,
          ),
        );
      case IconButtonShape.CircleBorder25:
        return BorderRadius.circular(
          getHorizontalSize(
            25.00,
          ),
        );
      default:
        return BorderRadius.circular(
          getHorizontalSize(
            22.00,
          ),
        );
    }
  }

  _setBoxShadow() {
    switch (variant) {
      case IconButtonVariant.OutlineBlack9003d:
        return [
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
          )
        ];
      case IconButtonVariant.FillLightgreenA700:
      case IconButtonVariant.OutlineBluegray800:
      case IconButtonVariant.FillYellow900:
      case IconButtonVariant.FillTeal400:
      case IconButtonVariant.FillRedA200:
      case IconButtonVariant.FillRedA20023:
      case IconButtonVariant.FillBlue7001e:
      case IconButtonVariant.FillYellow90023:
        return null;
      default:
        return null;
    }
  }
}

enum IconButtonShape {
  RoundedBorder8,
  CircleBorder22,
  CircleBorder18,
  CircleBorder14,
  CircleBorder25,
}
enum IconButtonPadding {
  PaddingAll2,
  PaddingAll10,
  PaddingAll7,
  PaddingAll13,
}
enum IconButtonVariant {
  FillLightgreenA700,
  OutlineBluegray800,
  FillYellow900,
  FillTeal400,
  FillRedA200,
  FillRedA20023,
  OutlineBlack9003d,
  FillBlue7001e,
  FillYellow90023,
}
