import 'package:drift/drift.dart';
import 'package:onai_docs/src/core/database/drift/connection/open_connection_stub.dart'
    if (dart.library.io) 'package:onai_docs/src/core/database/drift/connection/open_connection_io.dart'
    if (dart.library.html) 'package:onai_docs/src/core/database/drift/connection/open_connection_web.dart'
    as connection;
import 'package:onai_docs/src/core/database/drift/model/task_table.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [
    Tasks,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase({required String name}) : super(connection.openConnection(name));

  @override
  int get schemaVersion => 2;

  Future<int> addTask({
    required String title,
    required String description,
    required String priority,
    required String code,
    required String userId,
  }) {
    return into(tasks).insert(TasksCompanion.insert(
      title: title,
      description: description,
      priority: priority,
      code: code,
      userId: userId,
    ));
  }

  Future<List<Task>> getTasks(String userId) =>
      (select(tasks)..where((t) => t.userId.equals(userId))).get();

  Future<int> updateTask({
    String? title,
    String? description,
    String? priority,
    required String code,
  }) {
    return (update(tasks)..where((t) => t.code.equals(code))).write(
      TasksCompanion(
        title: title != null ? Value(title) : const Value.absent(),
        description:
            description != null ? Value(description) : const Value.absent(),
        priority: priority != null ? Value(priority) : const Value.absent(),
        code: code != null ? Value(code) : const Value.absent(),
      ),
    );
  }
}
