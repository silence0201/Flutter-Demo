import 'dart:convert';

import 'package:dio/dio.dart';
/// * Project Name:flutter_shop
/// * Package Name:provide
/// * File Name: detail_info.dart
/// * Date:2019-12-01 
/// * Copyright © 2019 silence. All Rights Reserved.
///

import 'package:flutter/material.dart';
import 'package:flutter_shop/model/details.dart';
import 'package:flutter_shop/service/service_method.dart';

class DetailsInfo with ChangeNotifier {
  DetailsModel goodsInfo = null;

  bool isLeft = true;
  bool isRight = false;

  changeLeftAndRight(String changeState) {
    if (changeState == 'left') {
      isLeft = true;
      isRight = false;
    } else {
      isLeft = false;
      isRight = true;
    }
    notifyListeners();
  }

  getGoodsInfo(String id) async {
    var formate = {'goodId' : id};
    request('getGoodDetailById',formData: formate).then((value){
      var responseData = json.decode(value.toString());
      goodsInfo = DetailsModel.fromJson(responseData);
//      print(responseData);
      notifyListeners();
    });
  }
}