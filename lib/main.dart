import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'pages/create_new_task.dart';
import 'firebase_options.dart';

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  final MaterialColor swatch = Colors.blue;
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
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: swatch,
        fontFamily: 'Georgia',
        textTheme: textTheme,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: swatch,
        fontFamily: 'Georgia',
        textTheme: textTheme,
      ),
      home: const CreateNewTask(),
    );
  }
}
