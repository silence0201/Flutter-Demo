import 'package:flutter/material.dart';
import 'package:flutter_shop/model/category_good_list.dart';

/// * Project Name:flutter_shop
/// * Package Name:provide
/// * File Name: category_goods_list.dart
/// * Date:2019-12-01 
/// * Copyright © 2019 silence. All Rights Reserved.
///

class CategoryGoodsList with ChangeNotifier {
  List<Good> goodList = [];

  // 点击更换列表
  setGoodsList(List<Good> list) {
    goodList = list;
    notifyListeners();
  }
}