import 'package:flutter/material.dart';
import 'package:umart/pages/CategoryDetailsPage.dart';

class CategoryItem extends StatefulWidget {
  final Items item;

  //final CategoriesPageState categoriesPage;

  CategoryItem(this.item);

  @override
  _CategoryItemState createState() => _CategoryItemState(item);
}

class _CategoryItemState extends State<CategoryItem> {
  final Items item;

  _CategoryItemState(this.item);

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      onTap: _onItemClicked,
      child: _itemsWidget(item),
    );
  }

  Widget _itemsWidget(Items item) {
    print(item.itemName + "  ************************************************");
    return new Card(
      elevation: 8.0,
      margin: EdgeInsets.only(bottom: 8.0, left: 6.0, right: 6.0),
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          new Expanded(
            child: new Container(
              //height: 80.0,
              decoration: new BoxDecoration(
                  image: new DecorationImage(
                      image: new NetworkImage(
                        item.imageUrl,
                      ),
                      fit: BoxFit.cover),
                  color: Colors.grey[400]),
            ),
          ),
          new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Container(
                margin: EdgeInsets.only(left: 4.0, right: 4.0),
                alignment: Alignment.centerLeft,
                //color: Colors.grey[400],
                child: new Text(
                  item.itemName,
                  maxLines: 1,
                  style: new TextStyle(
                      fontSize: 18.0,
                      color: Colors.black54,
                      fontWeight: FontWeight.bold),
                ),
              ),
              new Container(
                margin: EdgeInsets.only(left: 4.0, right: 4.0),
                alignment: Alignment.centerLeft,
                //  color: Colors.deepPurpleAccent[100],
                child: new Text(
                  "₦" + item.priceTag.toString(),
                  style: new TextStyle(fontSize: 18.0, color: Colors.black54),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  _onItemClicked() {
    Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (BuildContext) => CategoryDetailsPage(item, 5)));
  }
}

class Items {
  final String itemName;

  final String imageUrl;

  final int priceTag;

  final String itemId;

  final String itemDescrption;

  final String categoryType;

  Items._(
      {this.imageUrl,
      this.itemName,
      this.priceTag,
      this.itemId,
      this.itemDescrption,
      this.categoryType});

  factory Items.fromJson(Map<String, dynamic> json) {
    var price;
    if (json['price'] == null) {
      price = 200;
    } else {
      price = int.parse(json['price'].toString());
      assert(price is int);
      print(price.toString());
    }
//    print("PRICE ???????????>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> " + json['price']);
    return new Items._(
        imageUrl: json['image'] != null
            ? json['image']
            : "https://i.imgur.com/8XpQ6yP.jpg",
        itemName: json['name'],
        priceTag: price,
        itemId: json['id'],
        itemDescrption: json['description'] == null
            ? json['description']
            : "This is the product decription, as you can see, now get back",
        categoryType: json['category']);
  }
}
