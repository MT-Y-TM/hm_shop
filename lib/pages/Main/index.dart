import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hm_shop/api/user.dart';
import 'package:hm_shop/pages/Cart/Cart.dart';
import 'package:hm_shop/pages/Category/Category.dart';
import 'package:hm_shop/pages/Home/home.dart';
import 'package:hm_shop/pages/Mine/Mine.dart';
import 'package:hm_shop/stores/TokenManager.dart';
import 'package:hm_shop/stores/UserController.dart';

class MainPage extends StatefulWidget {
  MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  void initState() {
    super.initState();
    _initUserInfo();
  }

  final UserController _userController = Get.put(UserController());
  Future<void> _initUserInfo() async {
    await tokenManager.init(); //初始化token
    if (tokenManager.getToken().isNotEmpty) {
      //如果有信息就赋值token
      _userController.updateUserInfo(await getUserInfoAPI());
      print("用户信息: ${_userController.user.value}");
    }else{
      print("用户信息为空");
      print("当前的token: ${tokenManager.getToken()}");
    }
  }

  // 定义数据 根据数据进行渲染
  final List<Map<String, String>> _tablist = [
    {
      "icon": "lib/assets/ic_public_home_normal.png",
      "active_icon": "lib/assets/ic_public_home_active.png",
      "text": "首页",
    },
    {
      "icon": "lib/assets/ic_public_pro_normal.png",
      "active_icon": "lib/assets/ic_public_pro_active.png",
      "text": "分类",
    },
    {
      "icon": "lib/assets/ic_public_cart_normal.png",
      "active_icon": "lib/assets/ic_public_cart_active.png",
      "text": "购物车",
    },
    {
      "icon": "lib/assets/ic_public_my_normal.png",
      "active_icon": "lib/assets/ic_public_my_active.png",
      "text": "我的",
    },
  ];
  int _currentIndex = 0;

  // 返回四个分类内容以List<BottomNavigationBarItem>的类型
  List<BottomNavigationBarItem> _getTabBarWidget() {
    return List.generate(4, (index) {
      return BottomNavigationBarItem(
        icon: Image.asset(_tablist[index]["icon"]!, width: 30, height: 30),
        activeIcon: Image.asset(
          _tablist[index]["active_icon"]!,
          width: 30,
          height: 30,
        ),
        label: _tablist[index]["text"],
      );
    });
  }

  List<Widget> _getChildren() {
    return [HomeView(), CategoryView(), CartView(), MineView()];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: IndexedStack(index: _currentIndex, children: _getChildren()),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: _getTabBarWidget(),
        currentIndex: _currentIndex,
        selectedItemColor: const Color.fromARGB(255, 253, 144, 237),
        showUnselectedLabels: true,
        unselectedItemColor: Colors.black,
        onTap: (int index) {
          _currentIndex = index;
          setState(() {});
        },
      ),
    );
  }
}
