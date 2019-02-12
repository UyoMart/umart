import 'dart:async';

import 'package:http/http.dart' as http;

class GetData {
  static var responseString = "";

  static getDataString() {}

  static final String BASE_URL = "https://sheetdb.io/api/v1/5bed96c56fbd5";
  static final String SEARCH_URL = "/search?name=";
  static final String CATEGORY_URL = "/search?category=";
  static final String SEARCH_CATEGORY_URL = "&name=";

  static Future<http.Response> getData(
      String searchText, String categoryType) async {
    var response;
    print("<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< CategoryType: " +
        categoryType +
        ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
    if (searchText != null &&
        (categoryType == null || categoryType == "Home")) {
      response = await http.get(
          Uri.encodeFull(BASE_URL + SEARCH_URL + searchText),
          headers: {"Accept": "application/json"});
      print(BASE_URL + SEARCH_URL + searchText);
    } else if ((searchText == null || searchText.isEmpty) &&
        (categoryType == null || categoryType == "Home")) {
      response = await http.get(Uri.encodeFull(BASE_URL),
          headers: {"Accept": "application/json"});
      print(BASE_URL);
    } else if (categoryType != null && searchText == null) {
      response = await http.get(
          Uri.encodeFull(BASE_URL + CATEGORY_URL + categoryType),
          headers: {"Accept": "application/json"});
      print(BASE_URL + CATEGORY_URL + categoryType);
    } else if (categoryType != null && searchText != null) {
      response = await http.get(
          Uri.encodeFull(BASE_URL +
              CATEGORY_URL +
              categoryType +
              SEARCH_CATEGORY_URL +
              searchText),
          headers: {"Accept": "application/json"});
      print(BASE_URL +
          CATEGORY_URL +
          categoryType +
          SEARCH_CATEGORY_URL +
          searchText);
    } else {
      response = await http.get(Uri.encodeFull(BASE_URL),
          headers: {"Accept": "application/json"});
    }
    return response;
//    responseString = response.body;
//    //return response.body;
  }
}
