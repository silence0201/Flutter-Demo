import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_shop/provide/cart.dart';
import 'package:flutter_shop/provide/category_goods_list.dart';
import 'package:flutter_shop/provide/child_category.dart';
import 'package:flutter_shop/provide/current_index.dart';
import 'package:flutter_shop/provide/detail_info.dart';
import 'package:flutter_shop/router/routers.dart';
import 'package:provide/provide.dart';

import './pages/index_page.dart';


void main() {
  // 顶层注册状态管理
  var providers = registerProviders();

  runApp(ProviderNode(child: MyApp(),providers: providers,));
}

Providers registerProviders() {
  var childCategory = ChildCategory();
  var categoryGoodsList = CategoryGoodsList();
  var detailInfo = DetailsInfo();
  var cart = Cart();
  var currentIndex = CurrentIndex();

  var providers = Providers();

  providers
    ..provide(Provider<DetailsInfo>.value(detailInfo))
    ..provide(Provider<CategoryGoodsList>.value(categoryGoodsList))
    ..provide(Provider<Cart>.value(cart))
    ..provide(Provider<CurrentIndex>.value(currentIndex))
    ..provide(Provider<ChildCategory>.value(childCategory));

  return providers;
}

void initRouter() {
  // 路由
  final router = Router();
  Routes.configureRoutes(router);
  Application.router = router;
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    initRouter();

    return Container(
      child: MaterialApp(
        title: '电商项目',
        onGenerateRoute: Application.router.generator,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.pink
        ),
        home: IndexPage(),
      ),
    );
  }
}
