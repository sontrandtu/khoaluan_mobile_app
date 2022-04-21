import 'package:flutter/material.dart';
import 'package:khoaluan_mobile_app/page_routes.dart';
import 'package:khoaluan_mobile_app/res.dart';
import 'package:khoaluan_mobile_app/utils/extensions/context_extension.dart';
import 'package:provider/provider.dart';

import '../../../widgets/buttons/custom_default_button.dart';
import '../../../widgets/field/custom_input_field.dart';
import '../component/circle_decoration.dart';
import '../component/hero_title.dart';
import 'login_view_model.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<FormState> loginKey = GlobalKey<FormState>();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<LoginViewModel>();
    return GestureDetector(
      onTap: () {
        context.hideKeyboard();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Form(
                  key: loginKey,
                  child: Column(
                    children: [
                      const SizedBox(height: 150),
                      const HeroTitle(
                        image: Res.mainLogo,
                        content:
                            "Sử dụng tên đăng nhập và mật khẩu đển sử dụng dịch vụ của chúng tôi",
                        title: "Chào mừng bạn đến với FastRom",
                      ),
                      const SizedBox(height: 30),
                      CustomInputField(
                        labelWidget: const Text('Tên đăng nhập'),
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
                      const SizedBox(height: 20),
                      CustomInputField(
                        labelWidget: const Text('Mật khẩu'),
                        obscureText: true,
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return 'Vui lòng nhập mật khẩu';
                          }
                          if (value.length < 6) {
                            return 'Mật khẩu quá ngắn';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 30),
                      CustomDefaultButton(
                        onTap: () {
                          if (loginKey.currentState!.validate()) {
                            // viewModel.login(successCallback: (message) {
                            //   print(message);
                            // });
                          }
                          print(usernameController.text);
                          print(passwordController.text);
                        },
                        height: 50,
                        padding: 20,
                        title: 'ĐĂNG NHẬP',
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {},
                          child: const Text(
                            'Quên mật khẩu',
                            style: TextStyle(color: Colors.blue),
                          ),
                        ),
                      ),
                      Text.rich(
                        TextSpan(
                          style: const TextStyle(
                              fontSize: 14, color: Colors.black),
                          children: [
                            const TextSpan(text: "Bạn chưa có tài khoản?"),
                            WidgetSpan(
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.of(context)
                                      .pushNamed(PageRoutes.registerPage);
                                },
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 7),
                                  child: Text("Đăng kí",
                                      style: TextStyle(color: Colors.blue)),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              CircleDecoration(
                radius: MediaQuery.of(context).size.width * 0.3,
                top: 30,
                left: -50,
              ),
              CircleDecoration(
                radius: MediaQuery.of(context).size.width * 0.45,
                top: -50,
                right: -50,
              ),
              CircleDecoration(
                radius: MediaQuery.of(context).size.width * 0.3,
                bottom: -50,
                left: -50,
              ),
              CircleDecoration(
                radius: MediaQuery.of(context).size.width * 0.12,
                bottom: 10,
                right: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
