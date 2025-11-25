part of 'resources.dart';

mixin AppTheme {
  static ThemeData get light => ThemeData(
        fontFamily: "Nunito",
        useMaterial3: true,
        scaffoldBackgroundColor: AppColors.kGlobalBackground,
        splashFactory: NoSplash.splashFactory,
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        hoverColor: Colors.transparent,
        appBarTheme: const AppBarTheme(
          elevation: 0,
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: AppColors.kGlobalBackground,
            systemStatusBarContrastEnforced: true,
            statusBarIconBrightness: Brightness.dark,
            statusBarBrightness: Brightness.light,
          ),
        ),
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: {
            TargetPlatform.android: CupertinoPageTransitionsBuilder(),
            TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          },
        ),
      );

  static CupertinoThemeData get cupertinoLight => const CupertinoThemeData(
        brightness: Brightness.light,
        textTheme:
            CupertinoTextThemeData(textStyle: TextStyle(fontFamily: 'Nunito')),
        primaryColor: AppColors.kElementsSurface,
        scaffoldBackgroundColor: AppColors.kGlobalBackground,
      );
}

mixin AppDecorations {
  static const List<BoxShadow> dropShadow = [
    BoxShadow(
      blurRadius: 7,
      offset: Offset(0, -1),
      color: Color.fromRGBO(0, 0, 0, 0.15),
    ),
  ];

  static const List<BoxShadow> profileShadow = [
    BoxShadow(
      blurRadius: 7,
      color: Color.fromRGBO(0, 0, 0, 0.20),
    ),
  ];
}
