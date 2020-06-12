import 'package:brew_crew/services/auth.dart';
import 'package:brew_crew/shared/constant.dart';
import 'package:brew_crew/shared/loading.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  final Function toggleView;

  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formkey = GlobalKey<FormState>(); // for form validation
  bool loading = false;

  // text field state
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.brown[100],
            appBar: AppBar(
              backgroundColor: Colors.brown[400],
              elevation: 0.0,
              title: Text("Register"),
              actions: <Widget>[
                FlatButton.icon(
                  icon: Icon(Icons.person),
                  label: Text("SignIn"),
                  onPressed: () async {
                    widget
                        .toggleView(); // here toggle view is widget so we have not used this.toggleView
                  },
                )
              ],
            ),
            body: ListView(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
              children: <Widget>[
                Container(
                  child: Form(
                    key: _formkey, // to keep track of form values
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 20.0,
                        ),
                        TextFormField(
                          decoration:
                              textInputDecoration.copyWith(hintText: 'Email'),
                          validator: (val) =>
                              val.isEmpty ? 'Enter an Email' : null,
                          onChanged: (val) {
                            setState(() {
                              email = val;
                            });
                          },
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        TextFormField(
                          decoration: textInputDecoration.copyWith(
                              hintText: 'Password'),
                          obscureText:
                              true, // for giving password as hidden value
                          validator: (val) => val.length < 6
                              ? 'Enter a password 6+ char long'
                              : null,
                          onChanged: (val) {
                            setState(() {
                              password = val;
                            });
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        RaisedButton(
                          color: Colors.pink[400],
                          child: Text(
                            "Register",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          onPressed: () async {
                            if (_formkey.currentState.validate()) {
                              setState(() {
                                loading = true;
                              });
                              // this will check validation of form
                              dynamic result = await _auth.regwithEmailAndPass(
                                  email, password);
                              if (result == null) {
                                setState(() {
                                  error =
                                      'please check your Email / this email already exist';
                                  loading = false;
                                });
                              }
                            }
                          },
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        // if we get the error baseed on email from firebase then it give error if user is not created due to wrong email validation
                        Text(
                          error,
                          style: TextStyle(color: Colors.red, fontSize: 15),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
  }
}
