import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_shop/provide/child_category.dart';
import 'package:provide/provide.dart';

import './pages/index_page.dart';


void main() {
  // 顶层注册状态管理
  var providers = registerProviders();
  runApp(ProviderNode(child: MyApp(),providers: providers,));
}

Providers registerProviders() {
  var childCategory = ChildCategory();
  var providers = Providers();

  providers
    ..provide(Provider<ChildCategory>.value(childCategory));

  return providers;
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: MaterialApp(
        title: '电商项目',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.pink
        ),
        home: IndexPage(),
      ),
    );
  }
}
