import 'dart:convert';

import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/router/routers.dart';
import 'package:flutter_shop/service/service_method.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin {

  String homePageContent = '正在获取数据...';

  int page = 1;
  List<Map> hotGoodsList = [];

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    print('Home Page Loading....');
    getHomePageContent().then((value){
      setState(() {
        homePageContent = value.toString();
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('电商+'),),
      body: FutureBuilder(
        future: getHomePageContent(),
        builder: (context, snapshot){
          if (snapshot.hasData) {
            var data = json.decode(snapshot.data.toString());

            // 数据源
            List<Map> swiper = (data['data']['slides'] as List).cast();
            List<Map> navgatorList = (data['data']['category'] as List).cast();
            String adPicture = data['data']['advertesPicture']['PICTURE_ADDRESS'];

            String leaderImage = data['data']['shopInfo']['leaderImage'];
            String leaderPhone = data['data']['shopInfo']['leaderPhone'];

            List<Map> recommendList = (data['data']['recommend'] as List).cast(); // 商品推荐

            String floor1Title =data['data']['floor1Pic']['PICTURE_ADDRESS'];//楼层1的标题图片
            String floor2Title =data['data']['floor2Pic']['PICTURE_ADDRESS'];//楼层1的标题图片
            String floor3Title =data['data']['floor3Pic']['PICTURE_ADDRESS'];//楼层1的标题图片
            List<Map> floor1 = (data['data']['floor1'] as List).cast(); //楼层1商品和图片
            List<Map> floor2 = (data['data']['floor2'] as List).cast(); //楼层1商品和图片
            List<Map> floor3 = (data['data']['floor3'] as List).cast(); //楼层1商品和图片



            return EasyRefresh(
              footer: ClassicalFooter(
                bgColor: Colors.white,
                textColor: Colors.pink,
                noMoreText:'',
                loadedText: '加载中...',
                loadText: '上拉加载'
              ),

              child: ListView(
                  children: <Widget>[
                    SwiperDiy(swiperDateList: swiper),
                    TopNavigator(nagvigatorList: navgatorList,),
                    AdBanner(adPicture: adPicture,),
                    LeaderPhone(leaderImage: leaderImage,leaderPhone: leaderPhone,),
                    Recommend(recommendList: recommendList,),
                    FloorTitle(picture_address: floor1Title,),
                    FloorContent(floorGoodsList: floor1,),
                    FloorTitle(picture_address: floor2Title,),
                    FloorContent(floorGoodsList: floor2,),
                    FloorTitle(picture_address: floor3Title,),
                    FloorContent(floorGoodsList: floor3,),
                    _hotGoods()
                ],
              ),
              onLoad: () async {
                var formPage = {'page' : page};
                request('homePageBelowConten',formData: formPage).then((val) {
                  var data = json.decode(val.toString());
                  List<Map> newGoodsList = (data['data'] as List).cast();
                  setState(() {
                    hotGoodsList.addAll(newGoodsList);
                    page++;
                  });
                });
              },
            );
          } else {
            return Center(
              child: Text('加载中'),
            );
          }
        },
      ),
    );
  }


  Widget hotTitle = Container(
    margin: EdgeInsets.only(top: 10.0),
    alignment: Alignment.center,
    color: Colors.transparent,
    child: Text('火爆专区'),
  );

  Widget _wrapList() {
    if (hotGoodsList.length != 0) {
      List<Widget> listWidget = hotGoodsList.map((val) {
        return InkWell(
          onTap: (){
            Application.router.navigateTo(context, '/detail?id=${val['goodsId']}', transition: TransitionType.cupertino);
          },
          child: Container(
            width: ScreenUtil().setWidth(372),
            color: Colors.white,
            padding: EdgeInsets.all(5.0),
            margin: EdgeInsets.only(bottom: 3.0),
            child: Column(
              children: <Widget>[
                Image.network(val['image'],width: ScreenUtil().setWidth(370),),
                Text(
                  val['name'],
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.pink,
                    fontSize: ScreenUtil().setSp(26)
                  ),
                ),
                Row(
                  children: <Widget>[
                    Text('￥${val['mallPrice']}'),
                    Text(
                      '￥${val['price']}',
                      style: TextStyle(color:Colors.black26,decoration: TextDecoration.lineThrough),
                    )
                  ],
                )

              ],
            ),
          ),
        );
      }).toList();

      return Wrap(
        spacing: 2,
        children: listWidget,
      );
    } else {
      return Text('');
    }
  }

  Widget _hotGoods() {
    return Container(
      child: Column(
        children: <Widget>[
          hotTitle,
          _wrapList()
        ],
      ),
    );
  }
}


// 首页轮播图片
class SwiperDiy extends StatelessWidget {
  final List swiperDateList;
  SwiperDiy({Key key,this.swiperDateList}) : super(key:key) ;

