import 'package:brew_crew/screens/authenticate/register.dart';
import 'package:brew_crew/screens/authenticate/sign_in.dart';
import 'package:flutter/material.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {

  bool showSignIn = true;

  void toggleView() {
    setState(() =>
    showSignIn = !showSignIn); // toggle between register and sign in
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn == true) {
      return SignIn(
          toggleView: toggleView); // toggleView is prop name and its value is function toggleView
    }
    else {
      return Register(toggleView: toggleView);
    }
  }
}
