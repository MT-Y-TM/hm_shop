import 'package:flutter/material.dart';

class HmHot extends StatefulWidget {
  HmHot({Key? key}) : super(key: key);

  @override
  _HmHotState createState() => _HmHotState();
}

class _HmHotState extends State<HmHot> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        color: Colors.blue,
        alignment: Alignment.center,
        child: Text("爆款推荐", style: TextStyle(color: Colors.white)),
      ),
    );
  }
}
