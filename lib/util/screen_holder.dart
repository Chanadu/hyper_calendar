import 'package:flutter/material.dart';
import 'package:hyper_calendar/pages/loading_screen.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;

import '../mongo_db.dart';
import '../pages/main_page.dart';

class ScreenHolder extends StatefulWidget {
  const ScreenHolder({super.key});

  @override
  State<ScreenHolder> createState() => _ScreenHolderState();
}

class _ScreenHolderState extends State<ScreenHolder> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<mongo.Db>(
      future: MongoDB.db,
      builder: (BuildContext context, AsyncSnapshot<mongo.Db> snapshot) {
        if (!snapshot.hasData) {
          return const LoadingScreen();
        } else {
          return const MainPage();
          // return const LoadingScreen();
        }
      },
    );
  }
}
