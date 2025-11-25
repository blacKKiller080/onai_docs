import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:onai_docs/src/core/resources/resources.dart';
import 'package:onai_docs/src/features/app/widgets/custom/custom_back_button.dart';

class AppBarWithTitle extends StatelessWidget {
  final bool isMain;
  final TextStyle? titleStyle;
  final String title;

  const AppBarWithTitle({
    super.key,
    this.titleStyle,
    this.isMain = true,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return !isMain
        ? Container(
            padding: const EdgeInsets.only(right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomBackButton(
                  padding: const EdgeInsets.only(left: 10, bottom: 12, top: 12),
                  onTap: () {
                    context.router.maybePop();
                  },
                ),
                Text(title, style: titleStyle ?? AppTextStyles.os20w600),
                const SizedBox(
                  width: 30,
                ),
              ],
            ),
          )
        : SizedBox(
            height: 42,
            child: Text(
              title,
              style: titleStyle ?? AppTextStyles.os20w600,
              overflow: TextOverflow.ellipsis,
            ),
          );
  }
}
