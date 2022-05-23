
import 'package:flutter/material.dart';
import 'package:khoaluan_mobile_app/screens/change_password/change_password_view_model.dart';
import 'package:khoaluan_mobile_app/theme/app_bar.dart';
import 'package:khoaluan_mobile_app/utils/extensions/context_extension.dart';
import 'package:khoaluan_mobile_app/widgets/buttons/custom_default_button.dart';
import 'package:provider/provider.dart';

import '../../widgets/field/custom_input_field.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({Key? key}) : super(key: key);

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {

  String? newPass = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DefaultAppBar(title: "Đổi mật khẩu"),
      body: Consumer<ChangePasswordViewModel>(
        builder: (context, viewModel, child) =>  GestureDetector(
          onTap: () => context.hideKeyboard(),
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20).copyWith(top: 80, bottom: 40),
            child: Column(
              children: [
                CustomInputField(
                  obscureText: true,
                  onChanged: (value) {
                    setState(() {
                      viewModel.changePasswordModel.currentPassword = value;
                    });
                  },
                  labelWidget: RichText(
                    text: TextSpan(
                      children: [
                        const TextSpan(text: '* ', style: TextStyle(color: Colors.red,fontWeight: FontWeight.w400, fontFamily: 'Roboto', fontSize: 14)),
                        TextSpan(text: 'Mật khẩu',style: TextStyle(color: Colors.black.withOpacity(0.4), fontFamily: 'Roboto', fontSize: 14),),
                      ],
                    ),
                  ),
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
                const SizedBox(height: 32),
                CustomInputField(
                  labelWidget: RichText(
                    text: TextSpan(
                      children: [
                        const TextSpan(text: '* ', style: TextStyle(color: Colors.red,fontWeight: FontWeight.w400, fontFamily: 'Roboto', fontSize: 14)),
                        TextSpan(text: 'Mật khẩu mới',style: TextStyle(color: Colors.black.withOpacity(0.4), fontFamily: 'Roboto', fontSize: 14),),
                      ],
                    ),
                  ),
                  obscureText: true,
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'Vui lòng nhập mật khẩu mới';
                    }
                    if (value.length < 6) {
                      return 'Mật khẩu quá ngắn';
                    }
                    return null;
                  },
                  onChanged: (value){
                    setState(() {
                      newPass = value;
                      viewModel.changePasswordModel.newPassword = value;
                    });
                  },
                ),
                const SizedBox(height: 32),
                CustomInputField(
                  labelWidget: RichText(
                    text: TextSpan(
                      children: [
                        const TextSpan(text: '* ', style: TextStyle(color: Colors.red,fontWeight: FontWeight.w400, fontFamily: 'Roboto', fontSize: 14)),
                        TextSpan(text: 'Xác nhận mật khẩu',style: TextStyle(color: Colors.black.withOpacity(0.4), fontFamily: 'Roboto', fontSize: 14),),
                      ],
                    ),
                  ),
                  obscureText: true,
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'Vui lòng nhập mật khẩu';
                    }
                    if (value != viewModel.changePasswordModel.newPassword) {
                      return 'Vui lòng nhập đúng mật khẩu đã nhập ở trên';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 80),
                CustomDefaultButton(
                    onTap: (){
                      viewModel.changePassword(
                        errorCallback: (error){
                          context.showMessage(error, type: MessageType.error);
                        },
                        successCallback: (mes){
                          context.showMessage(mes, type: MessageType.success);
                          Navigator.of(context).pop();
                        }
                      );
                    },
                  title: "Đổi mật khẩu",
                  height: 50,
                  padding: 20,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
