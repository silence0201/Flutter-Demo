import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// * Project Name:flutter_shop
/// * Package Name:pages
/// * File Name: details_page.dart
/// * Date:2019-12-01 
/// * Copyright © 2019 silence. All Rights Reserved.
///



class DetailsPage extends StatelessWidget {
  final String goodsId;

  DetailsPage(this.goodsId);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text('商品详情')
      ),
      body: Container(
        child: Center(
          child: Text('商品ID,${goodsId}'),
        ),
      ),
    );
  }
}
