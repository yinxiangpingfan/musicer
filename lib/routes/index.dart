import 'package:easycount/pages/Login/index.dart';
import 'package:easycount/pages/Main/index.dart';
import 'package:flutter/material.dart';

Widget getRootWidget() {
  return MaterialApp(
    theme: ThemeData(
      splashColor: Colors.transparent, //点击时的水波纹为透明
      highlightColor: Colors.transparent, //长按时的扩散效果为透明
    ),
    routes: _getRoutes(),
  );
}

Map<String, Widget Function(BuildContext)> _getRoutes() {
  return {
    '/': (context) => MainPage(), //主页面
    '/login': (context) => LoginPage(), //登录页面
  };
}
