import 'package:flutter/material.dart';

//This method returns a BoxDecoration type that sets its gradient
// and its used as the homePage background
BoxDecoration boxDecoration() {
  return new BoxDecoration(
    image: new DecorationImage(image: new AssetImage("assets/images/sup.jpeg")),
  );
}
