import 'package:flutter/cupertino.dart';
import 'package:flutter_shop/model/cart_info.dart';
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

  List<CartInfo> cartInfos = [];

  double allPrice = 0;// 总价格
  int allCount = 0; // 总数量

  bool isAllCheck = true;

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
      Map<String, dynamic> newGoods = {
        'goodsId' : goodsId,
        'goodsName' : goodsName,
        'count' : count,
        'price' : price,
        'image' : image,
        'isCheck' : true
      };

      tmpLis.add(newGoods);

      cartInfos.add(CartInfo.fromMap(newGoods));
    }

    cartString = json.encode(tmpLis).toString();
    print(cartString);
    prefs.setString('cartInfo', cartString);
    notifyListeners();
  }

  remove() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove('cartInfo');
    cartInfos = [];
    print('清空完成') ;
    notifyListeners();
  }

  getCartInfo() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    cartString = preferences.getString('cartInfo');
    cartInfos = [];
    if (cartString != null) {
      List<Map> tmpList = (json.decode(cartString.toString()) as List).cast();
      allPrice = 0;
      allCount = 0;
      isAllCheck = true;
      tmpList.forEach((item){
        if (item['isCheck']) {
          allPrice += item['count'] * item['price'];
          allCount += item['count'];
        } else {
          isAllCheck = false;
        }
        cartInfos.add(CartInfo.fromMap(item));
      });
    }

    notifyListeners();
  }

  // 删除单个购物车商品
  deleteOneGoods(String goodsId) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    cartString = preferences.getString('cartInfo');
    List<Map> tmpList = ((json.decode(cartString.toString())) as List).cast();
    int tmpIndex = 0;
    int delIndex = 0;

    tmpList.forEach((item) {
      if (item['goodsId'] == goodsId) {
        delIndex = tmpIndex;
      }
      tmpIndex++ ;
    });

    tmpList.removeAt(delIndex) ;

    cartString = json.encode(tmpList).toString();
    preferences.setString('cartInfo', cartString);
    await getCartInfo();
  }

  changeCheckState(CartInfo cartItem) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    cartString = preferences.getString('cartInfo');
    List<Map> tmpList = ((json.decode(cartString.toString())) as List).cast();
    int tmpIndex = 0;
    int changeIndex = 0;
    tmpList.forEach((item){
      if (item['goodsId'] == cartItem.goodsId) {
        changeIndex = tmpIndex;
      }
      tmpIndex++;
    });

    tmpList[changeIndex] = cartItem.toJson();
    cartString = json.encode(tmpList).toString();
    preferences.setString('cartInfo', cartString);
    await getCartInfo();
  }

  // 点击全选按钮操作
  changeAllCheckBtnState(bool isCheck) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    cartString = preferences.getString('cartInfo');
    List<Map> tmpList = ((json.decode(cartString.toString())) as List).cast();
    List<Map> newList = [];
    for (var item in tmpList) {
      var newItem = item;
      newItem['isCheck'] = isCheck;
      newList.add(newItem);
    }

    cartString = json.encode(newList).toString();
    preferences.setString('cartInfo', cartString);

    getCartInfo();
  }

  // 商品数量加减
  addOrReduceAction(CartInfo cartItem, String todo) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    cartString = preferences.getString('cartInfo');
    List<Map> tmpList = ((json.decode(cartString.toString())) as List).cast();
    int tmpIndex = 0;
    int changeIndex = 0;
    tmpList.forEach((item){
      if (item['goodsId'] == cartItem.goodsId) {
        changeIndex = tmpIndex;
      }
      tmpIndex++;
    });

    if (todo == 'add') {
      cartItem.count++;
    } else if (cartItem.count > 1){
      cartItem.count--;
    }

    tmpList[changeIndex] = cartItem.toJson();
    cartString = json.encode(tmpList).toString();
    preferences.setString('cartInfo', cartString);

    await getCartInfo();
  }
}