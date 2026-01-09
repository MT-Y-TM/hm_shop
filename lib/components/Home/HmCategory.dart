import 'package:flutter/material.dart';
import 'package:hm_shop/viewmodels/home.dart';

class HmCategory extends StatefulWidget {
  //分类列表
  final List<CategoryItem> categoryList;
  HmCategory({Key? key, required this.categoryList}) : super(key: key);

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
        itemCount: widget.categoryList.length,
        itemBuilder: (BuildContext context, int index) {
          //从categoryList中获取分类数据
          final category = widget.categoryList[index];
          return Container(
            width: 80,
            margin: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: const Color.fromARGB(
                255,
                160,
                197,
                240,
              ),//.withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(40),
            ),
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.network(category.picture, width: 30, height: 30),
                SizedBox(height: 5),
                Text(category.name, style: TextStyle(color: Colors.black)),
              ],
            ),
          );
        },
      ),
    );
  }
}
