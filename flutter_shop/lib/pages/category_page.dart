import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/model/category.dart';
import 'package:flutter_shop/model/category_good_list.dart';
import 'package:flutter_shop/provide/child_category.dart';
import 'package:flutter_shop/service/service_method.dart';
import 'package:provide/provide.dart';

class CategoryPage extends StatefulWidget {
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('商品分类'),),
      body: Container(
        child: Row(
          children: <Widget>[
            LeftCategoryNav(),
            Column(
              children: <Widget>[
                RightCategoryNav(),
                CategoryGoods()
              ],
            )
          ],
        ),
      ),
    );
  }


}

class LeftCategoryNav extends StatefulWidget {
  @override
  _LeftCategoryNavState createState() => _LeftCategoryNavState();
}

class _LeftCategoryNavState extends State<LeftCategoryNav> {

  List<DataBean> list = [];

  var listIndex = 0;

  @override
  void initState() {
    _getCategory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(180),
      decoration: BoxDecoration(
        border: Border(
          right: BorderSide(width: 1,color: Colors.black12)
        ),
      ),
      child: ListView.builder(
        itemCount: list.length,
        itemBuilder: (context,index) {
          return _leftInkWell(index);
        },
      )
    );
  }

  Widget _leftInkWell(int index) {
    bool isHight = false;
    isHight = (index == listIndex);

    return InkWell(
      onTap: () {
        setState(() {
          listIndex = index;
        });
        List<BxMallSubDtoBean> childList = list[index].bxMallSubDto;
        Provide.value<ChildCategory>(context).setChildCategory(childList);
      },
      child: Container(
        height: ScreenUtil().setHeight(60),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isHight ? Colors.black12 : Colors.white,
          border: Border(
            bottom: BorderSide(width: 1,color: Colors.black12)
          ),
        ),
        child: Text(
          list[index].mallCategoryName,
          style: TextStyle(
            fontSize: 16
          ),
        ),
      ),
    );
  }

  void _getCategory() async {
    await request('getCategory').then((val) {
      var data = json.decode(val.toString());
      CategoryModel model = CategoryModel.fromMap(data);
      setState(() {
        list = model.data;
        // 初始化第一个
        Provide.value<ChildCategory>(context).setChildCategory(list[0].bxMallSubDto);
      });
    });
  }
}

class RightCategoryNav extends StatefulWidget {
  @override
  _RightCategoryNavState createState() => _RightCategoryNavState();
}

class _RightCategoryNavState extends State<RightCategoryNav> {

  @override
  Widget build(BuildContext context) {
    return Provide<ChildCategory>(
      builder: (context,child,childCategory){
        List<BxMallSubDtoBean> list = childCategory.chidCategoryList;
        return Container(
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                  bottom: BorderSide(width: 1,color: Colors.black12)
              )
          ),
          height: ScreenUtil().setHeight(50),
          width: ScreenUtil().setWidth(570),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: list.length,
            itemBuilder: (context, index){
              return _rightInkWell(list[index]);
            },
          ),
        );
      },
    );
  }

  Widget _rightInkWell(BxMallSubDtoBean item) {
    return InkWell(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.only(left: 10,right: 10,top: 5,bottom: 5),
        child: Text(
          item.mallSubName,
          style: TextStyle(fontSize: 17),
        ),
      ),
    );
  }
}

class CategoryGoods extends StatefulWidget {
  @override
  _CategoryGoodsState createState() => _CategoryGoodsState();
}

class _CategoryGoodsState extends State<CategoryGoods> {

  List<Good> list = [];

  @override
  Widget build(BuildContext context) {
    _getGoodsList();
    return Container(
      width: ScreenUtil().setWidth(570),
      height: ScreenUtil().setHeight(1000),
      child: ListView.builder(
        itemCount: list.length,
        itemBuilder: (context,index) {
          return _itemWidget(index);
        },
      ),
    );
  }

  _getGoodsList() async {
    var params = {
      'categoryId' : '4',
      'CategorySubId' : '',
      'page' : 1
    };

    await request('getMallGoods',formData: params).then((value){
      var data = json.decode(value.toString());
      CategoryGoodList goodList = CategoryGoodList.fromMap(data);
      setState(() {
        list = goodList.data;
      });
    });
  }

  Widget _goodImage(index) {
    return Container(
      width: ScreenUtil().setWidth(200),
      child: Image.network(list[index].image),
    );
  }

  Widget _goodName(index) {
    return Container(
      padding: EdgeInsets.all(5.0),
      width: ScreenUtil().setWidth(370),
      child: Text(
        list[index].goodsName,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(fontSize: 16),
      ),
    );
  }

  //商品价格方法
  Widget _goodPrice(int index){
    return  Container(
        margin: EdgeInsets.only(top:20.0),
        width: ScreenUtil().setWidth(370),
        child:Row(
            children: <Widget>[
              Text(
                '价格:￥${list[index].presentPrice}',
                style: TextStyle(color:Colors.pink,fontSize:ScreenUtil().setSp(30)),
              ),
              Text(
                '￥${list[index].oriPrice}',
                style: TextStyle(
                    color: Colors.black26,
                    decoration: TextDecoration.lineThrough
                ),
              )
            ]
        )
    );
  }

  Widget _itemWidget(int index) {
    return InkWell(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.only(top: 5.0,bottom: 5.0),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(
              color: Colors.black12,
              width: 1.0
            )
          )
        ),
        child: Row(
          children: <Widget>[
            _goodImage(index),
            Column(
              children: <Widget>[
                _goodName(index),
                _goodPrice(index)
              ],
            )
          ],
        ),
      ),
    );
  }
}



