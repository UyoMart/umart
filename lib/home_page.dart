import 'dart:async';

import 'package:flutter/material.dart';
import 'package:umart/auth.dart';
import 'package:umart/live_shopping_scan_page.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';

class HomePage extends StatefulWidget {

  //TODO: Hey! start implementing your Home Features Here!

  BaseAuth auth;
  VoidCallback callBackSignOut;

  HomePage({this.auth, this.callBackSignOut});


  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {


//  StreamSubscription<DocumentSnapshot> subscription;

  String id;

  @override
  void initState() {
    super.initState();

    widget.auth.getUserId().then((onValue) {
      setState(() {
        id = onValue;
      });
    });


//    subscription = Firestore.
//    instance
//        .
//    document("users/${id}").snapshots().listen((onData) {
//
//      if(onData.exists){
//        // do  something
//
//      }
//
//    });


  }

  void logOut() async {
    widget.auth.logUserOut();
    widget.callBackSignOut();
  }

  void openScanScreen() {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => LiveShopping()

        )
    );
  }

  createUser() {
    Map<String, dynamic> user
    = <String, dynamic>{
      "user": "enyason", "cart_count": 9};

//    Firestore.instance.document("users/${id}").setData(user);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: new Text("UMart"),),
      body: new Container(
        child: new Center(
            child: new Column(
              children: <Widget>[
                new Text("Welcome $id"),
                new RaisedButton(
                  onPressed: createUser, child: new Text("create new user"),),
                new RaisedButton(onPressed: logOut, child: new Text("Log Out"),)
              ],
            )
        ),

      ),

    );
  }
}
