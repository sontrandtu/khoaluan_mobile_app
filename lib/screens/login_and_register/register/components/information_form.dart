import 'package:flutter/material.dart';

import '../../../../widgets/field/custom_input_field.dart';

class InformationForm extends StatelessWidget {
  final GlobalKey<FormState> informationKey;
  final Function(String? userName)? userNameCallBack;
  final Function(String? password)? passwordCallBack;
  final Function(String? name)? nameCallBack;
  final Function(String? email)? emailCallBack;

  const InformationForm({
    Key? key,
    required this.informationKey,
    this.userNameCallBack,
    this.passwordCallBack,
    this.nameCallBack,
    this.emailCallBack,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: informationKey,
      child: Column(
        children: [
          const Text(
            "Lấy thông tin tài khoản",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          CustomInputField(
            onChanged: (value) => userNameCallBack?.call(value),
            labelWidget: RichText(
              text: TextSpan(
                children: [
                  const TextSpan(text: '* ', style: TextStyle(color: Colors.red,fontWeight: FontWeight.w400, fontFamily: 'Roboto', fontSize: 14)),
                  TextSpan(text: 'Tên đăng nhập',style: TextStyle(color: Colors.black.withOpacity(0.4), fontFamily: 'Roboto', fontSize: 14),),
                ],
              ),
            ),
            validator: (String? value) {
              if (value!.isEmpty) {
                return 'Vui lòng nhập tên đăng nhập';
              }
              if (value.length < 6) {
                return 'Tên đăng nhập quá ngắn';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          CustomInputField(
            onChanged: (value) => passwordCallBack?.call(value),
            labelWidget: RichText(
              text: TextSpan(
                children: [
                  const TextSpan(text: '* ', style: TextStyle(color: Colors.red,fontWeight: FontWeight.w400, fontFamily: 'Roboto', fontSize: 14)),
                  TextSpan(text: 'mật khẩu',style: TextStyle(color: Colors.black.withOpacity(0.4), fontFamily: 'Roboto', fontSize: 14),),
                ],
              ),
            ),
            obscureText: true,
            validator: (String? value) {
              if (value!.isEmpty) {
                return 'Vui lòng nhập mật khẩu';
              }
              if (value.length < 6) {
                return 'Mật khẩu phải trên 6 kí tự';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          CustomInputField(
            onChanged: (value) => nameCallBack?.call(value),
            labelWidget: RichText(
              text: TextSpan(
                children: [
                  const TextSpan(text: '* ', style: TextStyle(color: Colors.red,fontWeight: FontWeight.w400, fontFamily: 'Roboto', fontSize: 14)),
                  TextSpan(text: 'Họ và tên',style: TextStyle(color: Colors.black.withOpacity(0.4), fontFamily: 'Roboto', fontSize: 14),),
                ],
              ),
            ),
            validator: (String? value) {
              if (value!.isEmpty) {
                return 'Vui lòng nhập đầy đủ họ tên của bạn';
              }
              if (value.length < 6) {
                return 'Tên quá ngắn';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          CustomInputField(
            onChanged: (value) => emailCallBack?.call(value),
            labelWidget: RichText(
              text: TextSpan(
                children: [
                  const TextSpan(text: '* ', style: TextStyle(color: Colors.red,fontWeight: FontWeight.w400, fontFamily: 'Roboto', fontSize: 14)),
                  TextSpan(text: 'Email',style: TextStyle(color: Colors.black.withOpacity(0.4), fontFamily: 'Roboto', fontSize: 14),),
                ],
              ),
            ),
            validator: (String? value) {
              if (value!.isEmpty) {
                return 'Vui lòng nhập email';
              }
              if (!RegExp(
                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                  .hasMatch(value)) {
                return 'Email sai định dạng, vui lòng nhập lại';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }
}