import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:onai_docs/src/core/resources/resources.dart';
import 'package:onai_docs/src/features/app/router/app_router.dart';
import 'package:onai_docs/src/features/app/widgets/app_bar_with_title.dart';
import 'package:onai_docs/src/features/app/widgets/custom/common_button.dart';
import 'package:onai_docs/src/features/app/widgets/custom/common_input.dart';
import 'package:onai_docs/src/features/app/widgets/custom/custom_divider.dart';
import 'package:onai_docs/src/features/app/widgets/custom/custom_snackbars.dart';
import 'package:onai_docs/src/features/client/task/logic/task_cubit.dart';
import 'package:onai_docs/src/features/client/task/model/task_dto.dart';

@RoutePage()
class TaskPage extends StatefulWidget {
  const TaskPage({super.key});

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  final TextEditingController searchController = TextEditingController();
  List<TaskDTO> filteredTasks = [];

  @override
  void initState() {
    super.initState();
    BlocProvider.of<TaskCubit>(context).getAllTasks();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void filterTasks(List<TaskDTO> tasks) {
    final query = searchController.text.trim().toLowerCase();

    if (query.isEmpty) {
      setState(() {
        filteredTasks = tasks;
      });
      return;
    }

    setState(() {
      filteredTasks =
          tasks.where((t) => t.title.toLowerCase().contains(query)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TaskCubit, TaskState>(listener: (context, state) {
      state.whenOrNull(
        loadedState: (tasks) {
          if (searchController.text.isEmpty) {
            filteredTasks = tasks;
          } else {
            filterTasks(tasks);
          }
        },
        errorState: (message) {
          buildErrorCustomSnackBar(context, message);
        },
      );
    }, builder: (context, state) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            const AppBarWithTitle(title: 'Задачи'),
            CommonInput(
              'Нажмите, для начала поиска',
              controller: searchController,
              prefixIcon: const Icon(Icons.search, size: 30),
              contentPaddingVertical: 13,
              onChanged: (_) {
                final state = context.read<TaskCubit>().state;
                state.whenOrNull(
                  loadedState: (tasks) => filterTasks(tasks),
                );
              },
            ),
            Expanded(
              child: state.maybeWhen(
                loadingState: () {
                  return Container(
                    margin: const EdgeInsets.only(top: 12),
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                },
                loadedState: (tasks) {
                  return ListView.separated(
                    itemCount: filteredTasks.length,
                    itemBuilder: (context, index) {
                      return taskWidget(task: filteredTasks[index]);
                    },
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 0),
                  );
                },
                orElse: () => const SizedBox(),
              ),
            ),
            CommonButton(
              onPressed: () => context.router.push(CreateOrderRoute()),
              margin: const EdgeInsets.only(bottom: 20, top: 10),
              child: const Text('Создать заказ'),
            ),
          ],
        ),
      );
    });
  }

  Map<String, dynamic> _getPriorityStyles(String priority) {
    switch (priority.toLowerCase()) {
      case 'high':
        return {
          'text': 'Высокий',
          'bgColor': const Color.fromRGBO(255, 76, 76, 0.16),
          'textColor': const Color.fromRGBO(184, 0, 0, 1),
        };

      case 'medium':
        return {
          'text': 'Средний',
          'bgColor': const Color.fromRGBO(255, 184, 0, 0.16),
          'textColor': const Color.fromRGBO(156, 108, 0, 1),
        };

      default:
        return {
          'text': 'Низкий',
          'bgColor': const Color.fromRGBO(0, 184, 217, 0.16),
          'textColor': const Color.fromRGBO(0, 108, 156, 1),
        };
    }
  }

  Widget taskWidget({required TaskDTO task}) {
    final priorityStyles = _getPriorityStyles(task.priority);

    return InkWell(
      onTap: () {
        context.router.push(EditOrderRoute(task: task));
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.only(top: 12),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8), color: AppColors.kWhite),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(task.title, style: AppTextStyles.os16w600),
                Text(task.code, style: AppTextStyles.os12w400)
              ],
            ),
            const SizedBox(height: 6),
            Container(
              decoration: BoxDecoration(
                color: priorityStyles['bgColor'] as Color,
                borderRadius: BorderRadius.circular(4),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Text(
                priorityStyles['text'] as String,
                style: AppTextStyles.os10w400.copyWith(
                  color: priorityStyles['textColor'] as Color,
                ),
              ),
            ),
            const SizedBox(height: 6),
            Text(
              task.description,
              style: AppTextStyles.os12w400,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const CustomDivider(height: 12),
            Text(
              'Дата создания:${DateFormat('dd.MM.yyyy').format(task.createdAt.toLocal())}',
              style: AppTextStyles.os10w400,
            )
          ],
        ),
      ),
    );
  }
}
