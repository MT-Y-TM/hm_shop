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
  final CarouselSliderController _controller = CarouselSliderController();
  int _currentIndex = 0;
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
      carouselController: _controller,
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
        autoPlayInterval: Duration(seconds: 4),
        height: _getHeigth(),
        onPageChanged: (index, reason) {
          _currentIndex = index;
          setState(() {});
        },
      ),
    );
  }

  Widget _getSearch() {
    return Positioned(
      // 💡 在 Stack 里用 Positioned 控制位置更专业
      top: 10,
      left: 15,
      right: 15,
      child: Container(
        height: 40,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.black,//.withValues(alpha: 0.3)
          borderRadius: BorderRadius.circular(20),
        ),
        alignment: Alignment.centerLeft,
        child: Row(
          children: [
            Icon(Icons.search, color: Colors.white70, size: 18),
            SizedBox(width: 8),
            Text("搜索...", style: TextStyle(color: Colors.white70)),
          ],
        ),
      ),
    );
  }

  Widget _getDots() {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 10,
      child: SizedBox(
        height: 40,
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(widget.bannerList.length, (int index) {
            return GestureDetector(
              onTap: () {
                _controller.jumpToPage(index);
                print("点击了$index");
                setState(() {});
              },
              child: AnimatedContainer(
                duration: Duration(milliseconds :300),
                margin: EdgeInsets.symmetric(horizontal: 10),
                height: 6,
                width: index == _currentIndex ? 40 : 20,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3),
                  color: index == _currentIndex
                      ? const Color.fromARGB(255, 214, 214, 214)
                      : const Color.fromARGB(138, 9, 9, 9),
                ),
              ),
            );
          }),
        ),
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
    return Stack(children: [_getSlider(), _getSearch(), _getDots()]);
  }
}
