import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with TickerProviderStateMixin {
  //设置选中的组件编号
  int _selectedIndex = 0;

  //动画控制器和动画列表
  List<AnimationController> _animationControllers = [];
  List<Animation<double>> _animations = [];

  //初始化动画控制器和动画
  void _initAnimationControllers() {
    _animationControllers = List.generate(
      5,
      (index) => AnimationController(
        duration: const Duration(milliseconds: 200), //设置特效持续时间
        vsync: this,
      ),
    );
  }

  void _initAnimations() {
    _animations = _animationControllers.map((controller) {
      return TweenSequence<double>([
        //设置两端动画
        //变小
        TweenSequenceItem(
          tween: Tween<double>(
            begin: 1.0,
            end: 0.8,
          ).chain(CurveTween(curve: Curves.easeOut)),
          weight: 50,
        ),
        //变大
        TweenSequenceItem(
          tween: Tween<double>(
            begin: 0.8,
            end: 1.0,
          ).chain(CurveTween(curve: Curves.easeOut)),
          weight: 50,
        ),
      ]).animate(controller);
    }).toList();
  }

  @override
  void initState() {
    super.initState();
    _initAnimationControllers();
    _initAnimations();
  }

  @override
  void dispose() {
    // 释放动画控制器
    for (var controller in _animationControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  //获取中间主体
  Widget _getBody() {
    return Container();
  }

  //获取底部状态导航栏
  //定义底部导航栏的信息
  final List<Map<String, dynamic>> _bottomNavigationBarItems = [
    {'icon': Icons.home, 'label': '首页'},
    {'icon': Icons.flip_camera_android, 'label': '直播'},
    {'icon': Icons.search, 'label': '搜索'},
    {'icon': Icons.chat, 'label': '社区'},
    {'icon': Icons.person, 'label': '我的'},
  ];
  List<BottomNavigationBarItem> _getBottomNavigationBar() {
    List<BottomNavigationBarItem> temp = [];
    for (int i = 0; i < _bottomNavigationBarItems.length; i++) {
      temp.add(
        BottomNavigationBarItem(
          icon: AnimatedBuilder(
            animation: _animations[i], //监听的动画
            builder: (context, child) {
              //动画改变时，时时构建
              return Transform.scale(
                scale: _animations[i].value,
                child: Icon(_bottomNavigationBarItems[i]['icon']),
              );
            },
          ),
          label: _bottomNavigationBarItems[i]['label'],
        ),
      );
    }
    return temp;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _getBody(), //获取中间主体
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        type: BottomNavigationBarType.fixed,
        onTap: (value) {
          // 触发动画
          _animationControllers[value].forward(from: 0.0);
          setState(() => _selectedIndex = value);
        },
        backgroundColor: Colors.white,
        selectedFontSize: 14,
        unselectedFontSize: 14,
        showUnselectedLabels: true,
        useLegacyColorScheme: false,
        selectedItemColor: Colors.green, // 选中项的颜色（图标+文字）
        unselectedItemColor: Colors.black, // 未选中项的颜色（图标+文字）
        items: _getBottomNavigationBar(),
      ), //获取底部状态导航栏
    );
  }
}
