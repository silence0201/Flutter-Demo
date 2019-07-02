import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
//      home: ListPage(title: '首页'),
    /*
      home: Scaffold(
        appBar: AppBar(title: Text('Demo')),
        body: Center(
          child: CachedNetworkImage(
            imageUrl: "https://picsum.photos/id/9/250/250",
            placeholder: (context, url) => new CircularProgressIndicator(),
            errorWidget: (context, url, error) => new Icon(Icons.error),
          ),
        ),
      ),*/
      home: HeroAnimation(),
    );
  }
}

class PhotoHero extends StatelessWidget {
  const PhotoHero({ Key key, this.photo, this.onTap, this.width }) : super(key: key);

  final String photo;
  final VoidCallback onTap;
  final double width;

  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Hero(
        tag: photo,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            child: Image.network(
              photo,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}

class HeroAnimation extends StatelessWidget {

  double timeDilation;

  Widget build(BuildContext context) {
    timeDilation = 10.0; // 1.0 means normal animation speed.

    return Scaffold(
      appBar: AppBar(
        title: const Text('Basic Hero Animation'),
      ),
      body: Center(
        child: PhotoHero(
          photo: 'https://raw.githubusercontent.com/flutter/website/master/examples/_animation/Hero_animation/images/flippers-alpha.png',
          width: 300.0,
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute<void>(
                builder: (BuildContext context) {
                  return Scaffold(
                    appBar: AppBar(
                      title: const Text('Flippers Page'),
                    ),
                    body: Container(
                      // Set background to blue to emphasize that it's a new route.
                      color: Colors.lightBlueAccent,
                      padding: const EdgeInsets.all(16.0),
                      alignment: Alignment.topLeft,
                      child: PhotoHero(
                        photo: 'https://raw.githubusercontent.com/flutter/website/master/examples/_animation/Hero_animation/images/flippers-alpha.png',
                        width: 100.0,
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                  );
                }
            ));
          },
        ),
      ),
    );
  }
}

class ListPage extends StatefulWidget {

  ListPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ListPageState createState() => _ListPageState();

}

class _ListPageState extends State<ListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title)
      ),
//      body: ListView(children: _getListData())
      body: ListView.builder(
        itemCount: widgets.length,
        itemBuilder: (BuildContext context, int position) {
          return _getRow(position);
        },
      ),
    );
  }

  List widgets = [];

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < 100;i++) {
      widgets.add(_getRow(i));
    }
  }

  _getRow(i) {
   return GestureDetector(
     child: Padding(
       padding: EdgeInsets.all(10.0),
       child: Text("Row $i"),
     ),
     onTap: (){
       setState(() {
         widgets.add(_getRow(widgets.length + 1));
         print('row $i');
       });
     },
   );

  }

  _getListData() {
    List<Widget> widgets = [];
    for (int i = 0 ; i < 100;i++) {
      widgets.add(Padding(padding: EdgeInsets.all(10),child: Text("Row $i")));
    }
    return widgets;
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin{
  AnimationController controller;
  CurvedAnimation curve;

  int _counter = 0;
  String _textToShow = 'I Like Flutter';

  void _incrementCounter() {
    setState(() {
      _counter++;
      _textToShow = 'Flutter is Awesome!';
    });
  }

  void _hello() {
    // 弹出提示
    showDialog(//弹出提示的方法
        context: context,
        builder: (context){
          return AlertDialog(//提示框组件
            title: Text("输入内容不能为空"),
          );
        },
    );
  }

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 2000));
    curve = CurvedAnimation(parent: controller, curve: Curves.easeIn);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '你点击的按钮次数:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.display1,
            ),
            Text(
              '$_textToShow',
            ),
            MaterialButton(
              onPressed: _hello,
              child: Text('Hello'),
              padding: EdgeInsets.only(left: 10.0, right: 10.0),

            ),
            FadeTransition(
              opacity: curve,
              child: FlutterLogo(
                size: 100,
              ),
            ),
            MaterialButton(
                onPressed: (){
                  controller.forward();
                },
                child: Text('Animation'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}

class SampleApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sample App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SampleAppPage(),
    );
  }
}

class SampleAppPage extends StatefulWidget {
  SampleAppPage({Key key}) : super(key: key);

  @override
  _SampleAppPageState createState() => _SampleAppPageState();
}

class _SampleAppPageState extends State<SampleAppPage> {
  List widgets = [];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  showLoadingDialog() {
    return widgets.length == 0;
  }

  getBody() {
    if (showLoadingDialog()) {
      return getProgressDialog();
    } else {
      return getListView();
    }
  }

  getProgressDialog() {
    return Center(child: CircularProgressIndicator());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Sample App"),
        ),
        body: getBody());
  }

  ListView getListView() => ListView.builder(
      itemCount: widgets.length,
      itemBuilder: (BuildContext context, int position) {
        return getRow(position);
      });

  Widget getRow(int i) {
    return Padding(padding: EdgeInsets.all(10.0), child: Text("Row ${widgets[i]["title"]}"));
  }

  loadData() async {
    String dataURL = "https://jsonplaceholder.typicode.com/posts";
    http.Response response = await http.get(dataURL);
    setState(() {
      widgets = json.decode(response.body);
    });
  }
}
