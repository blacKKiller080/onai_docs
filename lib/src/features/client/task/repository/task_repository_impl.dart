// ignore_for_file: unused_field

import 'dart:developer';

import 'package:onai_docs/src/core/database/drift/app_database.dart';
import 'package:onai_docs/src/core/network/layers/network_executer.dart';
import 'package:onai_docs/src/features/auth/database/auth_dao.dart';
import 'package:onai_docs/src/features/client/task/model/task_dto.dart';
import 'package:onai_docs/src/features/client/task/repository/task_repository.dart';

class TaskRepositoryImpl extends ITaskRepository {
  final IAuthDao _authDao;
  final NetworkExecuter _client;
  final AppDatabase _database;

  TaskRepositoryImpl({
    required NetworkExecuter client,
    required AuthDao authDao,
    required AppDatabase database,
  })  : _authDao = authDao,
        _database = database,
        _client = client;

  @override
  Future<void> addTask({
    required String title,
    required String description,
    required String priority,
    required String code,
  }) async {
    await _database.addTask(
      userId: _authDao.user.value!,
      title: title,
      description: description,
      priority: priority,
      code: code,
    );
  }

  @override
  Future<void> updateTask({
    required String title,
    required String description,
    required String priority,
    required String code,
  }) async {
    await _database.updateTask(
      title: title,
      description: description,
      priority: priority,
      code: code,
    );
  }

  @override
  Future<List<TaskDTO>> getTasks() async {
    try {
      final tasks = await _database.getTasks(_authDao.user.value!);
      return tasks
          .map(
            (task) => TaskDTO(
              userId: task.userId,
              title: task.title,
              description: task.description,
              priority: task.priority,
              code: task.code,
              createdAt: task.createdAt,
            ),
          )
          .toList();
    } catch (e) {
      log('Error fetching tasks: $e');
      return [];
    }
  }
}
