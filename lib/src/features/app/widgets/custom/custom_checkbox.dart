import 'package:flutter/material.dart';

import 'package:onai_docs/src/core/resources/resources.dart';

// ignore: must_be_immutable
class CustomCheckbox extends StatelessWidget {
  final bool isSelect;
  final Function() onTap;
  double? size;
  CustomCheckbox({
    super.key,
    required this.isSelect,
    required this.onTap,
    this.size = 16,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: !isSelect
          ? Container(
              width: size,
              height: size,
              // padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  width: 2,
                  color: AppColors.kElementsTertiary,
                ),
              ),
              child: const SizedBox(),
            )
          : SizedBox(
              width: size,
              height: size,
              child: const DecoratedBox(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.kMainOrange,
                ),
                child: Icon(
                  Icons.check,
                  color: AppColors.kWhite,
                  size: 16,
                ),
              ),
            ),
    );
  }
}
