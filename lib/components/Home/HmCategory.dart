import 'package:flutter/material.dart';

class HmCategory extends StatefulWidget {
  HmCategory({Key? key}) : super(key: key);

  @override
  _HmCategoryState createState() => _HmCategoryState();
}

class _HmCategoryState extends State<HmCategory> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 30,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            width: 70,
            margin: EdgeInsets.symmetric(horizontal: 10),
            color: Colors.blue,
            alignment: Alignment.center,
            child: Text("分类$index", style: TextStyle(color: Colors.white)),
          );
        },
      ),
    );
  }
}
