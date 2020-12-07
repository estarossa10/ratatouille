import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:ratatouille/loading/loading_screen.dart';
import 'package:ratatouille/login/login.dart';
import 'package:firebase_core/firebase_core.dart';
// import 'package:ratatouille/search_page/search.dart';

void main() async {
  await DotEnv().load('.env');
  runApp(Ratatouille());
}

class Ratatouille extends StatelessWidget {
  // This widget is the root of your application.

  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(
            title: 'Ratatouille',
            theme: ThemeData(
              primarySwatch: Colors.blue,
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            home: LoginPage(),
            debugShowCheckedModeBanner: false,
          );
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return MaterialApp(home: LoadingScreen(),);
      },
    );
  }
}