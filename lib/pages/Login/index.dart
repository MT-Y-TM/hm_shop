import 'package:flutter/material.dart';
import 'package:hm_shop/components/Login/LoginTextField.dart';
import 'package:hm_shop/utils/Toastutils.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // 状态变量
  bool _isChecked = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // 同意条款状态切换函数
  void _changeCheckedStyle(bool? value) {
    _isChecked = value ?? false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "惠多美登录",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      // 💡 解决键盘弹出溢出问题的关键
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "账号密码登录",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 30),

                // 使用你封装的组件：账号框
                LoginTextField(
                  labelText: "请输入账号",
                  controller: _usernameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      // print("请输入账号");
                      return "请输入账号";
                    }
                    if (!RegExp(r'^1[3-9]\d{9}$').hasMatch(value)) {
                      // print("请输入正确的手机号");
                      return "请输入正确的手机号";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                // 使用你封装的组件：密码框（isPassword 为 true）
                LoginTextField(
                  labelText: "请输入密码",
                  isPassword: true,
                  controller: _passwordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      // print("请输入密码");
                      return "请输入密码";
                    }
                    if (!RegExp(r'^[a-z][A-Z][0-9]{6,16}$').hasMatch(value)) {
                      // print("密码必须包含一个小写字母、一个大写字母和6-16位数字");
                      return "密码必须包含一个小写字母、一个大写字母和6-16位数字";
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 15),

                // 协议勾选区域
                Row(
                  children: [
                    // 💡 官方 Checkbox 组件
                    SizedBox(
                      width: 24,
                      height: 24,
                      child: Checkbox(
                        value: _isChecked,
                        onChanged: _changeCheckedStyle,
                        activeColor: Colors.blue, // 选中时的颜色
                        checkColor: Colors.white, // 对号的颜色
                        shape: const CircleBorder(),
                        side: const BorderSide(color: Colors.grey, width: 1.5),
                      ),
                    ),
                    const SizedBox(width: 8),
                    // 使用 Expanded 防止文字过长换行时崩溃
                    const Expanded(
                      child: Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Text("查看并同意"),
                          Text(
                            "《用户协议》",
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text("和"),
                          Text(
                            "《隐私政策》",
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 40),

                // 登录按钮示例
                SizedBox(
                  width: double.infinity,
                  height: 45,
                  child: ElevatedButton(
                    onPressed: _isChecked
                        ? () {
                            if (_formKey.currentState!.validate()) {
                              // print("登陆成功");
                              ToastUtils.show("登陆成功", context);
                            }
                          }
                        : () {
                            ToastUtils.show("请先同意用户协议和隐私政策", context);
                            return null;
                          }, // 未勾选协议时禁用按钮（变为灰色）
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    child: const Text("登录", style: TextStyle(fontSize: 16)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
