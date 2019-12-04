/// * Project Name:flutter_shop
/// * Package Name:pages.details_page
/// * File Name: detail_top_area.dart
/// * Date:2019-12-04 
/// * Copyright © 2019 silence. All Rights Reserved.
///

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/provide/detail_info.dart';
import 'package:provide/provide.dart';

class DetailsTopArea extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provide<DetailsInfo>(
      builder: (context,child,val) {
        var goodsInfo = val.goodsInfo.data.goodInfo;
        if (goodsInfo != null) {
          return Container(
            color: Colors.white,
            child: Column(
              children: <Widget>[
                _goodsImage(goodsInfo.image1),
                _goodsName(goodsInfo.goodsName),
                _goodsNum((goodsInfo.goodsSerialNumber))
              ],
            ),
          );
        } else {
          return Text('正在加载中');
        }
      },
    );
  }

  // 商品图片
  Widget _goodsImage(url) {
    return Image.network(
      url,
      width: ScreenUtil().setWidth(740),
    );
  }

  // 商品名称
  Widget _goodsName(name) {
      return Container(
        width: ScreenUtil().setWidth(740),
        padding: EdgeInsets.only(left: 15.0),
        child: Text(
          name,
          style: TextStyle(
            fontSize: ScreenUtil().setSp(30)
          ),
        ),
      );
  }

  // 商品编号
  Widget _goodsNum(num) {
    return Container(
      width: ScreenUtil().setWidth(730),
      padding: EdgeInsets.only(left: 15.0),
      margin: EdgeInsets.only(top: 8),
      child: Text(
        '编号${num}',
        style: TextStyle(
          color: Colors.black12
        ),
      ),
    );
  }




}
