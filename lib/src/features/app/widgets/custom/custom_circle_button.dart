import 'package:flutter/material.dart';
import 'package:onai_docs/src/core/resources/resources.dart';

class CustomCircleButton extends StatelessWidget {
  const CustomCircleButton({
    required this.onTap,
    required this.child,
    this.size = 14,
    this.buttonColor = AppColors.kWhite,
    this.elevation = 0,
    this.border = false,
    this.borderColor,
    this.borderWidth,
    super.key,
  });
  final Function()? onTap;
  final double size;
  final Color buttonColor;
  final double elevation;
  final Widget child;
  final bool border;
  final Color? borderColor;
  final double? borderWidth;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: elevation,
      color: buttonColor,
      shape: border
          ? RoundedRectangleBorder(
              side: BorderSide(
                color: borderColor ?? const Color(0xFF000000).withOpacity(0.16),
                width: borderWidth ?? 3,
              ),
              borderRadius: const BorderRadius.all(
                Radius.circular(100),
              ),
            )
          : const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(100),
              ),
            ),
      child: InkWell(
        borderRadius: BorderRadius.circular(100),
        onTap: onTap,
        child: SizedBox(
          height: size,
          width: size,
          child: child,
        ),
      ),
    );
  }
}
