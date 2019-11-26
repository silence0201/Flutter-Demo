import 'package:scoped_model/scoped_model.dart';

/// * Project Name:scoped_demo
/// * Package Name:Model
/// * File Name: count_model.dart
/// * Date:2019-11-26 
/// * Copyright © 2019 silence. All Rights Reserved.
///

class CountModel extends Model {
  int _count = 0;

  int get count => _count;

  void increment() {
    _count++;
    notifyListeners();
  }

  static CountModel of(context) => ScopedModel.of<CountModel>(context);

}