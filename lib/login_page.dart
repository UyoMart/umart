import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:umart/auth.dart';


class LogInPage extends StatefulWidget {

  final BaseAuth auth;
  final VoidCallback signInCallBack;

  LogInPage({this.auth, this.signInCallBack});

  @override
  _LogInPageState createState() => new _LogInPageState();
}


enum FormType {
  login,
  register
}

class _LogInPageState extends State<LogInPage>
    with SingleTickerProviderStateMixin {

  String _email;
  String _password;

  final formKey = GlobalKey<FormState>();


  FormType _formType = FormType.login;

  AnimationController _iconAnimationController;
  Animation<double> _iconAnimation;

  bool validateInput() {
    final form = formKey.currentState;
//
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  void authenticateUser() async {
    if (validateInput()) {
      //authenticate with firebase
      try {
        String userId;
        if (_formType == FormType.login) {
          userId =
          await widget.auth.signInwithEmailAndPassword(_email, _password);
        } else {
          userId =
          await widget.auth.createUserwithEmailAndPassword(_email, _password);
        }

        widget.signInCallBack();

        print("fb $userId");
      } catch (e) {
        print("fb $e");
      }
    }
  }


  void goToRegister() {
    formKey.currentState.reset();
    setState(() {
      _formType = FormType.register;
    });
  }


  void goToLogIn() {
    formKey.currentState.reset();
    setState(() {
      _formType = FormType.login;
    });
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _iconAnimationController = new AnimationController(
        vsync: this,
        duration: new Duration(milliseconds: 500));
//
    _iconAnimation = new CurvedAnimation(
        parent: _iconAnimationController, curve: Curves.easeOut);
//
    _iconAnimation.addListener(() => this.setState(() {}));
    _iconAnimationController.forward();
  }


  @override
  Widget build(BuildContext context) {
    return new Scaffold(

//      appBar: new AppBar(
//        title: new Text("UMart"),
//      ),

      body: new Stack(
        fit: StackFit.expand,
        children: <Widget>[

          new Image(
            image: new AssetImage("assets/images/sup.jpg"),
            fit: BoxFit.cover,
            color: Colors.black54,
            colorBlendMode: BlendMode.darken,

          ),
          new Column(

            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[

              new FlutterLogo(
                size: _iconAnimation.value * 100,
              ),


              new Container(
                padding: EdgeInsets.only(top: 48.0, left: 24.0, right: 24.0),
                child: new Form(
                    key: formKey,
                    child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: buildTextInput() + buildSubmitButtons(),

                    )
                ),


              ),


            ],

          )


        ],

      ),

    );
  }


  List<Widget> buildTextInput() {
    return [
      new TextFormField(
        style: new TextStyle(color: Colors.white),
        decoration: new InputDecoration(
            labelText: "Email", fillColor: Colors.white),
        validator: (value) =>
        value.isEmpty
            ? "Email cannot be empty"
            : null,
        onSaved: (value) => _email = value,
      ),
      new TextFormField(
        style: new TextStyle(color: Colors.white),
        decoration: new InputDecoration(
            labelText: "Password", fillColor: Colors.white),
        obscureText: true,
        validator: (value) =>
        value.isEmpty
            ? "Password cannot be empty"
            : null,

        onSaved: (value) => _password = value,

      )

    ];
  }


  List<Widget> buildSubmitButtons() {
    if (_formType == FormType.login) {
      return [


        new RaisedButton(
          onPressed: authenticateUser,
          child: Text("Log In"),
          elevation: 8.0,
          shape: BeveledRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(7.0)),
          ),


        ),

        new FlatButton(onPressed: goToRegister,
            child: new Text(
              "Create an Account",
              style: new TextStyle(color: Colors.white),))

      ];
    } else {
      return [

        new RaisedButton(
          onPressed: authenticateUser,
          child: Text("Register Now"),
          elevation: 8.0,
          shape: BeveledRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(7.0)),
          ),


        ),

        new FlatButton(onPressed: goToLogIn,
            child: new Text("Already Registered, Log in now",
              style: new TextStyle(color: Colors.white),)
        )


      ];
    }
  }

}




