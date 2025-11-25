// ignore_for_file: unused_field

import 'package:onai_docs/src/core/network/layers/network_executer.dart';
import 'package:onai_docs/src/core/network/result.dart';
import 'package:onai_docs/src/features/auth/database/auth_dao.dart';
import 'package:onai_docs/src/features/auth/datasource/auth_remote_ds.dart';
import 'package:onai_docs/src/features/auth/repository/auth_repository.dart';

class AuthRepositoryImpl extends IAuthRepository {
  final IAuthRemoteDS _remoteDS;
  final IAuthDao _authDao;
  final NetworkExecuter _client;

  @override
  bool get isAuthenticated => _authDao.user.value != null;

  @override
  String? get user => _authDao.user.value;

  AuthRepositoryImpl({
    required IAuthRemoteDS remoteDS,
    required NetworkExecuter client,
    required AuthDao authDao,
  })  : _remoteDS = remoteDS,
        _authDao = authDao,
        _client = client;

  @override
  Future<Result<List<Object>>> login({
    required String login,
    required String password,
  }) async {
    final Result<List<Object>> result = await _remoteDS.login(
      login: login,
      password: password,
    );

    result.whenOrNull(
      success: (response) async {
        if (response.length >= 2) {
          final accessToken = response[0];
          final refreshToken = response[1];

          if (accessToken is String && refreshToken is String) {
            await _authDao.accessToken.setValue(accessToken);
            await _authDao.refreshToken.setValue(refreshToken);
          } else {
            throw Exception('Invalid token types received');
          }
        } else {
          throw Exception('Invalid response format');
        }
      },
    );

    return result;
  }

  @override
  Future<bool> clearUser() async {
    try {
      final bool userFlag = await _authDao.user.remove();
      final bool accessTokenFlag = await _authDao.accessToken.remove();
      final bool refreshTokenFlag = await _authDao.refreshToken.remove();

      return userFlag && accessTokenFlag && refreshTokenFlag;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<String> setUserForTest({
    required String user,
  }) async {
    await _authDao.user.setValue(user);
    return user;
  }
}
