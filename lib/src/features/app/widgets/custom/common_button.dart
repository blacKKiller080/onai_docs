// ignore_for_file: prefer_const_constructors, must_be_immutable, use_key_in_widget_constructors, unused_local_variable

import 'package:flutter/material.dart';
import 'package:onai_docs/src/core/resources/resources.dart';

class CommonButton extends StatelessWidget {
  Widget child;
  Function? onPressed;
  Widget? icon;
  Color? backgroundColor;
  BoxBorder? gradientBorder;

  EdgeInsets? margin;
  final Color foregroundColor;
  Color? borderColor;
  final double borderWidth;

  bool success;
  bool disabled;

  double contentPaddingVertical;
  double fontSize;
  bool hasIconMiniButton;
  bool hasDownIcon;
  double? radius;
  double? containerWidth;
  double? containerHeight;

  bool bigText;
  double contentPaddingHorizontal;
  bool shadow;
  FontWeight fontWeight;
  bool gradient;

  CommonButton({
    required this.child,
    this.onPressed,
    this.radius = 10,
    this.success = true,
    this.disabled = false,
    this.borderColor,
    this.foregroundColor = AppColors.kWhite,
    this.margin,
    this.contentPaddingVertical = 17.5,
    this.fontSize = 16,
    this.hasIconMiniButton = false,
    this.hasDownIcon = false,
    this.icon,
    this.contentPaddingHorizontal = 0,
    this.bigText = true,
    this.shadow = false,
    this.fontWeight = FontWeight.w700,
    this.containerWidth,
    this.containerHeight,
    this.borderWidth = 0,
    this.gradient = false,
    this.gradientBorder,
    this.backgroundColor = AppColors.kMainBlue,
  });

  @override
  Widget build(BuildContext context) {
    // var height = MediaQuery.of(context).size.height / 100;
    // var width = MediaQuery.of(context).size.width / 100;
    return Container(
      margin: margin,
      decoration: BoxDecoration(
        color: backgroundColor,
        border: gradientBorder ??
            Border.all(
              color: borderColor ?? Colors.transparent,
              width: borderWidth,
            ),
        gradient: gradient
            ? LinearGradient(
                colors: const [
                  Color.fromRGBO(255, 211, 0, 0.8),
                  Color.fromRGBO(255, 144, 81, 0.972864),
                  Color.fromRGBO(255, 134, 94, 1),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              )
            : null,
        borderRadius: BorderRadius.circular(radius!),
        boxShadow: shadow
            ? [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 2.5,
                  blurRadius: 7,
                  offset: Offset(0, 0),
                ),
              ]
            : [],
      ),
      child: TextButton(
        onPressed: () {
          if (!disabled && success) {
            onPressed?.call();
          }
        },
        style: ButtonStyle(
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          minimumSize: WidgetStateProperty.all(Size(0, 0)),
          splashFactory: NoSplash.splashFactory,
          overlayColor: WidgetStateProperty.all(Colors.transparent),
          foregroundColor: WidgetStateProperty.all(getForegroundColor()),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(radius!)),
            ),
          ),
          textStyle: WidgetStateProperty.all(
            TextStyle(
              fontWeight: fontWeight,
              fontSize: fontSize,
              fontFamily: 'Nunito',
            ),
          ),
          padding: WidgetStateProperty.all(
            EdgeInsets.symmetric(
              vertical: contentPaddingVertical,
              horizontal: contentPaddingHorizontal,
            ),
          ),
        ),
        child: Center(child: child),
      ),
    );
  }

  Color getBackgroundColor() {
    Color color;
    if (disabled) {
      color = Color(0x29009C73);
      borderColor = Color(0x29009C73);
    } else {
      color = AppColors.kBlue;
    }
    return color;
  }

  Color getForegroundColor() {
    Color color;
    if (disabled) {
      color = AppColors.kWhite;
    } else {
      color = foregroundColor;
    }
    return color;
  }
}
