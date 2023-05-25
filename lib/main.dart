import 'package:flutter/material.dart';

import 'pages/day_page.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  final MaterialColor swatch = Colors.green;
  final TextTheme textTheme = const TextTheme(
    displayLarge: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
    titleLarge: TextStyle(fontSize: 36.0),
    bodyMedium: TextStyle(fontSize: 20.0),
    bodySmall: TextStyle(fontSize: 14.0),
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
      home: const DayPage(title: "Saturday"),
    );
  }
}
