import 'package:flutter/material.dart';
import 'package:onai_docs/src/core/extension/src/build_context.dart';
import 'package:onai_docs/src/core/model/dependencies_storage.dart';
import 'package:onai_docs/src/core/model/repository_storage.dart';
import 'package:onai_docs/src/core/widget/dependencies_scope.dart';
import 'package:onai_docs/src/core/widget/repository_scope.dart';
import 'package:onai_docs/src/features/app/presentation/app_configuration.dart';
import 'package:onai_docs/src/features/settings/widget/scope/settings_scope.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnaiDocs extends StatelessWidget {
  final SharedPreferences sharedPreferences;
  final PackageInfo packageInfo;
  const OnaiDocs({
    super.key,
    required this.sharedPreferences,
    required this.packageInfo,
  });

  @override
  Widget build(BuildContext context) => DependenciesScope(
        create: (context) => DependenciesStorage(
          databaseName: 'onai_docs.db',
          sharedPreferences: sharedPreferences,
          packageInfo: packageInfo,
        ),
        child: RepositoryScope(
          create: (context) => RepositoryStorage(
            appDatabase: DependenciesScope.of(context).database,
            sharedPreferences: sharedPreferences,
            networkExecuter: DependenciesScope.of(context).networkExecuter,
          ),
          child: MediaQuery(
            data: MediaQuery.of(context)
                .copyWith(textScaler: TextScaler.noScaling),
            child: const SettingsScope(child: AppConfiguration()),
          ),
        ),
      );
}
