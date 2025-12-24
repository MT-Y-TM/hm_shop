import 'package:flutter/material.dart';
import 'package:hm_shop/components/Home/HmCategory.dart';
import 'package:hm_shop/components/Home/HmSlider.dart';
import 'package:hm_shop/components/Home/HmHot.dart';
import 'package:hm_shop/components/Home/HmMoreList.dart';
import 'package:hm_shop/components/Home/HmSuggestion.dart';

class HomeView extends StatefulWidget {
  HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<Widget> _getChildren() {
    return [
      SliverToBoxAdapter(child: HmSlider()),
      SliverToBoxAdapter(child: SizedBox(height: 10)),

      SliverToBoxAdapter(child: HmCategory()),
      SliverToBoxAdapter(child: SizedBox(height: 10)),

      SliverToBoxAdapter(
        child: Padding(
          padding: EdgeInsetsGeometry.symmetric(horizontal: 10),
          child: HmSuggestion(),
        ),
      ),
      SliverToBoxAdapter(child: SizedBox(height: 10)),
      SliverToBoxAdapter(
        child: Padding(
          padding: EdgeInsetsGeometry.symmetric(horizontal: 10),
          child: SizedBox(
            height: 300,
            child: Flex(
              direction: Axis.horizontal,
              children: [
                Expanded(child: HmHot()),
                SizedBox(width: 10,),
                Expanded(child: HmHot()),
              ],
            ),
          ),
        ),
      ),
      SliverToBoxAdapter(child: SizedBox(height: 10)),
      HmMoreList()
    ];
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(slivers: _getChildren());
  }
}
