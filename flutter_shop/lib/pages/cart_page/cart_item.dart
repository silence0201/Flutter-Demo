/// * Project Name:flutter_shop
/// * Package Name:pages.cart_page
/// * File Name: cart_item.dart
/// * Date:2019-12-06 
/// * Copyright © 2019 silence. All Rights Reserved.
///

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/model/cart_info.dart';
import 'package:flutter_shop/pages/cart_page/cart_count.dart';
import 'package:flutter_shop/provide/cart.dart';
import 'package:provide/provide.dart';

class CartItem extends StatelessWidget {

  final CartInfo item;


  CartItem(this.item);

  @override
  Widget build(BuildContext context) {
    print(item);

    return Container(
      margin: EdgeInsets.fromLTRB(5.0, 2.0, 5.0, 2.0),
      padding: EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 10.0),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 1,color: Colors.black12)
        )
      ),
      child: Row(
        children: <Widget>[
          _cartCheckBt(context),
          _cartInfo(),
          _cartName(),
          _cartPrice(context)
        ],
      ),
    );
  }

  // 勾选按钮
  Widget _cartCheckBt(context) {
    return Container(
      child: Checkbox(
        value: item.isCheck,
        activeColor: Colors.pink,
        onChanged: (bool val) {
          item.isCheck = val;
          Provide.value<Cart>(context).changeCheckState(item);
        },
      ),
    );
  }
  
  // 商品图片
  Widget _cartInfo() {
    return Container(
      width: ScreenUtil().setHeight(150),
      padding: EdgeInsets.all(3),
      decoration: BoxDecoration(
        border: Border.all(width: 1,color: Colors.black12)
      ),
      child: Image.network(item.image),
    );
  }

  // 商品名称
  Widget _cartName() {
    return Container(
      width: ScreenUtil().setWidth(300),
      padding: EdgeInsets.all(10),
      alignment: Alignment.topLeft,
      child: Column(
        children: <Widget>[
          Text(item.goodsName),
          CartCount(item)
        ],
      ),
    );
  }

  // 价格
  Widget _cartPrice(context) {
    return Container(
      width: ScreenUtil().setWidth(120),
      alignment: Alignment.centerRight,
      child: Column(
        children: <Widget>[
          Text('价格: ${item.price}'),
          Container(
            child: InkWell(
              onTap: () {
                Provide.value<Cart>(context).deleteOneGoods(item.goodsId);
              },
              child: Icon(
                Icons.delete_forever,
                color: Colors.red,
                size: 30,
              ),
            ),
          )
        ],
      ),
    );
  }
}
