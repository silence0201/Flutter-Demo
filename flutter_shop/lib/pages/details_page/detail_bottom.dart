/// * Project Name:flutter_shop
/// * Package Name:pages.details_page
/// * File Name: detail_bottom.dart
/// * Date:2019-12-05 
/// * Copyright © 2019 silence. All Rights Reserved.
///

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailsBottom extends StatelessWidget   {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(750),
      color: Colors.white,
      height: ScreenUtil().setHeight(80),
      child: Row(
        children: <Widget>[
          InkWell(
            onTap: () {},
            child: Container(
              width: ScreenUtil().setWidth(110),
              alignment: Alignment.center,
              child: Icon(
                Icons.shopping_cart,
                size: 28,
                color: Colors.red,
              ),
            ),
          ),
          InkWell(
            onTap: () {},
            child: Container(
                width: ScreenUtil().setWidth(320),
                alignment: Alignment.center,
                color: Colors.green,
                child: Text(
                  '加入购物车',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: ScreenUtil().setSp(28),
                  ),
                )
            ),
          ),
          InkWell(
            onTap: () {},
            child: Container(
                width: ScreenUtil().setWidth(320),
                color: Colors.red,
                alignment: Alignment.center,
                child: Text(
                  '立即购买',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: ScreenUtil().setSp(28),
                  ),
                )
            ),
          ),
        ],
      ),
    );
  }
}
