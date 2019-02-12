import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:umart/Items/Item_my_cart.dart';
import 'package:umart/Items/items_category.dart';
import 'package:umart/custom_fab.dart';
//import 'package:http/http.dart';

class LiveShopping extends StatefulWidget {
  @override
  _LiveShoppingState createState() => new _LiveShoppingState();
}

class _LiveShoppingState extends State<LiveShopping> {
  String result = "No Items Added";

  List<Items> productList = new List();

  void _openQrScan() async {
    try {
      String data = await BarcodeScanner.scan();
      print("code = ${data}");
      fetchProduct(data);
    } on PlatformException catch (ex) {
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
    } catch (ex) {
      setState(() {
        result = "Unknow Error $ex";
      });
    }
  }

  fetchProduct(String id) async {
    final response =
    await get("https://sheetdb.io/api/v1/5bed96c56fbd5/search?id=${id}");

    if (response.statusCode == 200) {
//      setState(() {
//        productList.add(new Product.fromJson(json.decode(response.body)));

      print("Scan ${response.body}");
      var list = json.decode(response.body);
//
      List<Items> mList = new List();
      for (var i in list) {
        //if(mList.elementAt(i).itemId != new Items.fromJson(i).itemId) {
        mList.add(new Items.fromJson(i));
        //}
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

  void _openCart() {}

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Center(
        child: new Center(
            child: new ListView.builder(
              itemCount: productList.length,
              itemBuilder: (context, index) {
                return new Card(
                  elevation: 5.0,
                  color: Colors.white,
                  margin: EdgeInsets.only(top: 4.0, right: 4.0, bottom: 4.0),
                  child: _cartItem(
                      productList[index].imageUrl,
                      productList[index].itemName,
                      null,
                      productList[index].priceTag.toString()),
                );
//                  return _cartItem(productList[index].imageUrl,
//                      productList[index].itemName,
//                      null,
//                      productList[index].priceTag.toString());
              },
            )),
      ),
      floatingActionButton: CustomFab(
        scanBarcodeCallback: _openQrScan,
      ),
    );
  }

  Widget _cartItem(String imageUrl, String itemName, IconData icon,
      String amount) {
    return new Container(
//      color: Colors.,
      child: new Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          new Container(
            //padding: EdgeInsets.all(8.0),
            height: 100.0,
            width: 110.0,
            decoration: new BoxDecoration(
                image: DecorationImage(
                    image: new NetworkImage(imageUrl), fit: BoxFit.cover)),
          ),
          new Expanded(
              child: new Container(
                  margin: EdgeInsets.only(left: 4.0, right: 4.0),
                  child: new Column(
                    //crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      _titleWidget(itemName, icon),
                      _amountWidget(amount)
                    ],
                  )))
        ],
      ),
    );
  }

  Widget _titleWidget(String itemName, IconData icon) {
    return new Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        new Text(
          itemName,
          style: new TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22.0,
              color: Colors.blueGrey),
        ),
      ],
    );
  }

  Widget _amountWidget(String amount) {
    return new Container(
      child: new Text(
        "₦" + amount,
        style: new TextStyle(
            fontWeight: FontWeight.w300,
            fontSize: 20.0,
            fontStyle: FontStyle.italic),
      ),
    );
  }
}
////  @override
////  Widget build(BuildContext context) {
////    return new Scaffold(
////
////      //appBar: new AppBar(title: new Text("Scan Items To Cart"),),
////      body: new Center(
////        child: new Text(result),
////
////      ),
////      floatingActionButton: CustomFab(scanBarcodeCallback: _openQrScan,),
//////      floatingActionButton: FloatingActionButton.extended(
//////        onPressed: _openQrScan,
////        icon: new Icon(Icons.add_shopping_cart),
////        label: new Text("Add to cart"),),
//
//
//    );
//  }
