import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:umart/product.dart';
//import 'package:http/http.dart';


class LiveShopping extends StatefulWidget {
  @override
  _LiveShoppingState createState() => new _LiveShoppingState();
}

class _LiveShoppingState extends State<LiveShopping> {

  String result = "No Items Added";

  List<Product> productList = new List();


  void _openQrScan() async {
    try {
      String data = await BarcodeScanner.scan();
      print("code = ${data}");
      fetchProduct(data);
    }
    on PlatformException catch (ex) {
      if (ex == BarcodeScanner.CameraAccessDenied) {
        setState(() {
          result = "Permission Denied";
        });
      } else {
        setState(() {
          result = "Unknow Error $ex";
        });
      }
    } on FormatException {
      setState(() {
        result = "Formart Eception";
      });
    }
    catch (ex) {
      setState(() {
        result = "Unknow Error $ex";
      });
    }
  }



  fetchProduct(String id) async {
    final response = await get(
        "https://sheetdb.io/api/v1/5be305749e8e2/search?id=${id}");

    if (response.statusCode == 200) {
//      setState(() {
//        productList.add(new Product.fromJson(json.decode(response.body)));

      print("Scan ${response.body}");
      var list = json.decode(response.body);
//
      List<Product> mList = new List();
      for (var i in list) {
        mList.add(new Product.fromJson(i));
      }


      setState(() {
        productList.addAll(mList);
      });

//      });

      //server returns ok
    } else {
      // If that response was not OK, throw an error.
      throw Exception('Failed to load post');
    }
  }

  void _openCart() {

  }


  @override
  Widget build(BuildContext context) {
    return new Scaffold(

        appBar: new AppBar(
          title: new Text("Scan Items To Cart"),
          actions: <Widget>[

            IconButton(
                onPressed: _openCart, icon: new Icon(Icons.add_shopping_cart))

          ],
        ),
        body: new Center(

          child: new Center(
              child: new ListView.builder(
                itemCount: productList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: new Text(productList[index].product_name),);
                },


              )


          ),


        ),

        floatingActionButton: new FloatingActionButton.extended(
            icon: Icon(Icons.photo_camera),
            label: new Text("scan item"),
            onPressed: _openQrScan


        )


    );
  }


}
