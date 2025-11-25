import 'package:onai_docs/src/core/network/result.dart';

abstract class IAuthRepository {
  /// Статус аутентификации
  bool get isAuthenticated;

  String? get user;

  Future<bool> clearUser();

  Future<Result<List<Object>>> login({
    required String login,
    required String password,
  });

  Future<String> setUserForTest({
    required String user,
  });
}
