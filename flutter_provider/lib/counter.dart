import 'package:flutter/material.dart';

/// * Project Name:flutter_provider
/// * Package Name:
/// * File Name: counter.dart
/// * Date:2019-11-26
/// * Copyright © 2019 silence. All Rights Reserved.

class Counter with ChangeNotifier {
  int value = 0;

  increment() {
    value++;
    notifyListeners();
  }
}