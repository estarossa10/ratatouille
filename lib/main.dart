import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:ratatouille/search_page/search.dart';

void main() async {
  await DotEnv().load('.env');
  runApp(Ratatouille());
}

class Ratatouille extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ratatouille',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SearchPage(title: 'Ratatouille'),
      debugShowCheckedModeBanner: false,
    );
  }
}