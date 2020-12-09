import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ratatouille/controller/user_controller.dart';
import 'package:ratatouille/models/users.dart';

class LoginPage extends StatefulWidget{
  @override
  _SearchFormState createState() => _SearchFormState();
}

class _SearchFormState extends State<LoginPage> {

  String _email, _password;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  @override
  Widget build(context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                width: size.width,
                height: size.height,
                decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/background.png'),
                      fit: BoxFit.fitWidth,
                    )
                ),
              ),
              Container(
                width: size.width,
                height: size.height,
                alignment: Alignment.bottomCenter,
                child: Form(
                  key: _formkey,
                  child: Container(
                    alignment: Alignment.bottomCenter,
                    width: size.width * 0.8,
                    height: size.height,
                    padding: EdgeInsets.all(5),
                    child: Padding(
                      padding: EdgeInsets.only(top: size.height * 0.55, bottom: 5.0),
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(color: Colors.red)
                                )
                            ),
                            child: TextFormField(
                              onSaved: (input) {_email = input;},
                              style: TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Email',
                                  hintStyle: TextStyle(color: Colors.white)
                              ),
                              validator: (input) {
                                if(input.isEmpty) return 'Please provide an email';
                                // if(!input.contains(RegExp(r'@'))) return 'Please provide an email';
                                return null;
                              },
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(color: Colors.red)
                                )
                            ),
                            child: TextFormField(
                              onSaved: (input) {_password = input;},
                              style: TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Password',
                                  hintStyle: TextStyle(color: Colors.white)
                              ),
                              obscureText: true,
                            ),
                          )
                        ],
                      )
                    )
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(5),
                child: Container(
                  width: size.width,
                  child: Padding(
                    padding: EdgeInsets.only(top: size.height * 0.80),
                    child: Column(
                      children: [
                        Container(
                          width: size.width * 0.8,
                          child: RawMaterialButton(
                            onPressed: () {logIn();},
                            fillColor:  Colors.red,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(15),
                              child: Text(
                                'LOGIN',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  )
                )
              ),
              Container(
                width: size.width,
                height: size.height,
                child: Padding(
                  padding: EdgeInsets.only(top: size.height * 0.95, left: size.width * 0.025),
                  child: RichText(
                    text: TextSpan(
                      text: "Don't Have an Account?",
                      style: TextStyle(color: Colors.white, fontSize: 15),
                      recognizer: TapGestureRecognizer() //TODO ke register
                        ..onTap = () {}
                    ),
                  )
                ),
              ),
              Container(
                width: size.width,
                height: size.height,
                child: Padding(
                    padding: EdgeInsets.only(top: size.height * 0.95, left: size.width * 0.68),
                    child: RichText(
                      text: TextSpan(
                          text: "Login with Google",
                          style: TextStyle(color: Colors.white, fontSize: 15),
                          recognizer: TapGestureRecognizer() //TODO login google
                            ..onTap = () {}
                      ),
                    )
                ),
              )
            ],
          )
        ),
      ),
    );
  }

  Future<void> logIn() async {
    final formState = _formkey.currentState;
    formState.save();

    if(formState.validate()) {
      try {
        UserController.login(_email, _password);
        // print(_email);
      } on Exception catch (e) {
        print(e.toString());
      }
    }
  }
}