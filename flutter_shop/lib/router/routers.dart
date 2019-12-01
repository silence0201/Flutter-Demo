import 'package:fluro/fluro.dart';
/// * Project Name:flutter_shop
/// * Package Name:router
/// * File Name: routers.dart
/// * Date:2019-12-01 
/// * Copyright © 2019 silence. All Rights Reserved.
///

import 'router_handler.dart';

class Application {
  static Router router;
}

class Routes {
  static String root = '/';
  static String detailsPage = 'detail';

  static void configureRoutes(Router router) {
    router.notFoundHandler = new Handler(
      handlerFunc: (context ,paras) {
        print('Error ==> Not Found Route ');
      }
    );
    
    router.define(detailsPage, handler: detailsHandler);
  }
}