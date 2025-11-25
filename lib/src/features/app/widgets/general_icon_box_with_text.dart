import 'package:flutter/material.dart';
import 'package:onai_docs/src/core/resources/resources.dart';

class GeneralIconBoxWithText extends StatelessWidget {
  final EdgeInsets? padding;
  final String text;
  final TextStyle? style;
  final void Function()? onPressed;
  final Widget? secondIcon;

  const GeneralIconBoxWithText({
    super.key,
    this.padding,
    required this.text,
    this.style,
    this.onPressed,
    this.secondIcon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: GestureDetector(
        onTap: onPressed,
        behavior: HitTestBehavior.opaque,
        child: Padding(
          padding: padding ?? EdgeInsets.zero,
          child: Row(
            children: [
              Expanded(
                child: Text(
                  text,
                  style: style ?? AppTextStyles.os16w700,
                ),
              ),
              secondIcon ?? const SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }
}
