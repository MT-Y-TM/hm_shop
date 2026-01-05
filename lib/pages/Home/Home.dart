import 'package:flutter/material.dart';
import 'package:hm_shop/api/home.dart';
import 'package:hm_shop/components/Home/HmCategory.dart';
import 'package:hm_shop/components/Home/HmSlider.dart';
import 'package:hm_shop/components/Home/HmHot.dart';
import 'package:hm_shop/components/Home/HmMoreList.dart';
import 'package:hm_shop/components/Home/HmSuggestion.dart';
import 'package:hm_shop/utils/Toastutils.dart' show ToastUtils;
import 'package:hm_shop/viewmodels/home.dart';

class HomeView extends StatefulWidget {
  HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<BannerItem> _bannerList = [];
  List<CategoryItem> _categoryList = [];
  SpecialOfferResult _specialOfferResult = SpecialOfferResult(
    id: "",
    title: "",
    subTypes: [],
  );

  List<Widget> _getChildren() {
    return [
      SliverToBoxAdapter(child: HmSlider(bannerList: _bannerList)),
      SliverToBoxAdapter(child: SizedBox(height: 10)),

      SliverToBoxAdapter(child: HmCategory(categoryList: _categoryList)),
      SliverToBoxAdapter(child: SizedBox(height: 10)),

      SliverToBoxAdapter(
        child: Padding(
          padding: EdgeInsetsGeometry.symmetric(horizontal: 10),
          child: HmSuggestion(specialOfferResult: _specialOfferResult),
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
                Expanded(
                  child: HmHot(result: _inVogueResult, type: "hot"),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: HmHot(result: _oneStopResult, type: "step"),
                ),
              ],
            ),
          ),
        ),
      ),
      SliverToBoxAdapter(child: SizedBox(height: 10)),
      HmMoreList(recommendList: _recommendList), // 无限滚动列表
    ];
  }

  //获取商品列表
  Future<void> _getProductList() async {
    _specialOfferResult = await getProductListAPI();
    setState(() {});
  }

  // 热榜推荐
  SpecialOfferResult _inVogueResult = SpecialOfferResult(
    id: "",
    title: "",
    subTypes: [],
  );
  // 一站式推荐
  SpecialOfferResult _oneStopResult = SpecialOfferResult(
    id: "",
    title: "",
    subTypes: [],
  );

  // 获取热榜推荐列表
  Future<void> _getInVogueList() async {
    _inVogueResult = await getInVogueListAPI();
    setState(() {});
  }

  // 获取一站式推荐列表
  Future<void> _getOneStopList() async {
    _oneStopResult = await getOneStopListAPI();
    setState(() {});
  }

  // 推荐列表
  List<GoodDetailItem> _recommendList = [];
  // 推荐列表的分页
  int _page = 1;
  bool _isLoading = false;
  bool _hasMore = true;

  // 获取推荐列表
  Future<void> _getRecommendList() async {
    if (_isLoading || !_hasMore) {
      return;
    }
    _isLoading = true;
    int requiredLimit = _page * 8;
    _recommendList.addAll(await getRecommendListAPI({"limit": requiredLimit}));
    _isLoading = false;
    setState(() {});
    if (_recommendList.length < requiredLimit) {
      _hasMore = false;
      return;
    }
    _page++;
  }

  // 监听滚动到底部的事件
  _registerEvent() {
    _controller.addListener(() {
      if (_controller.position.pixels >=
          (_controller.position.maxScrollExtent - 50)) {
        _getRecommendList();
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _registerEvent();
    Future.microtask(() {
      _key.currentState?.show();
    });
  }

  //获取轮播图列表
  Future<void> _getBannerList() async {
    _bannerList = await getBannerListAPI();
    setState(() {});
  }

  //获取分类列表
  Future<void> _getCategoryList() async {
    _categoryList = await getCategoryListAPI();
    setState(() {});
  }

  Future<void> _onRefresh() async {
    _page = 1;
    _hasMore = true;
    _recommendList.clear();
    await _getBannerList();
    await _getCategoryList();
    await _getProductList();
    await _getInVogueList();
    await _getOneStopList();
    await _getRecommendList();
    //刷新成功
    ToastUtils.show("刷新成功", context);
  }

  final ScrollController _controller = ScrollController();
  final GlobalKey<RefreshIndicatorState> _key =
      GlobalKey<RefreshIndicatorState>();
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      key: _key,
      child: CustomScrollView(slivers: _getChildren(), controller: _controller),
      onRefresh: () async {
        // 刷新数据
        await _onRefresh();
      },
    );
  }
}
