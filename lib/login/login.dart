import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget{
  @override
  _SearchFormState createState() => _SearchFormState();
}

class _SearchFormState extends State<LoginPage> {
  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
    );
  }
}