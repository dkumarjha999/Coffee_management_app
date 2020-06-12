import 'package:brew_crew/services/auth.dart';
import 'package:brew_crew/shared/constant.dart';
import 'package:brew_crew/shared/loading.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  final Function
      toggleView; // toggle function to toggle between register and sign in
  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formkey = GlobalKey<FormState>();
  bool loading = false;

  // text field state
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()    // for loading page we used here loading option
        : Scaffold(
            backgroundColor: Colors.brown[100],
            appBar: AppBar(
              backgroundColor: Colors.brown[400],
              elevation: 0.0,
              title: Text("Sign In"),
              actions: <Widget>[
                FlatButton.icon(
                  icon: Icon(Icons.person),
                  label: Text("Register"),
                  onPressed: () async {
                    widget
                        .toggleView(); // here toggle view is widget so we have not used this.toggleView
                  },
                )
              ],
            ),
            body: ListView(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
                  child: Form(
                    key: _formkey,
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
                          obscureText: true,
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
                            "Sign In",
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
                              dynamic result = await _auth
                                  .signInwithEmailAndPass(email, password);
                              if (result == null) {
                                setState(() {
                                  error =
                                      'please check your Email and Password';
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

/*
 // anonymous form for guest user

 Container(
        padding: EdgeInsets.symmetric(vertical: 20,horizontal: 50),
        child:RaisedButton(
          child: Text("Sign In Anon"),
          onPressed: ()async{
           dynamic result= await _auth.signInAnon();
           if(result==null){
             print("Error Sign In");
           }
           else{    // if no user found
             print("Signed in");
             print(result.uid);
           }

          },
        ),

     ),
 */
