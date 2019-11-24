import "package:dio/dio.dart";
import 'dart:async';
import '../config/service_url.dart';

Future request(url,{formData})async{
  try{
    //print('开始获取数据...............');
    Response response;
    Dio dio = new Dio();
    dio.options.contentType = Headers.formUrlEncodedContentType;
    if(formData==null){
      response = await dio.post(servicePath[url]);
    }else{
      response = await dio.post(servicePath[url],data:formData);
    }
    if(response.statusCode==200){
      return response.data;
    }else{
      throw Exception('后端接口出现异常，请检测代码和服务器情况.........');
    }
  }catch(e){
    return print('ERROR:======>${e}');
  }

}

// 获取首页主题内容
Future getHomePageContent() async {

  try {
    print('开始获取首页数据......');
    Response response;
    Dio dio = new Dio();

    dio.options.contentType = Headers.formUrlEncodedContentType;
    var formData = {'lon':'115.02932','lat':'35.76189'};
    response = await dio.post(servicePath['homePageContext'],data:formData);
    if(response.statusCode==200){
      return response.data;
    }else{
      throw Exception('后端接口出现异常，请检测代码和服务器情况.........');
    }
  } catch (e) {
    print(e);
  }
}

//获得火爆专区商品的方法
Future getHomePageBeloConten() async{
  try{
    print('开始获取下拉列表数据.................');
    Response response;
    Dio dio = new Dio();
    dio.options.contentType = Headers.formUrlEncodedContentType;
    int page=1;
    response = await dio.post(servicePath['homePageBelowConten'],data:page);
    if(response.statusCode==200){
      return response.data;
    }else{
      throw Exception('后端接口出现异常，请检测代码和服务器情况.........');
    }
  }catch(e){
    return print('ERROR:======>${e}');
  }


}