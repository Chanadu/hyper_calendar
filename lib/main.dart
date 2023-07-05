import 'package:flutter/material.dart';
import 'package:hyper_calendar/mongo_db.dart';
import 'package:hyper_calendar/util/page_holder.dart';
import 'package:hyper_calendar/util/new_task_model.dart';
import 'package:provider/provider.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  MongoDB.start();

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
    primary: Color.fromRGBO(33, 150, 243, 1),
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
    bodyLarge: TextStyle(fontSize: 32.0),
    displayMedium: TextStyle(fontSize: 34.0),
    displaySmall: TextStyle(fontSize: 32.0),
    labelMedium: TextStyle(fontSize: 32.0),
    titleMedium: TextStyle(fontSize: 36.0),
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hyper Calendar',
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
      //home: const MainPage(),
      home: const PageHolder(),
    );
  }
}
