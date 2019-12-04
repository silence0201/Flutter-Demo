/// * Project Name:flutter_shop
/// * Package Name:pages.details_page
/// * File Name: detail_web.dart
/// * Date:2019-12-04 
/// * Copyright © 2019 silence. All Rights Reserved.
///

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_shop/provide/detail_info.dart';
import 'package:provide/provide.dart';

class DetailWeb extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provide<DetailsInfo>(
      builder: (context,child,val) {
        var goodsDetails = val.goodsInfo.data.goodInfo.goodsDetail;
        var isLeft = val.isLeft;
        if (isLeft) {
          return Container(
            child: Html(
              data: goodsDetails,
            ),
          );
        } else {
          return Container(
            child: Text('暂无数据'),
          );
        }
      },
    );

  }
}
