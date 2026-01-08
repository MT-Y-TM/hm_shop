import 'package:get/get.dart';
import 'package:hm_shop/viewmodels/user.dart';

class UserController extends GetxController {
  var user = UserInfo.fromJSON({}).obs;//监听这个对象

  updateUserInfo(UserInfo newUser){
    user.value = newUser;
  }
}
