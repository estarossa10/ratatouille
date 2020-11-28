import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
          child: Column(
            children: [
              Container(
                width: size.width,
                height: size.height * 0.35,
                decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/background.png"),
                      // fit: BoxFit.fill
                    )
                ),
              ),
              Padding(
                padding: EdgeInsets.all(30),
                child: Column(
                  children: [
                    Form(
                      key: _formkey,
                      child: Container(
                        width: size.width * 0.8,
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Colors.white,
                        ),
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
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Email',
                                    hintStyle: TextStyle(color: Colors.grey)
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
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Password',
                                    hintStyle: TextStyle(color: Colors.grey)
                                ),
                                obscureText: true,
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(5),
                child: Column(
                  children: [
                    Container(
                      width: size.width,
                      decoration: BoxDecoration(
                        color: Colors.white,
                      ),
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
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 25),
                            width: size.width * 0.8,
                            child: RawMaterialButton(
                              onPressed: () {/*TODO go to register page*/ },
                              fillColor:  Colors.red,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(15),
                                child: Text(
                                  'REGISTER',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
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

    if(formState.validate()){
      formState.save();
      try{
        User user = (await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email, password: _password)) as User;
        print(user.email);
        //TODO go to search page
      }catch(e){
        print(e.message);
      }
    }
  }

}