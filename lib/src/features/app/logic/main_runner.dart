// ignore_for_file: avoid-ignoring-return-values, unused_import
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

typedef AsyncDependencies<D> = Future<D> Function();

typedef AppBuilder<D> = Widget Function(D dependencies);

mixin MainRunner {
  static Future<Widget> _initApp<D>(
      AsyncDependencies<D> asyncDependencies, AppBuilder<D> app) async {
    final dependencies = await asyncDependencies();

    return app(dependencies);
  }

  static Future<void> run<D>({
    required AsyncDependencies<D> asyncDependencies,
    required AppBuilder<D> appBuilder,
  }) async {
    ///
    WidgetsFlutterBinding.ensureInitialized();
    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    final app = await _initApp(asyncDependencies, appBuilder);
    // await PlatformViewsService.synchronizeToNativeViewHierarchy(false);
    // debugRepaintRainbowEnabled = true;
    PlatformInAppWebViewController.debugLoggingSettings.excludeFilter.addAll([
      RegExp("onUpdateVisitedHistory"),
      RegExp("onReceivedError"),
      RegExp("onReceivedHttpError"),
      RegExp("onReceivedRedirect"),
      RegExp("onReceivedLoginRequest"),
      RegExp("onReceivedResponse"),
      RegExp("onLoadStop"),
      RegExp("onProgressChanged"),
      RegExp("onPageCommitVisible"),
      RegExp("onTitleChanged"),
      RegExp("onContentSizeChanged"),
      RegExp("shouldOverrideUrlLoading"),
      RegExp("onReceivedServerTrustAuthRequest"),
      RegExp("onWebViewCreated"),
      RegExp("onLoadStart"),
      RegExp("onZoomScaleChanged"),
    ]);
    runApp(app);

    ///
    // runZonedGuarded<void>(
    //   () => Logger.runLogging(
    //     () async {
    //       WidgetsFlutterBinding.ensureInitialized();

    //       SystemChrome.setSystemUIOverlayStyle(
    //         SystemUiOverlayStyle.dark,
    //       );

    //       /// Firebase Init
    //       // await Firebase.initializeApp();

    //       // await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(kReleaseMode);

    //       FlutterError.onError = Logger.logFlutterError;

    //       // if (kReleaseMode) {
    //       //   await Sentry.init(
    //       //     (p) => {
    //       //       p.dsn = kSentryDsn,
    //       //       p.tracesSampleRate = 1,
    //       //     },
    //       //   );
    //       // }

    //       final app = await _initApp(asyncDependencies, appBuilder);

    //       /// Все ошибки BLoC'ов перенаправляются в Observer
    //       // Bloc.observer = AppBlocObserver();

    //       /// Добавляется чтобы избежать несколько одновременных ивентов
    //       Bloc.transformer = bloc_concurrency.sequential<Object?>();

    //       runApp(app);

    //       // /// Запуск приложения
    //       // BlocOverrides.runZoned(
    //       //   () => runApp(app),

    //       //   /// Все ошибки BLoC'ов перенаправляются в Observer
    //       //   blocObserver: AppBlocObserver(),

    //       //   /// Добавляется чтобы избежать несколько одновременных ивентов
    //       //   eventTransformer: bloc_concurrency.sequential<Object?>(),
    //       // );
    //     },
    //   ),
    //   Logger.logZoneError,
    // );
  }
}
