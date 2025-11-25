import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:onai_docs/src/core/resources/resources.dart';
import 'package:onai_docs/src/features/app/router/app_router.dart';
import 'package:onai_docs/src/features/app/widgets/app_bar_with_title.dart';
import 'package:onai_docs/src/features/app/widgets/custom/common_button.dart';
import 'package:onai_docs/src/features/app/widgets/custom/custom_divider.dart';
import 'package:onai_docs/src/features/client/task/model/task_dto.dart';
import 'package:readmore/readmore.dart';

@RoutePage()
class EditOrderPage extends StatefulWidget {
  final TaskDTO task;
  const EditOrderPage({super.key, required this.task});

  @override
  State<EditOrderPage> createState() => _EditOrderPageState();
}

class _EditOrderPageState extends State<EditOrderPage> {
  bool isExpanded = false;

  String _getPriorityText(String priority) {
    switch (priority.toLowerCase()) {
      case 'high':
        return 'Высокий';
      case 'medium':
        return 'Средний';
      default:
        return 'Низкий';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              AppBarWithTitle(
                title: 'Задача: ${widget.task.code}',
                isMain: false,
              ),
              Card(
                color: AppColors.kWhite,
                elevation: 0,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Text(
                            'Приоритет',
                            style: AppTextStyles.os12w400Grey,
                          ),
                          const SizedBox(width: 30),
                          Text(
                            _getPriorityText(widget.task.priority),
                            style: AppTextStyles.os14w400,
                          ),
                        ],
                      ),
                      const CustomDivider(height: 18),
                      const Text(
                        'Наименование',
                        style: AppTextStyles.os14w400Grey,
                      ),
                      Text(
                        widget.task.title,
                        style: AppTextStyles.os14w400,
                      ),
                      const CustomDivider(height: 18),
                      const Text(
                        'Содержание',
                        style: AppTextStyles.os14w400Grey,
                      ),
                      ReadMoreText(
                        widget.task.description,
                        trimMode: TrimMode.Line,
                        trimLines: 3,
                        colorClickableText: AppColors.kBlue,
                        trimCollapsedText: ' Развернуть',
                        trimExpandedText: '  Скрыть',
                        moreStyle: AppTextStyles.os14w400,
                      ),
                      // Row(
                      //   crossAxisAlignment: CrossAxisAlignment.start,
                      //   children: [
                      //     // Text (takes all width except button)
                      //     Expanded(
                      //       child: Text(
                      //         widget.task.description,
                      //         maxLines: isExpanded ? null : 3,
                      //         overflow: isExpanded
                      //             ? TextOverflow.visible
                      //             : TextOverflow.ellipsis,
                      //         style: AppTextStyles.os14w400,
                      //       ),
                      //     ),

                      //     // Button near text
                      //     TextButton(
                      //       onPressed: () {
                      //         setState(() => isExpanded = !isExpanded);
                      //       },
                      //       child: Text(
                      //         isExpanded ? 'Скрыть' : 'Развернуть',
                      //         style: AppTextStyles.os14w400.copyWith(
                      //           color: AppColors.kBlue,
                      //         ),
                      //       ),
                      //     ),
                      //   ],
                      // ),
                    ],
                  ),
                ),
              ),
              const Spacer(),
              CommonButton(
                onPressed: () =>
                    context.router.push(CreateOrderRoute(taskDTO: widget.task)),
                margin: const EdgeInsets.only(bottom: 20, top: 10),
                child: const Text('Редактировать'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
