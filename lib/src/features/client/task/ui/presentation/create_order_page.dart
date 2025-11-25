import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onai_docs/src/core/resources/resources.dart';
import 'package:onai_docs/src/features/app/router/app_router.dart';
import 'package:onai_docs/src/features/app/widgets/app_bar_with_title.dart';
import 'package:onai_docs/src/features/app/widgets/custom/common_button.dart';
import 'package:onai_docs/src/features/app/widgets/custom/common_input.dart';
import 'package:onai_docs/src/features/app/widgets/custom/custom_circle_button.dart';
import 'package:onai_docs/src/features/app/widgets/custom/custom_divider.dart';
import 'package:onai_docs/src/features/app/widgets/custom/custom_snackbars.dart';
import 'package:onai_docs/src/features/client/task/logic/task_cubit.dart';
import 'package:onai_docs/src/features/client/task/model/task_dto.dart';

@RoutePage()
class CreateOrderPage extends StatefulWidget {
  final TaskDTO? taskDTO;
  const CreateOrderPage({super.key, this.taskDTO});

  @override
  State<CreateOrderPage> createState() => _CreateOrderPageState();
}

class _CreateOrderPageState extends State<CreateOrderPage> {
  final TextEditingController nameTextController = TextEditingController();
  final TextEditingController contentTextController = TextEditingController();

  String selectedPriority = 'low';
  final _formKey = GlobalKey<FormState>();

  final List<Map<String, String>> priorities = [
    {'label': 'Низкий', 'value': 'low'},
    {'label': 'Средний', 'value': 'medium'},
    {'label': 'Высокий', 'value': 'high'},
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nameTextController.text = widget.taskDTO?.title ?? '';
    contentTextController.text = widget.taskDTO?.description ?? '';
    selectedPriority = widget.taskDTO?.priority ?? 'low';
  }

  @override
  void dispose() {
    nameTextController.dispose();
    contentTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TaskCubit, TaskState>(
      listener: (context, state) {
        state.whenOrNull(
          taskAddState: () {
            context.router
                .navigate(const LauncherRoute(children: [TaskRoute()]));
            BlocProvider.of<TaskCubit>(context).getAllTasks();
          },
          errorState: (message) {
            buildErrorCustomSnackBar(context, message);
          },
        );
      },
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const AppBarWithTitle(
                  title: 'Создание задачи',
                  isMain: false,
                ),
                const Text(
                  'Данные задачи',
                  style: AppTextStyles.os14w600,
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.only(top: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: AppColors.kWhite),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text.rich(
                        TextSpan(
                          text: 'Приоритет',
                          style: AppTextStyles.os14w400,
                          children: [
                            TextSpan(
                              text: '*',
                              style: AppTextStyles.os14w400.copyWith(
                                color: AppColors.kRed,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: List.generate(priorities.length, (index) {
                          final priority = priorities[index];
                          final isSelected =
                              selectedPriority == priority['value'];
                          return Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left: index == 0 ? 0 : 5,
                                  right:
                                      index == priorities.length - 1 ? 0 : 5),
                              child: CommonButton(
                                backgroundColor: isSelected
                                    ? AppColors.kBlue
                                    : AppColors.kGreyDivider,
                                contentPaddingVertical: 6,
                                onPressed: () {
                                  setState(() {
                                    selectedPriority = priority['value']!;
                                  });
                                },
                                child: Text(
                                  priority['label']!,
                                  style: !isSelected
                                      ? AppTextStyles.os14w400FoundationGrey
                                      : AppTextStyles.os14w400White,
                                ),
                              ),
                            ),
                          );
                        }),
                      )
                    ],
                  ),
                ),
                Form(
                  key: _formKey,
                  child: Container(
                    margin: const EdgeInsets.only(top: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: AppColors.kWhite),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CommonInput(
                          'Наименование',
                          controller: nameTextController,
                          textInputAction: TextInputAction.next,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Название не может быть пустым';
                            }
                            return null;
                          },
                          suffixIcon: CustomCircleButton(
                            buttonColor: const Color.fromRGBO(204, 204, 204, 1),
                            onTap: () {
                              nameTextController.clear();
                            },
                            child: const Icon(
                              Icons.close_rounded,
                              size: 12,
                              color: AppColors.kWhite,
                            ),
                          ),
                        ),
                        const CustomDivider(height: 0),
                        CommonInput(
                          'Содержание',
                          controller: contentTextController,
                          maxLines: 5,
                          textInputAction: TextInputAction.done,
                          validator: (value) {
                            if (value == null || value.trim().length < 100) {
                              return 'Содержание должно содержать минимум 100 символов';
                            }
                            return null;
                          },
                          suffixIcon: CustomCircleButton(
                            buttonColor: const Color.fromRGBO(204, 204, 204, 1),
                            onTap: () {
                              contentTextController.clear();
                            },
                            child: const Icon(
                              Icons.close_rounded,
                              size: 12,
                              color: AppColors.kWhite,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const Spacer(),
                CommonButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      final uniqueId =
                          DateTime.now().millisecondsSinceEpoch % 1000000;
                      widget.taskDTO != null
                          ? BlocProvider.of<TaskCubit>(context).updateTask(
                              code: widget.taskDTO!.code,
                              priority: selectedPriority,
                              title: nameTextController.text,
                              description: contentTextController.text,
                            )
                          : BlocProvider.of<TaskCubit>(context).addTask(
                              code:
                                  'TK-001-${uniqueId.toString().padLeft(6, '0')}',
                              priority: selectedPriority,
                              title: nameTextController.text,
                              description: contentTextController.text,
                            );
                    }
                  },
                  margin: const EdgeInsets.only(bottom: 20, top: 10),
                  child: const Text('Создать'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
