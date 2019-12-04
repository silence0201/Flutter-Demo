/// * Project Name:flutter_shop
/// * Package Name:pages.details_page
/// * File Name: detail_explain.dart
/// * Date:2019-12-04 
/// * Copyright © 2019 silence. All Rights Reserved.
///

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailExplain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      margin: EdgeInsets.only(top: 10.0),
      width: ScreenUtil().setWidth(750),
      padding: EdgeInsets.all(10),
      child: Text(
        '说明: 急速送达 正品保障',
        style: TextStyle(
          color: Colors.red,
          fontSize: ScreenUtil().setSp(20)
        ),
      ),
    );
  }
}
