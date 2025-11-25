import 'package:freezed_annotation/freezed_annotation.dart';

part 'task_dto.freezed.dart';
part 'task_dto.g.dart';

@freezed
abstract class TaskDTO with _$TaskDTO {
  const factory TaskDTO({
    int? id,
    required String userId,
    required String title,
    required String description,
    required String priority,
    required String code,
    required DateTime createdAt,
  }) = _TaskDTO;

  factory TaskDTO.fromJson(Map<String, dynamic> json) =>
      _$TaskDTOFromJson(json);
}
