import 'package:drift/drift.dart';

class Tasks extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get userId => text()();
  TextColumn get title => text()();
  TextColumn get description => text()();
  TextColumn get priority => text()();
  TextColumn get code => text()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}
