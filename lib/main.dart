import 'package:flutter/material.dart';
import 'package:hyper_calendar/pages/main_page.dart';
import 'package:hyper_calendar/util/create_task/new_task_model.dart';
import 'package:provider/provider.dart';

void main() async {
  runApp(
    ChangeNotifierProvider(
      create: (context) => NewTaskModel(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  final ColorScheme colorScheme = const ColorScheme(
    brightness: Brightness.dark,
    primary: Colors.blue,
    onPrimary: Colors.white,
    secondary: Colors.blueAccent,
    onSecondary: Colors.white,
    error: Colors.red,
    onError: Colors.white,
    background: Color(0xFF121212),
    onBackground: Colors.white,
    surface: Color(0xFF1d1d1d),
    onSurface: Colors.white,
    primaryContainer: Color(0xFF262626),
    surfaceVariant: Colors.white24, //used as disabled text
  );
  final TextTheme textTheme = const TextTheme(
    displayLarge: TextStyle(fontSize: 48.0, fontWeight: FontWeight.bold),
    titleLarge: TextStyle(fontSize: 36.0),
    bodyMedium: TextStyle(fontSize: 24.0),
    displayMedium: TextStyle(fontSize: 36.0),
    displaySmall: TextStyle(fontSize: 32.0),
    labelMedium: TextStyle(fontSize: 32.0),
    titleMedium: TextStyle(fontSize: 36.0),
  );
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hyper',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        fontFamily: 'Georgia',
        textTheme: textTheme,
        colorScheme: colorScheme,
        scaffoldBackgroundColor: colorScheme.background,
        appBarTheme: AppBarTheme(
          titleTextStyle: textTheme.displayLarge,
        ),
        dialogBackgroundColor: colorScheme.primaryContainer,
      ),
      home: const MainPage(),
    );
  }
}