  @override
  Widget build(BuildContext context) {

//    print('像素密度:${ScreenUtil.pixelRatio}');
//    print('设备的高:${ScreenUtil.screenHeight}');
//    print('设备的宽:${ScreenUtil.screenWidth}');

    return Container(
      height: ScreenUtil().setHeight(320),
      width: ScreenUtil().setWidth(750),
      child: Swiper(
        itemBuilder: (BuildContext contexn, int index){
          return Image.network("${swiperDateList[index]['image']}",fit: BoxFit.cover,);
        },
        itemCount: swiperDateList.length,
        pagination: SwiperPagination(),
        autoplay: true,
      ),
    );
  }
}


// 功能导航
class TopNavigator extends StatelessWidget {
  final List nagvigatorList;

  TopNavigator({Key key,this.nagvigatorList}) : super(key:key);

  Widget _gridViewItemUI(BuildContext context,item) {
    return InkWell(
      onTap: () {
        print("点击了导航按钮");
      },
      child: Column(
        children: <Widget>[
          Image.network(item['image'],width: ScreenUtil().setWidth(95),),
          Text(item['mallCategoryName'])
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (this.nagvigatorList.length > 10) {
      this.nagvigatorList.removeRange(10, this.nagvigatorList.length);
    }

    return Container(
      height: ScreenUtil().setHeight(320),
      padding: EdgeInsets.all(3.0),
      child: GridView.count(
        crossAxisCount: 5,
        physics: NeverScrollableScrollPhysics(),
        padding: EdgeInsets.all(5.0),
        children: nagvigatorList.map((item) {
          return _gridViewItemUI(context, item);
        }).toList(),
      ),
    );
  }
}

// banner
class AdBanner extends StatelessWidget {

  final String adPicture;

  AdBanner({Key key, this.adPicture}) : super(key:key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image.network(adPicture),
    );
  }


}

// 拨打电话
class LeaderPhone extends StatelessWidget {
  final String leaderImage; // 店长图片
  final String leaderPhone; // 店长电话

  LeaderPhone({Key key,this.leaderImage,this.leaderPhone}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: _launchURL,
        child: Image.network(leaderImage),
      ),
    );
  }

  void _launchURL() async{
    String url = 'tel:' + leaderPhone;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'url不能访问';
    }
  }
}

// 商品推荐
class Recommend extends StatelessWidget {
  final List recommendList;

  Recommend({Key key,this.recommendList}) : super(key: key);

  // 标题
  Widget _titleWidget() {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.fromLTRB(10.0, 2.0, 0, 5.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(width: 0.5,color: Colors.black12),
        )
      ),
      child: Text(
        '商品推荐',
        style: TextStyle(color: Colors.pink),
      ),
    );
  }

  // 商品单独项
  Widget _item(int index){
    return InkWell(
      onTap: () {},
      child: Container(
        height: ScreenUtil().setHeight(320),
        width: ScreenUtil().setWidth(250),
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            left: BorderSide(width: 0.5,color: Colors.black12),
          )
        ),
        child: Column(
          children: <Widget>[
            Image.network(recommendList[index]['image']),
            Text('￥${recommendList[index]['mallPrice']}'),
            Text(
              '￥${recommendList[index]['price']}',
              style: TextStyle(
                decoration: TextDecoration.lineThrough,
                color:Colors.grey
              ),
            )
          ],
        ),
      ),
    );
  }

  // 横向列表
  Widget _recommedList() {
    return Container(
      height: ScreenUtil().setHeight(280),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: recommendList.length,
        itemBuilder: (context,index) {
          return _item(index);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10.0),
      child: Column(
        children: <Widget>[
          _titleWidget(),
          _recommedList()
        ],
      ),
    );
  }
}

// 楼层标题
class FloorTitle extends StatelessWidget {

  final String picture_address;

  FloorTitle({Key key, this.picture_address}) : super(key : key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: Image.network(picture_address),
    );
  }
}

// 楼层商品列表
class FloorContent extends StatelessWidget {
  final List floorGoodsList;
  FloorContent({Key key,this.floorGoodsList}) : super(key:key);
  

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          _firstRow(),
          _otherGoodsRow()
        ],
      ),
    );
  }

  Widget _firstRow() {
    return Row(
      children: <Widget>[
        _goodsItem(floorGoodsList[0]),
        Column(
          children: <Widget>[
            _goodsItem(floorGoodsList[1]),
            _goodsItem(floorGoodsList[2]),
          ],
        ),
      ],
    );
  }

  Widget _otherGoodsRow() {
    return Row(
      children: <Widget>[
        _goodsItem(floorGoodsList[3]),
        _goodsItem(floorGoodsList[4])
      ],
    );
  }

  Widget _goodsItem(Map good) {
    return Container(
      width: ScreenUtil().setWidth(375),
      child: InkWell(
        onTap: () {},
        child: Image.network(good['image']),
      ),
    );
  }
}



