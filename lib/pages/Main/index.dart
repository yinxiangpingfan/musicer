import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  //定义底部bottomNavigationBar
  final List<Map<String, String>> _buttomItems = [
    {'icon': 'lib/assets/a-159_zhuye.png', 'text': '首页'},
    {'icon': 'lib/assets/a-159_bofang.png', 'text': '直播'},
    {'icon': 'lib/assets/a-159_sousuo.png', 'text': '搜索'},
    {'icon': 'lib/assets/a-159_duihua-05.png', 'text': '社区'},
    {'icon': 'lib/assets/a-159_wode.png', 'text': '我的'},
  ];

  //返回buttomNavigationBar
  List<BottomNavigationBarItem> _getBottomNagivationBarItems() {
    List<BottomNavigationBarItem> _items = [];
    for (int i = 0; i < _buttomItems.length; i++) {
      _items.add(
        BottomNavigationBarItem(
          icon: Image.asset(_buttomItems[i]['icon']!, width: 20),
          label: _buttomItems[i]['text']!,
        ),
      );
    }
    return _items;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flutter Demo Home Page')),
      body: Center(child: Text('Hello, World!')),
      bottomNavigationBar: BottomNavigationBar(
        items: _getBottomNagivationBarItems(),
      ),
    );
  }
}
