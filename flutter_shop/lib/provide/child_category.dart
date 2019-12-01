import 'package:flutter/cupertino.dart';
import 'package:flutter_shop/model/category.dart';

/// * Project Name:flutter_shop
/// * Package Name:provide
/// * File Name: child_category.dart
/// * Date:2019-11-26 
/// * Copyright © 2019 silence. All Rights Reserved.

class ChildCategory with ChangeNotifier {
  List<BxMallSubDtoBean> chidCategoryList = [];
  int childIndex = 0; // 子类高亮索引

  String categoryId;
  String subId;

  setChildCategory(List<BxMallSubDtoBean> list, [String categoryId = '4']) {
    childIndex = 0;
    this.categoryId = categoryId;
    BxMallSubDtoBean all = BxMallSubDtoBean();
    all.mallCategoryId = categoryId;
    all.mallSubId = '';
    all.mallSubName = '全部';
    chidCategoryList = [all];
    chidCategoryList.addAll(list);
    notifyListeners();
  }

  // 改变子类索引
  changeChildIndex(index, [Id = '']) {
    childIndex = index;
    subId = Id;
    notifyListeners();
  }
}