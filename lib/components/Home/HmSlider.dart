import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:hm_shop/viewmodels/home.dart';

class HmSlider extends StatefulWidget {
  final List<BannerItem> bannerList;
  HmSlider({Key? key, required this.bannerList}) : super(key: key);

  @override
  _HmSliderState createState() => _HmSliderState();
}

class _HmSliderState extends State<HmSlider> {
  _getWidth() {
    final double screenWidth = (MediaQuery.of(context).size.width);
    return screenWidth;
  }

  _getHeigth() {
    final double screenHeigth = (MediaQuery.of(context).size.height) / 3;
    return screenHeigth;
  }

  Widget _getSlider() {
    return CarouselSlider(
      items: List.generate(widget.bannerList.length, (int index) {
        return Image.network(
          widget.bannerList[index].imgUrl,
          fit: BoxFit.cover,
          width: _getWidth(),
        );
      }),
      options: CarouselOptions(
        viewportFraction: 1,
        autoPlay: true,
        autoPlayInterval: Duration(seconds: 1),
        height: _getHeigth(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // return Container(
    //   color: Colors.blue,
    //   height: 300,
    //   alignment: Alignment.center,
    //   child: Text("轮播图", style: TextStyle(color: Colors.white)),
    // );
    return Stack(children: [_getSlider()]);
  }
}
