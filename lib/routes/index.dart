// 管理路由

import 'package:flutter/material.dart';
import 'package:hm_shop/pages/Login/index.dart';
import 'package:hm_shop/pages/Main/index.dart';

Widget getRootWidget() {
  return MaterialApp(
    // 命名路由
    routes: getRoutes(),
  );
}

// 返回App的路由配置
Map<String, Widget Function(BuildContext)> getRoutes() {
  return {
    "/": (context) => MainPage(), 
    "/login": (context) => LoginPage()
    };
}
