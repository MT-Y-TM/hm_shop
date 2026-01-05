import 'package:flutter/material.dart';

class ToastUtils {
  static void show(String msg, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        width: 120,
        behavior: SnackBarBehavior.floating,
        //定义圆角？居中显示
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        duration: Duration(seconds: 3),
        content: Text(msg ?? "加载成功", textAlign: TextAlign.center),
      ),
    );
  }
}
