import 'package:flutter/material.dart';
import 'package:onai_docs/src/core/resources/resources.dart';
import 'package:onai_docs/src/features/app/presentation/app_router_builder.dart';
import 'package:onai_docs/src/features/app/router/app_router.dart';
import 'package:onai_docs/src/features/settings/widget/scope/settings_scope.dart';

class AppConfiguration extends StatelessWidget {
  const AppConfiguration({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final locale = SettingsScope.localeOf(context, listen: true);
    final appRouter = AppRouter();

    return AppRouterBuilder(
      createRouter: (context) => appRouter,
      builder: (context, parser, delegate) => MaterialApp.router(
        routerConfig: appRouter.config(),
        //  routeInformationParser: parser, //conflict with config
        // routerDelegate: delegate, //conflict with config

        debugShowCheckedModeBanner: false,
        theme: AppTheme.light,
        locale: locale,
      ),
    );
  }
}
