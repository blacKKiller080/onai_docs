import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:onai_docs/src/features/client/task/model/task_dto.dart';
import 'package:onai_docs/src/features/client/task/repository/task_repository.dart';

part 'task_cubit.freezed.dart';

const _tag = "TaskCubit";

class TaskCubit extends Cubit<TaskState> {
  TaskCubit(
    this._taskRepository,
  ) : super(const TaskState.loadingState());

  final ITaskRepository _taskRepository;

  Future<void> getAllTasks() async {
    emit(const TaskState.loadingState());
    try {
      final result = await _taskRepository.getTasks();
      // log('responsed: $response');

      emit(TaskState.loadedState(tasks: result));
    } catch (e) {
      emit(
        TaskState.errorState(message: '$e'),
      );
    }
  }

  Future<void> addTask({
    required String title,
    required String description,
    required String priority,
    required String code,
  }) async {
    emit(const TaskState.loadingState());
    try {
      await _taskRepository.addTask(
        title: title,
        description: description,
        priority: priority,
        code: code,
      );
      // log('responsed: $response');

      emit(const TaskState.taskAddState());
    } catch (e) {
      emit(
        TaskState.errorState(message: '$e'),
      );
    }
  }

  Future<void> updateTask({
    required String title,
    required String description,
    required String priority,
    required String code,
  }) async {
    emit(const TaskState.loadingState());
    try {
      await _taskRepository.updateTask(
        title: title,
        description: description,
        priority: priority,
        code: code,
      );

      emit(const TaskState.taskAddState());
    } catch (e) {
      emit(
        TaskState.errorState(message: '$e'),
      );
    }
  }

  @override
  void onChange(Change<TaskState> change) {
    log(change.toString(), name: _tag);
    super.onChange(change);
  }
}

@freezed
class TaskState with _$TaskState {
  const factory TaskState.loadedState({required List<TaskDTO> tasks}) =
      _LoadedState;

  const factory TaskState.taskAddState() = _TaskAddState;

  const factory TaskState.loadingState() = _LoadingState;

  const factory TaskState.errorState({
    required String message,
  }) = _ErrorState;
}
