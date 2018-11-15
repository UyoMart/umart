import 'package:flutter/material.dart';


class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => new _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {

  AnimationController _iconAnimationController;
  Animation<double> _iconAnimation;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _iconAnimationController = new AnimationController(
        vsync: this,
        duration: new Duration(milliseconds: 500));
//
    _iconAnimation = new CurvedAnimation(
        parent: _iconAnimationController, curve: Curves.bounceOut);
//
    _iconAnimation.addListener(() => this.setState(() {}));
    _iconAnimationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.white,
      body: new Stack(
        fit: StackFit.expand,
        children: <Widget>[
          new Image(
            image: new AssetImage("assets/images/shopp.jpg"),
            fit: BoxFit.cover,
            color: Colors.black54,
            colorBlendMode: BlendMode.darken,

          ),

          new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[

              new FlutterLogo(
                size: _iconAnimation.value *100,
              ),

//            new Text("UMart",
//              style: new TextStyle(
//                  color: Colors.white,fontStyle: FontStyle.italic
//
//
//              ),
//
//            )


              new RaisedButton(
                onPressed: () {}, child: new Text("Log in "),

              )


            ],


          )


        ],


      ),


    );
  }
}
