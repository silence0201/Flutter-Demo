import 'package:flutter/material.dart';
import 'package:nav_bar/nav/bottom_tab_bar.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  int _selectedIndex = 1;
  String badgeNo1;
  var titles = ['home', 'video', 'find', 'smallvideo', 'my'];
  var icons = [
    Icons.home,
    Icons.play_arrow,
    Icons.child_friendly,
    Icons.fiber_new,
    Icons.mic_none
  ];
  @override
  void initState() {
    super.initState();
    _tabController =
        new TabController(vsync: this, initialIndex: 1, length: titles.length);
    badgeNo1 = '12';
  }

  void _onItemSelected(int index) {
    setState(() {
      _selectedIndex = index;
      badgeNo1 = '';
    });
  }

  final _widgetOptions = [
    Text('Index 0: Home'),
    Text('Index 1: Video'),
    Text('Index 2: find someone'),
    Text('Index 3: small Video'),
    Text('Index 4: My'),
  ];

  _showAlertDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (_) => new AlertDialog(
                title: new Text("Dialog Title"),
                content: new Text("This is my content"),
                actions: <Widget>[
                  new FlatButton(
                    child: new Text("取消"),
                    onPressed: () {
                      Navigator.of(context).pop();
                      print("点击了取消");
                    },
                  ),
                  new FlatButton(
                    child: new Text("确定"),
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).push(MaterialPageRoute(builder: (context){
                        return Cre();
                      }));
                      print("点击了确定");
                    },
                  )
                ]));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _widgetOptions.elementAt(_selectedIndex),
        actions: <Widget>[
          GestureDetector(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 3, horizontal: 10),
                child: Icon(Icons.cake),
              ),
              onTap: () {
                _showAlertDialog(context);
              })
        ],
      ),
      bottomNavigationBar: BottomTabBar(
        items: <BottomTabBarItem>[
          BottomTabBarItem(
              icon: Icon(icons[0]), title: Text(titles[0]), badgeNo: badgeNo1),
          BottomTabBarItem(icon: Icon(icons[1]), title: Text(titles[1])),
          BottomTabBarItem(icon: Icon(icons[2]), title: Text(titles[2])),
          BottomTabBarItem(
              icon: Icon(icons[3]),
              activeIcon: Icon(icons[3]),
              title: Text(titles[3])),
          BottomTabBarItem(icon: Icon(icons[4]), title: Text(titles[4])),
        ],
        fixedColor: Colors.blue,
        currentIndex: _selectedIndex,
        onTap: _onItemSelected,
        type: BottomTabBarType.fixed,
        isAnimation: false,
        isInkResponse: false,
        badgeColor: Colors.green,
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
    );
  }
}
class Cre extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Demo"),
      ),
      body: Center(
        child: Text("Hello,World"),
      ),
    );
  }
}
