import 'package:flutter/material.dart';
import 'package:hm_shop/viewmodels/home.dart';

class HmSuggestion extends StatefulWidget {
  final SpecialOfferResult specialOfferResult;

  HmSuggestion({Key? key, required this.specialOfferResult}) : super(key: key);

  @override
  _HmSuggestionState createState() => _HmSuggestionState();
}

class _HmSuggestionState extends State<HmSuggestion> {
  List<SpecialOfferGoodsItem> _getGoodsItemsTop3() {
    if (widget.specialOfferResult.subTypes.isEmpty) {
      return [];
    }
    return widget.specialOfferResult.subTypes.first.goodsItems.items
        .take(3)
        .toList();
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Text(
          "特惠推荐",
          style: TextStyle(
            color: const Color.fromARGB(255, 83, 20, 20),
            fontSize: 30,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(width: 10),
        Text(
          "精选省攻略",
          style: TextStyle(
            color: const Color.fromARGB(255, 139, 65, 65),
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }

  Widget _buildLeftItem() {
    return Container(
      width: 100,
      height: 140,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("lib/assets/home_cmd_inner.png"),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  List<Widget> _getChildrenList() {
    List<SpecialOfferGoodsItem> list = _getGoodsItemsTop3();
    return List.generate(list.length, (int index) {
      return Expanded(
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset(
                    "lib/assets/home_cmd_inner.png",
                    // width: 100,
                    height: 140,
                  );
                },
                list[index].picture,
                // width: 100,
                height: 140,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 250, 63, 63),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                "￥${list[index].price}",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      // height: 300,
      alignment: Alignment.center,

      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("lib/assets/home_cmd_sm.png"),
          fit: BoxFit.cover,
        ),
        color: Colors.blue,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          _buildHeader(), //顶部内容
          SizedBox(width: 10),
          
          Row(
            children: [
              _buildLeftItem(),
              SizedBox(width: 10),
              Expanded(
                child: Row(
                  children: _getChildrenList(),
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  // spacing: 10,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
