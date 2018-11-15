import 'dart:convert';

class Product {

  final String id;
  final String product_name;

  Product({this.id, this.product_name});


  factory Product.fromJson(Map<String, dynamic> json){
    return Product(
        id: json["id"],
        product_name: json["product_name"]

    );
  }


}