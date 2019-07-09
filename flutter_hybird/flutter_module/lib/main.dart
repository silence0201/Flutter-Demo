import 'package:flutter/material.dart';
import 'dart:ui'; // 要使用window对象必须引入
import 'dart:async';
import 'package:flutter/services.dart'; // 要使用channel必须引入

// 拿到从Android Native项目中传入的json类型的数据后,序列化成Dart obj,就可以做任何事情了
void main() => runApp(MyApp(initParams: window.defaultRouteName));

enum ToastDuration {
  short, long
}

class MyApp extends StatelessWidget {
  final String initParams;

  const MyApp({Key key, this.initParams}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter 混合开发',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter 混合开发', initParams: initParams),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title, this.initParams}) : super(key: key);

  final String title;
  final String initParams;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const EventChannel _eventChannelPlugin = EventChannel('EventChannelPlugin');
  static const MethodChannel _methodChannelPlugin = MethodChannel('MethodChannelPlugin');
  static const BasicMessageChannel<String> _basicMessageChannelPlugin =
        BasicMessageChannel('BasicMessageChannelPlugin', StringCodec());
  String showMessage = "";
  bool _isMethodChannelPlugin = false;
  StreamSubscription _streamSubscription;
  final editController = TextEditingController();

  @override
  void initState() {
    // EventChannel: 首先初始化一个广播流,用于从channel中接收数据,
    // 接下来调用Stream的listen方法来完成注册监听,
    // 另外需要在页面销毁时,调用Stream的cancel方法来取消监听.
    _streamSubscription = _eventChannelPlugin
        .receiveBroadcastStream('123') //监听事件时向native传递的数据
        .listen(_on2Dart, onError: _on2DartError);
    //使用BasicMessageChannel接收来自Native的消息,并向Native回复
    _basicMessageChannelPlugin
        //设置消息处理器
        .setMessageHandler((String message) => Future<String>(() {
          setState(() {
            showMessage = 'BasicMessageChannel: ' + message;
          });
          return "收到Native的消息: " + message;
    }));
    super.initState();
  }

  @override
  void dispose() {
    editController.dispose();
    if (_streamSubscription != null) {
      _streamSubscription.cancel();
      _streamSubscription = null;
    }
    super.dispose();
  }

  ///EventChannel: Dart只接收来自Native的消息,无法向Native回复
  void _on2Dart(message) {
    setState(() {
      showMessage = 'EventChannel: ' + message;
    });
  }

  void _on2DartError(error) {
    print('error: $error');
  }

  void _toast(String msg, ToastDuration duration) async {
    var argument = {
      'content': msg,
      'duration': duration.toString()
    };
    String response;
    try {
      // 本地方法是一个异步调用。'toast' 对应Java代码的onMethodCall方法里处理的方法名
      response = await _methodChannelPlugin.invokeMethod('toast', argument);
    } catch (e) {
      print(e);
    }

    setState(() {
      showMessage = response ?? "没有找到方法";
    });
  }

  void _onTextChange(value) async {
    String response;
    try {
      if (_isMethodChannelPlugin) {
        //invokeMethod: arg1:要调用的native方法名, arg2:调用的native方法时传递的参数,可不传
        response = await _methodChannelPlugin.invokeMethod('send', value);
      } else {
        //使用BasicMessageChannel向Native发送消息,并接收Native的回复
        response = await _basicMessageChannelPlugin.send(value);
      }
    } catch (e) {
      print(e);
    }
    print('_isMethodChannelPlugin: $_isMethodChannelPlugin');
    setState(() {
      showMessage = response ?? "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Container(
          color: Colors.green,
          padding: EdgeInsets.only(bottom: 10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text('使用MethodChannel?'),
                  Switch(value: _isMethodChannelPlugin, onChanged: (val) {
                    setState(() {
                      _isMethodChannelPlugin = !_isMethodChannelPlugin;
                    });
                  }),
                ],
              ),

              RaisedButton(
                onPressed: (){
                  if (_isMethodChannelPlugin) {
                    final msg = 'Toast from Flutter with MethodChannel.';
                    print('log: $msg');
                    _toast(msg, ToastDuration.short);
                  }
                },
                child: Text('toast with MethodChannel'),
              ),

              TextField(
                controller: editController,
                decoration: InputDecoration(
                    hintText: '请输入发送到Native的数据'
                ),
                onChanged: _onTextChange,
              ),

              Text(
                '收到Native传来的初始参数:${widget.initParams}',
                style: TextStyle(color: Colors.redAccent),
              ),

              Text(
                'Native传来的数据:$showMessage',
                style: TextStyle(color: Colors.orangeAccent),
              ),
            ],
          ),
        ),
      ),
    );
  }

}
