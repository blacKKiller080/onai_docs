import 'package:onai_docs/src/features/client/task/model/task_dto.dart';

abstract class ITaskRepository {
  Future<void> addTask({
    required String title,
    required String description,
    required String priority,
    required String code,
  });

  Future<void> updateTask({
    required String title,
    required String description,
    required String priority,
    required String code,
  });

  Future<List<TaskDTO>> getTasks();
}
