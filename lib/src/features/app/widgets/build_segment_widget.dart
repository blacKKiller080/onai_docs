import 'package:flutter/material.dart';
import 'package:onai_docs/src/core/resources/resources.dart';

class BuildSegmentWidget extends StatelessWidget {
  final String text;
  final bool isSelected;
  final bool isBordered;
  const BuildSegmentWidget({
    super.key,
    required this.isSelected,
    required this.text,
    this.isBordered = false,
  });
  //

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 38,
      child: Text(
        text,
        style: isSelected
            ? AppTextStyles.os14w400White.copyWith(height: 1)
            : AppTextStyles.os14w400.copyWith(
                color: AppColors.kTextTertiary,
                height: 1,
              ),
      ),
    );
  }
}
