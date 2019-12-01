import 'package:fluro/fluro.dart';
/// * Project Name:flutter_shop
/// * Package Name:router
/// * File Name: router_handler.dart
/// * Date:2019-12-01 
/// * Copyright © 2019 silence. All Rights Reserved.
///

import 'package:flutter_shop/pages/details_page.dart';

Handler detailsHandler = Handler(
  handlerFunc: (context,params){
     String goodsId = params['id'].first;
     print('index > detail ${goodsId}');
     return DetailsPage(goodsId);
  },
);