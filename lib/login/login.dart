import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget{
  @override
  _SearchFormState createState() => _SearchFormState();
}

class _SearchFormState extends State<LoginPage> {
  @override
  Widget build(context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Column(
          children: [
            Container(
              height: 400,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/background.png"),
                  fit: BoxFit.fill
                )
              ),
            )
          ],
        ),
      ),
    );
  }
}