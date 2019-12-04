import 'dart:convert';

import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/model/category.dart';
import 'package:flutter_shop/model/category_good_list.dart';
import 'package:flutter_shop/provide/category_goods_list.dart';
import 'package:flutter_shop/provide/child_category.dart';
import 'package:flutter_shop/router/routers.dart';
import 'package:flutter_shop/service/service_method.dart';
import 'package:fluttertoast/fluttertoast.dart';
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

  void showLongToast() {
    Fluttertoast.showToast(
      msg: "クィ異才",
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.CENTER,
      backgroundColor: Colors.pink,
      textColor: Colors.white,
      fontSize: 16.0
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
        showLongToast();
        List<BxMallSubDtoBean> childList = list[index].bxMallSubDto;
        String categoryId = list[index].mallCategoryId;
        Provide.value<ChildCategory>(context).setChildCategory(childList,categoryId);
        _getGoodsList(categoryId: categoryId);
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
        Provide.value<ChildCategory>(context).setChildCategory(list.first.bxMallSubDto);
        _getGoodsList(categoryId: list.first.mallCategoryId);
      });
    });
  }

  _getGoodsList({String categoryId}) async {
    var params = {
      'categoryId' : categoryId,
      'categorySubId' : '',
      'page' : 1
    };

    await request('getMallGoods',formData: params).then((value){
      var data = json.decode(value.toString());
      CategoryGoodList goodList = CategoryGoodList.fromMap(data);
      Provide.value<CategoryGoodsList>(context).setGoodsList(goodList.data);
    });
  }
}

// sub category导航
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
              return _rightInkWell(index,list[index]);
            },
          ),
        );
      },
    );
  }

  Widget _rightInkWell(int index,BxMallSubDtoBean item) {
    bool isHight =  (index == Provide.value<ChildCategory>(context).childIndex);
    return InkWell(
      onTap: () {
        String Id = item.mallSubId;
        Provide.value<ChildCategory>(context).changeChildIndex(index,Id);
        _getGoodsList(Id);
      },
      child: Container(
        padding: EdgeInsets.only(left: 10,right: 10,top: 5,bottom: 5),
        child: Text(
          item.mallSubName,
          style: TextStyle(
              fontSize: 17,
              color: isHight ? Colors.pink : Colors.black
          ),
        ),
      ),
    );
  }

  _getGoodsList(String categorySuId) async {
    String categoryId = Provide.value<ChildCategory>(context).categoryId;
    var params = {
      'categoryId' : categoryId,
      'categorySubId' : categorySuId,
      'page' : 1
    };

    await request('getMallGoods',formData: params).then((value){
      var data = json.decode(value.toString());
      CategoryGoodList goodList = CategoryGoodList.fromMap(data);
      Provide.value<CategoryGoodsList>(context).setGoodsList(goodList.data);
    });
  }
}

class CategoryGoods extends StatefulWidget {
  @override
  _CategoryGoodsState createState() => _CategoryGoodsState();
}

class _CategoryGoodsState extends State<CategoryGoods> {


  var scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Provide<CategoryGoodsList>(
      builder: (context,child,data){
        try {
          if (Provide.value<ChildCategory>(context).page == 1) {
            scrollController.jumpTo(0.0);
          }
        } catch(e) {
          print('第一次初始化');
        }
        if (data?.goodList.length > 0) {
          return Expanded(
            child: Container(
              width: ScreenUtil().setWidth(570),
              child: EasyRefresh(
                footer: ClassicalFooter(
                  bgColor: Colors.white,
                  textColor: Colors.pink,
                  infoColor: Colors.pink,
                  noMoreText: Provide.value<ChildCategory>(context).noMoreText,
                  loadText: '开始加载',
                  loadingText: '正在加载',
                  loadReadyText: '上拉加载'
                ),
                child: ListView.builder(
                  controller: scrollController,
                  itemCount: data.goodList.length,
                  itemBuilder: (context,index) {
                    Good good = data.goodList[index];
                    return _itemWidget(good);
                  },
                ),
                onLoad: () async {
                  _getMoreList();
                },
              )
            ),
          );
        } else {
          return Center(
            child: Text('暂时没有数据'),
          );
        }
      },
    );
  }

  Widget _goodImage(Good good) {
    return Container(
      width: ScreenUtil().setWidth(200),
      child: Image.network(good.image),
    );
  }

  Widget _goodName(Good good) {
    return Container(
      padding: EdgeInsets.all(5.0),
      width: ScreenUtil().setWidth(370),
      child: Text(
        good.goodsName,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(fontSize: 16),
      ),
    );
  }

  //商品价格方法
  Widget _goodPrice(Good good){
    return  Container(
        margin: EdgeInsets.only(top:20.0),
        width: ScreenUtil().setWidth(370),
        child:Row(
            children: <Widget>[
              Text(
                '价格:￥${good.presentPrice}',
                style: TextStyle(color:Colors.pink,fontSize:ScreenUtil().setSp(30)),
              ),
              Text(
                '￥${good.oriPrice}',
                style: TextStyle(
                    color: Colors.black26,
                    decoration: TextDecoration.lineThrough
                ),
              )
            ]
        )
    );
  }

  Widget _itemWidget(Good good) {
    return InkWell(
      onTap: () {
        Application.router.navigateTo(context, '/detail?id=${good.goodsId}',transition: TransitionType.cupertino);
      },
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
            _goodImage(good),
            Column(
              children: <Widget>[
                _goodName(good),
                _goodPrice(good)
              ],
            )
          ],
        ),
      ),
    );
  }

  //上拉加载更多的方法
  void _getMoreList() async{

    Provide.value<ChildCategory>(context).addPage();
    var params={
      'categoryId':Provide.value<ChildCategory>(context).categoryId,
      'categorySubId':Provide.value<ChildCategory>(context).subId,
      'page':Provide.value<ChildCategory>(context).page
    };

    await request('getMallGoods',formData: params).then((value){
      var data = json.decode(value.toString());
      CategoryGoodList goodList = CategoryGoodList.fromMap(data);
      if (goodList.data == null) {
        Provide.value<ChildCategory>(context).changeNoMore('没有更多数据');
      } else {
        Provide.value<CategoryGoodsList>(context).setGoodsList(goodList.data);
      }

    });
  }
}



