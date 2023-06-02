import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'pages/create_new_task.dart';
import 'sensitive-info/firebase_options.dart';

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
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
    displayLarge: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
    titleLarge: TextStyle(fontSize: 36.0),
    bodyMedium: TextStyle(fontSize: 25.0),
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
      ),
      home: const CreateNewTask(),
    );
  }
}
