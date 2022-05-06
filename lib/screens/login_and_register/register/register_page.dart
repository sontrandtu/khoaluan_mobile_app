import 'package:flutter/material.dart';
import 'package:khoaluan_mobile_app/screens/login_and_register/register/register_view_model.dart';
import 'package:khoaluan_mobile_app/utils/extensions/context_extension.dart';
import 'package:khoaluan_mobile_app/widgets/buttons/custom_default_button.dart';
import 'package:provider/provider.dart';

import '../../../widgets/field/custom_input_field.dart';
import '../components/hero_title.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  GlobalKey<FormState> registerKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.hideKeyboard();
      },
      child: Scaffold(
        body: SafeArea(
          child: Consumer<RegisterViewModel>(
            builder: (context, viewModel, child) => SingleChildScrollView(
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      icon: const Icon(Icons.cancel_outlined),
                      splashRadius: 23,
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Form(
                      key: registerKey,
                      child: Column(
                        children: [
                          const HeroTitle(
                            content:
                                "Bạn vui lòng điền đầy đủ các thông tin được yêu cầu",
                            title: "Đăng kí tài khoản",
                          ),
                          const SizedBox(height: 30),
                          CustomInputField(
                            onChanged: (value) => viewModel.userModel.userName = value.trim(),
                            labelWidget: const Text('Tên đăng nhập'),
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
                            onChanged: (value) => viewModel.userModel.password = value.trim(),
                            labelWidget: const Text('Mật khẩu'),
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
                            onChanged: (value) => viewModel.userModel.name = value.trim(),
                            labelWidget: const Text('Họ và tên'),
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
                            onChanged: (value) => viewModel.userModel.email = value.trim(),
                            labelWidget: const Text('Email'),
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
                          const SizedBox(height: 20),
                          CustomInputField(
                            onChanged: (value) => viewModel.userModel.phoneNumber = value.trim(),
                            labelWidget: const Text('Số điện thoại'),
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return 'Vui lòng nhập tên tài khoản';
                              }
                              if (value.length < 6) {
                                return 'Tên tài khoản quá ngắn';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 30),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: CustomDefaultButton(
                              onTap: () {
                                if (registerKey.currentState!.validate()) {
                                  print('Đăng kí thành công');
                                }
                              },
                              padding: 20,
                              title: "Đăng kí",
                              height: 50,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
