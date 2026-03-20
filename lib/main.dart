import 'package:flutter/material.dart';
import 'theme/app_theme.dart';
import 'pages/showcase_page.dart';

enum AppThemeMode { light, dark, warm, cool }

void main() => runApp(const App());

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => AppState();

  static AppState of(BuildContext context) =>
      context.findAncestorStateOfType<AppState>()!;
}

class AppState extends State<App> {
  AppThemeMode _mode = AppThemeMode.light;

  AppThemeMode get themeMode => _mode;

  void setTheme(AppThemeMode mode) =>
      setState(() => _mode = mode);

  ThemeData get _themeData => switch (_mode) {
    AppThemeMode.light => AppTheme.light,
    AppThemeMode.dark  => AppTheme.dark,
    AppThemeMode.warm  => AppTheme.warm,
    AppThemeMode.cool  => AppTheme.cool,
  };

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: _themeData,
        home: const ShowcasePage(),
      );
}
