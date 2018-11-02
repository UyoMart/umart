import 'package:flutter/material.dart';


class LogInPage extends StatefulWidget {
  @override
  _LogInPageState createState() => new _LogInPageState();
}


class _LogInPageState extends State<LogInPage> {

  String _email;
  String _password;

  final formKey = GlobalKey<FormState>();

  void logInUser() {
    final form = formKey.currentState;
//
    if (form.validate()) {
      form.save();
      print("form is valid email: $_email password: $_password");
    } else
      print("form is invalid");
  }


  @override
  Widget build(BuildContext context) {
    return new Scaffold(

      appBar: new AppBar(
        title: new Text("UMart"),
      ),

      body: new Container(
        padding: EdgeInsets.all(16.0),
        child: new Form(
            key: formKey,
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                new TextFormField(
                  decoration: new InputDecoration(labelText: "Email"),
                  validator: (value) =>
                  value.isEmpty
                      ? "Email cannot be empty"
                      : null,
                  onSaved: (value)=>_email = value,
                ),
                new TextFormField(
                  decoration: new InputDecoration(labelText: "Password"),
                  obscureText: true,
                  validator: (value) =>
                  value.isEmpty
                      ? "Password cannot be empty"
                      : null,

                  onSaved: (value)=>_password = value,

                ),
                new RaisedButton(
                  onPressed: logInUser, child: new Text("Log In"),)

              ],

            )),
      ),

    );
  }

}




