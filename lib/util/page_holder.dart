import 'package:flutter/material.dart';
import 'package:hyper_calendar/pages/loading_page.dart';
import 'package:hyper_calendar/pages/sign_in_page.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;

import '../mongo_db.dart';
import '../pages/main_page.dart';

class PageHolder extends StatefulWidget {
  const PageHolder({super.key});

  @override
  State<PageHolder> createState() => _PageHolderState();
}

class _PageHolderState extends State<PageHolder> {
  bool signedIn = false;

  void setSignedIn(bool signedIn) {
    setState(
      () {
        this.signedIn = signedIn;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<mongo.Db>(
      future: MongoDB.db,
      builder: (BuildContext context, AsyncSnapshot<mongo.Db> snapshot) {
        if (!snapshot.hasData) {
          return const LoadingPage();
        } else {
          return signedIn
              ? const MainPage()
              : SignInPage(
                  setSignIn: (p0) => setSignedIn(p0),
                );
        }
      },
    );
  }
}
