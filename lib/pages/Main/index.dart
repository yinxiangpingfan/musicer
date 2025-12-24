import 'package:flutter/material.dart';
import 'package:qqmusicstudy/pages/Home/index.dart';
import 'package:qqmusicstudy/pages/Mine/index.dart';
import 'package:qqmusicstudy/pages/Vedio/index.dart';
import 'package:qqmusicstudy/pages/Search/index.dart';
import 'package:qqmusicstudy/pages/Cummity/index.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with TickerProviderStateMixin {
  //定义底部bottomNavigationBar
  final List<Map<String, String>> _buttomItems = [
    {
      'icon': 'lib/assets/a-159_zhuye.png',
      'activeIcon': 'lib/assets/a-159_zhuye_1.png',
      'text': '首页',
    },
    {
      'icon': 'lib/assets/a-159_bofang.png',
      'activeIcon': 'lib/assets/a-159_bofang_1.png',
      'text': '直播',
    },
    {
      'icon': 'lib/assets/a-159_sousuo.png',
      'activeIcon': 'lib/assets/a-159_sousuo_1.png',
      'text': '搜索',
    },
    {
      'icon': 'lib/assets/a-159_duihua-05.png',
      'activeIcon': 'lib/assets/a-159_duihua-05_1.png',
      'text': '社区',
    },
    {
      'icon': 'lib/assets/a-159_wode.png',
      'activeIcon': 'lib/assets/a-159_wode_1.png',
      'text': '我的',
    },
  ];

  //定义五个control控制5个底部item的动画控制器
  List<AnimationController> _controllers = [];

  //定义缩小后放大的动画
  final Animatable _animation = TweenSequence([
    TweenSequenceItem(weight: 1, tween: Tween<double>(begin: 1.0, end: 0.6)),
    TweenSequenceItem(weight: 1, tween: Tween<double>(begin: 0.6, end: 1.0)),
  ]);

  //返回buttomNavigationBar
  List<BottomNavigationBarItem> _getBottomNagivationBarItems() {
    List<BottomNavigationBarItem> _items = [];
    for (int i = 0; i < _buttomItems.length; i++) {
      _items.add(
        BottomNavigationBarItem(
          icon: Image.asset(_buttomItems[i]['icon']!, width: 30),
          activeIcon: AnimatedBuilder(
            animation: _controllers[i],
            builder: (context, child) {
              return Transform.scale(
                scale: _animation.evaluate(_controllers[i]),
                child: child,
              );
            },
            child: Image.asset(_buttomItems[i]['activeIcon']!, width: 30),
          ),
          label: _buttomItems[i]['text']!,
        ),
      );
    }
    return _items;
  }

  //定义目前的底部导航
  int _currentIdex = 0;

  //定义底部导航对应的页面
  List<Widget> _getWidgets() {
    return [HomePage(), VedioPage(), SearchPage(), CummityPage(), MinePage()];
  }

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < _buttomItems.length; i++) {
      _controllers.add(
        AnimationController(
          vsync: this,
          duration: Duration(milliseconds: 200),
          lowerBound: 0.0,
          upperBound: 1.0,
        ),
      );
      _controllers[i].reverse();
    }
  }

  @override
  void dispose() {
    for (int i = 0; i < _buttomItems.length; i++) _controllers[i].dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: IndexedStack(index: _currentIdex, children: _getWidgets()),
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIdex,
        selectedItemColor: Colors.black,
        selectedFontSize: 14,
        unselectedFontSize: 14,
        unselectedItemColor: Colors.black,
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: true,
        onTap: (value) {
          // 先重置之前选中的item动画
          _controllers[_currentIdex].reset();
          // 播放新选中item的动画
          _controllers[value].forward();
          setState(() {
            _currentIdex = value;
          });
        },
        items: _getBottomNagivationBarItems(),
      ),
    );
  }
}
