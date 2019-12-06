import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

/// * Project Name:flutter_shop
/// * Package Name:provide
/// * File Name: cart.dart
/// * Date:2019-12-06 
/// * Copyright © 2019 silence. All Rights Reserved.
///

class Cart with ChangeNotifier {
  String cartString = "[]";

  save(goodsId,goodsName,count,price,image) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString = prefs.getString('cartInfo');
    var tmp = cartString == null ? [] : json.decode(cartString.toString());
    List<Map> tmpLis = (tmp as List).cast();
    bool isHave = false;
    int ival = 0;
    tmpLis.forEach((item) {
      if(item['goodsId'] == goodsId) {
        tmpLis[ival]['count'] = item['count'] + 1;
        isHave = true;
      }
      ival++;
    });

    if (!isHave) {
      tmpLis.add({
        'goodsId' : goodsId,
        'goodsName' : goodsName,
        'count' : count,
        'price' : price,
        'image' : image
      });
    }

    cartString = json.encode(tmpLis).toString();
    print(cartString);
    prefs.setString('cartInfo', cartString);
    notifyListeners();
  }

  remove() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove('cartInfo');
    print('清空完成') ;
    notifyListeners();
  }
}