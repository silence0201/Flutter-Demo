import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final typeController = TextEditingController();
  String showText = "欢迎,Hello,World";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hello,Wrold'),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              TextField(
                controller: typeController,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(10.0),
                    labelText: '类型',
                    helperText: '请输入类型'
                ),
                autofocus: false,
              ),
              RaisedButton(
                onPressed: _choicAction,
                child: Text('选择完毕'),
              ),
              Text(
                showText,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              )
            ],
          ),
        ),
      )

    );
  }

  void _choicAction() {
    print("开始选择");
    if (typeController.text.toString() == '') {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(title: Text('类型不能为空'),)
      );
    } else {
      getHttp(typeController.text.toString()).then((vale) {
        setState(() {
          showText = vale.toString();
        });
      });
    }
  }

  Future getHttp(String typeText) async {
    try {
      Response response;
      var data = {'name' : typeText};
      response = await Dio().get(
        "https://www.baidu.com",
        queryParameters: data
      );
      return response.data;
    } catch (e) {
      print(e);
    }
  }
}
