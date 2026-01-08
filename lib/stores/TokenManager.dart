import 'package:hm_shop/contants/index.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TokenManager {
  //返回持久化对象
  Future<SharedPreferences> getInstance() {
    return SharedPreferences.getInstance();
  }

  String _token = "";
  Future<void> init() async {
    final prefs = await getInstance();
    _token = prefs.getString(GlobalConstans.TOKEN_KEY) ?? "";
  }

  //设置token
  Future<void> setToken(String val) async {
    final prefs = await getInstance();
    prefs.setString(GlobalConstans.TOKEN_KEY, val);
    _token = val;
  }

  //获取token
  String getToken() {
    return _token;
  }

  Future<void> removeToken() async {
    final prefs = await getInstance();
    prefs.remove(GlobalConstans.TOKEN_KEY); //删除磁盘上的token
    _token = ""; //删除内存上的token
  }
}

final tokenManager = TokenManager();
