import 'package:flutter/material.dart';

class LoginTextField extends StatefulWidget {
  final String labelText;
  final bool isPassword;
  final TextEditingController? controller;
  // 解释一下下面这个 validator 函数
  // 它的参数是一个字符串（用户输入的文本），返回值是一个字符串（错误提示）
  // 如果返回 null 表示没有错误
  final String? Function(String?)? validator;

  const LoginTextField({
    Key? key,
    required this.labelText,
    this.isPassword = false,
    this.controller,
    this.validator,
  }) : super(key: key);

  @override
  _LoginTextFieldState createState() => _LoginTextFieldState();
}

class _LoginTextFieldState extends State<LoginTextField> {
  // 💡 定义内部状态，专门控制小眼睛的开关
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    // 初始状态：如果是密码框，默认遮蔽
    _obscureText = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: _obscureText,
      validator: widget.validator,
      controller: widget.controller,
      decoration: InputDecoration(
        labelText: widget.labelText,
        filled: true,
        fillColor: Colors.grey.withAlpha(60),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
          borderSide: BorderSide.none,
        ),
        // 💡 只有是密码框时才显示后缀图标
        suffixIcon: widget.isPassword
            ? IconButton(
                icon: Icon(
                  _obscureText ? Icons.visibility_off : Icons.visibility,
                ),
                onPressed: () {
                  _obscureText = !_obscureText;
                  setState(() {});
                },
              )
            : null, // 非密码框，不显示图标
      ),
    );
  }
}
