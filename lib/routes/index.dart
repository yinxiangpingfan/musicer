import 'package:flutter/material.dart';
import '../pages/Main/index.dart';

Widget getRootWidget() {
  return MaterialApp(
    //设置水波纹为透明
    theme: ThemeData(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
    ),
    // 命名路由
    initialRoute: "/",
    routes: getRootRoutes(),
  );
}

Map<String, Widget Function(BuildContext)> getRootRoutes() {
  return {
    "/": (context) => MainPage(), //主页
    // "/login": (context) => LoginPage(), //登录页
  };
}
