# onai_docs

A new Flutter project.

Flutter SDK - 3.35.5
Dart SDK - 3.9.2

Запуск проекта:
- flutter pub get
- flutter pub run build_runner build --delete-conflicting-outputs
- flutter run (or debug)

Архитектура: 
- MVVM 
Как видно в проекте разделен на разные слои, есть добавочные папки для помощи, но основная идея шаблона сохранена

Пакеты:
- shared_preferences: ^2.1.0 (очень лёгкий и быстрый инструмент)
- drift: ^2.7.0 (генерация кода, SQL-запросы с типизацией)
- flutter_bloc: ^8.1.3 (просто удобная)
- freezed_annotation: ^2.2.0 (генератор, меньше ручного кода)
- json_serializable: ^6.6.1 (помошник)
- json_annotation: ^4.8.0 (помошник)
- auto_route: ^10.0.1 (авто-генерация всех путей)
- flutter_inappwebview: ^6.1.5 (мощный плагин, нравиться больше основного WebView)
- build_runner: ^2.4.15 (мотор генерации)

Из основных могу отметить эти библиотеки и плагины

