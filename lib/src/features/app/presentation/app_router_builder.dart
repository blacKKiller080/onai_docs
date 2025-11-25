import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:onai_docs/src/features/app/router/navigator_observers_factory.dart';

typedef CreateRouter = RootStackRouter Function(BuildContext context);
typedef RouterWidgetBuilder = Widget Function(
  BuildContext context,
  RouteInformationParser<UrlState> informationParser,
  RouterDelegate<UrlState> routerDelegate,
);

class AppRouterBuilder extends StatefulWidget {
  final CreateRouter createRouter;
  final RouterWidgetBuilder builder;

  const AppRouterBuilder({
    super.key,
    required this.createRouter,
    required this.builder,
  });

  @override
  State<AppRouterBuilder> createState() => _AppRouterBuilderState();
}

class _AppRouterBuilderState extends State<AppRouterBuilder> {
  late final RootStackRouter _router;
  late final RouteInformationParser<UrlState> _parser;
  late final RouterDelegate<UrlState> _delegate;

  @override
  void initState() {
    super.initState();
    _router = widget.createRouter(context);
    _parser = _router.defaultRouteParser();
    _delegate = _router.delegate(
      navigatorObservers: const NavigatorObserversFactory().call,
    );
  }

  @override
  void dispose() {
    _router.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.builder(
        context,
        _parser,
        _delegate,
      );
}
