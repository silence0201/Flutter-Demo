import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/pages/details_page/detail_bottom.dart';
import 'package:flutter_shop/pages/details_page/detail_explain.dart';
import 'package:flutter_shop/pages/details_page/detail_tabbar.dart';
import 'package:flutter_shop/pages/details_page/detail_top_area.dart';
import 'package:flutter_shop/pages/details_page/detail_web.dart';
import 'package:flutter_shop/provide/detail_info.dart';
import 'package:provide/provide.dart';

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
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: (){Navigator.pop(context);} ,
        ),
        title:Text('商品详情')
      ),
      body: FutureBuilder(
        future: _getBackInfo(context),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return SafeArea(
              bottom: true,
              left: true,
              child: Stack(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(bottom: ScreenUtil().setHeight(80)),
                    child: ListView(
                      children: <Widget>[
                        DetailsTopArea(),
                        DetailExplain(),
                        DetailsTabBar(),
                        DetailWeb(),
                        Text('商品ID${goodsId}'),
                      ],
                    ),
                  ),

                  Positioned(
                    bottom: 0,
                    left: 0,
                    child: DetailsBottom(),
                  )
                ],
              ),
            );
          } else {
            return Text('加载中....');
          }
        },
      ),
    );
  }
  
  Future _getBackInfo(BuildContext context) async {
    await Provide.value<DetailsInfo>(context).getGoodsInfo(goodsId);
    return '完成加载...';
  }
}
