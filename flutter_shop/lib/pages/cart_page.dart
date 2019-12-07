import 'package:flutter/material.dart';
import 'package:flutter_shop/model/cart_info.dart';
import 'package:flutter_shop/pages/cart_page/cart_bottom.dart';
import 'package:flutter_shop/pages/cart_page/cart_item.dart';
import 'package:flutter_shop/provide/cart.dart';
import 'package:provide/provide.dart';


class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('购物车'),
      ),
      body: FutureBuilder(
        future: _getCartInfo(context),
        builder: (context,snapshot){
          if (snapshot.hasData) {
            List<CartInfo> cartList = Provide.value<Cart>(context).cartInfos;
            return Stack(
              children: <Widget>[
                ListView.builder(
                  itemCount: cartList.length,
                  itemBuilder: (context,index){
                    return CartItem(cartList[index]);
                  },),
                Positioned(
                  bottom: 0,
                  left: 0,
                  child: CartBottom(),
                ),
              ],
            );
          } else {
            return Text('正在加载');
          }
        },
      ),
    );
  }

  Future<String> _getCartInfo(BuildContext context) async {
    await Provide.value<Cart>(context).getCartInfo();
    return 'end';
  }
}

