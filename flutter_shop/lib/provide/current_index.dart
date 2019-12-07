import 'package:flutter/cupertino.dart';

/// * Project Name:flutter_shop
/// * Package Name:provide
/// * File Name: current_index.dart
/// * Date:2019-12-07 
/// * Copyright © 2019 silence. All Rights Reserved.
///

class CurrentIndex with ChangeNotifier {
  int currentIndex = 0;

  changeIndex(int index) {
    currentIndex = index;
    notifyListeners();
  }
}