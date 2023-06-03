import 'package:flutter/material.dart';
import 'package:hyper_calendar/util/create_task/new_task_model.dart';
import 'package:provider/provider.dart';
import 'pages/create_new_task.dart';

void main() async {
  // await ref.set({
  //   "test 1": 1,
  //   "test 2": "ASFS",
  //   "test 3": {
  //     "A": true,
  //   },
  // });

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
  );
  final TextTheme textTheme = const TextTheme(
    displayLarge: TextStyle(fontSize: 48.0, fontWeight: FontWeight.bold),
    titleLarge: TextStyle(fontSize: 36.0),
    bodyMedium: TextStyle(fontSize: 26.0),
    displayMedium: TextStyle(
      fontSize: 36.0,
    ),
    displaySmall: TextStyle(
      fontSize: 32.0,
      decoration: TextDecoration.underline,
    ),
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
      ),
      home: const CreateNewTask(),
    );
  }
}
