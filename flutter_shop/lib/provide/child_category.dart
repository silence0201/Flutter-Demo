import 'package:flutter/cupertino.dart';
import 'package:flutter_shop/model/category.dart';

/// * Project Name:flutter_shop
/// * Package Name:provide
/// * File Name: child_category.dart
/// * Date:2019-11-26 
/// * Copyright © 2019 silence. All Rights Reserved.

class ChildCategory with ChangeNotifier {
  List<BxMallSubDtoBean> chidCategoryList = [];

  setChildCategory(List list) {
    chidCategoryList = list;
    notifyListeners();
  }
}