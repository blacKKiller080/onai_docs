import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onai_docs/src/core/database/drift/app_database.dart';
import 'package:onai_docs/src/core/model/dependencies_storage.dart';
import 'package:onai_docs/src/core/model/repository_storage.dart';
import 'package:onai_docs/src/core/utils/screen_util.dart';
import 'package:onai_docs/src/core/widget/dependencies_scope.dart';
import 'package:onai_docs/src/core/widget/repository_scope.dart';
import 'package:onai_docs/src/features/app/bloc/app_bloc.dart';
// ignore: depend_on_referenced_packages

import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

extension BuildContextX on BuildContext {
  // IEnvironmentStorage get environment => EnvironmentScope.of(this);
  IDependenciesStorage get dependencies => DependenciesScope.of(this);
  Dio get dio => dependencies.dio;
  AppDatabase get database => dependencies.database;
  SharedPreferences get sharedPreferences => dependencies.sharedPreferences;
  PackageInfo get packageInfo => dependencies.packageInfo;

  IRepositoryStorage get repository => RepositoryScope.of(this);

  MediaQueryData get mediaQuery => MediaQuery.of(this);
  Size get screenSize => mediaQuery.size;

  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => theme.textTheme;

  AppBLoC get appBloc => BlocProvider.of<AppBLoC>(this);

  // AppRoleBloc get appRoleBloc => BlocProvider.of<AppRoleBloc>(this);

  ScreenSize get deviceSize => ScreenUtil.screenSizeOf(this);
  // ScreenSize get deviceSizeOf => ScreenUtil.screenSizeOf(this);
  Orientation get orientation => ScreenUtil.orientation();
}

extension OrientationX on Orientation {
  T whenByValue<T extends Object?>({
    required T portrait,
    required T landscape,
  }) {
    switch (this) {
      case Orientation.portrait:
        return portrait;
      case Orientation.landscape:
        return landscape;
    }
  }

  T maybeWhenByValue<T extends Object?>({
    required T orElse,
    T? portrait,
    T? landscape,
  }) =>
      whenByValue<T>(
        portrait: portrait ?? orElse,
        landscape: landscape ?? orElse,
      );
}

extension ThemeDataX on ThemeData {
  // Usage '''
  //  context.theme.when(dark: () => AppDarkColors.main, light: () => AppLightColors.main,)
  // ''''
  T when<T>({
    required T Function() light,
    required T Function() dark,
  }) {
    switch (brightness) {
      case Brightness.light:
        return light();
      case Brightness.dark:
        return dark();
    }
  }

  T whenByValue<T extends Object?>({
    required T light,
    required T dark,
  }) {
    switch (brightness) {
      case Brightness.light:
        return light;
      case Brightness.dark:
        return dark;
    }
  }

  T maybeWhenByValue<T extends Object?>({
    required T orElse,
    T? light,
    T? dark,
  }) =>
      whenByValue<T>(
        light: light ?? orElse,
        dark: dark ?? orElse,
      );
}
