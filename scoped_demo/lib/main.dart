import 'package:flutter/material.dart';
import 'package:scoped_demo/Model/count_model.dart';
import 'package:scoped_model/scoped_model.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // 创建顶层状态
  final CountModel countModel = CountModel();

  @override
  Widget build(BuildContext context) {
    return ScopedModel<CountModel>(
      model: countModel,
      child: MaterialApp(
          title: 'Scaped Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: TopScreen(title: 'Scaped Demo',)
      ),
    );
  }
}

class TopScreen extends StatefulWidget {
  final String title;


  TopScreen({Key key,this.title}) : super(key: key);

  @override
  _TopScreenState createState() => _TopScreenState();
}

class _TopScreenState extends State<TopScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Number(),
            MyButton()
          ],
        ),
      ),
    );
  }
}

class Number extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<CountModel>(
      builder: (context,child,model){
        return Text('${model.count}');
      },
    );
  }
}

class MyButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10),
      child: RaisedButton(
        onPressed: () {
          CountModel.of(context).increment();
        },
        child: Text('递增'),
      ),
    );
  }
}

