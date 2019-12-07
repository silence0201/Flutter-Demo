import 'package:flutter/cupertino.dart';
/// * Project Name:flutter_shop
/// * Package Name:pages.cart_page
/// * File Name: cart_bottom.dart
/// * Date:2019-12-07 
/// * Copyright © 2019 silence. All Rights Reserved.

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CartBottom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5.0),
      color: Colors.white,
      child: Row(
        children: <Widget>[
          _selectedAllBtn(),
          _allPriceArea(),
          _goButton()
        ],
      ),
    );
  }

  Widget _selectedAllBtn() {
    return Container(
      child:Row(
        children: <Widget>[
          Checkbox(
            value: true,
            activeColor: Colors.pink,
            onChanged: (bool val) {},
          ),
          Text('全选')
        ],
      ),
    );
  }

  Widget _allPriceArea() {
    return Container(
      width: ScreenUtil().setWidth(430),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                alignment: Alignment.centerRight,
                width: ScreenUtil().setWidth(280),
                child: Text(
                  '合计:',
                  style: TextStyle(
                      fontSize: ScreenUtil().setSp(36)
                  ),
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                width: ScreenUtil().setWidth(150),
                child: Text(
                  '1565',
                  style: TextStyle(
                      fontSize: ScreenUtil().setSp(36),
                      color: Colors.red
                  ),
                ),
              )
            ],
          ),
          Container(
            width: ScreenUtil().setWidth(430),
            alignment: Alignment.centerRight,
            child: Text(
              '满10元免配送费,预购免配送费',
              style: TextStyle(
                color: Colors.black38,
                fontSize: ScreenUtil().setSp(22)
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _goButton() {
    return Container(
      width: ScreenUtil().setWidth(160),
      padding: EdgeInsets.only(left: 10),
      child: InkWell(
        onTap: () {},
        child: Container(
          padding: EdgeInsets.all(10.0),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(3.0),
          ),
          child: Text(
            '结算(6)',
            style: TextStyle(
              color: Colors.white
            ),
          ),
        ),
      ),
    );
  }
}
