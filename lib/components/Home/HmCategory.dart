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
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,

        itemBuilder: (BuildContext buildcontex, int index) {
          return Container(
            width: 80,
            height: 100,
            color: Colors.blue,
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: Text("分类$index", style: TextStyle(color: Colors.white)),
          );
        },
      ),
    );
  }
}
