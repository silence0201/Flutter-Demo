import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {

  List<String> testList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _show();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Perference'),
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: 500,
            child: ListView.builder(
              itemCount: testList.length,
              itemBuilder: (context,index){
                return ListTile(
                  title: Text(testList[index]),
                );
              }),
          ),
          RaisedButton(
            onPressed: _add,
            child: Text('增加'),
          ),
          RaisedButton(
            onPressed: _clear,
            child: Text('删除'),
          )
        ],
      ),
    );
  }

  // 增加方法
  _add() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String tmp = 'Hello,World';
    testList.add(tmp);
    prefs.setStringList('TestInfo', testList);
    _show();
  }

  // 查询
  _show() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getStringList('TestInfo') != null) {
      setState(() {
        testList = prefs.getStringList("TestInfo");
      });
    }
  }

  // 删除
  _clear() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('TestInfo');
    setState(() {
      testList = [];
    });
  }
}
