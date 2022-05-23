import 'package:flutter/material.dart';

import '../../../widgets/field/custom_input_field.dart';

class NewPasswordForm extends StatefulWidget {

  final GlobalKey<FormState> confirmPasswordKey;
  final Function(String?)? newPasswordCallBack;
  const NewPasswordForm({Key? key,
    required this.confirmPasswordKey,
    this.newPasswordCallBack,
  }) : super(key: key);

  @override
  State<NewPasswordForm> createState() => _NewPasswordFormState();
}

class _NewPasswordFormState extends State<NewPasswordForm> {

  String? newPassword;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.confirmPasswordKey,
      child: Column(
        children: [
          const Text(
            "Nhập mật khẩu mới của bạn",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          CustomInputField(
            obscureText: true,
            onChanged: (value) {
              setState(() {
                newPassword = value;
              });
              widget.newPasswordCallBack?.call(value);
            },
            labelWidget: RichText(
              text: TextSpan(
                children: [
                  const TextSpan(text: '* ', style: TextStyle(color: Colors.red,fontWeight: FontWeight.w400, fontFamily: 'Roboto', fontSize: 14)),
                  TextSpan(text: 'mật khẩu mới',style: TextStyle(color: Colors.black.withOpacity(0.4), fontFamily: 'Roboto', fontSize: 14),),
                ],
              ),
            ),
            validator: (String? value) {
              if (value!.isEmpty) {
                return 'Vui lòng nhập mật khẩu mới';
              }
              if (value.length < 6) {
                return 'Mật khẩu quá ngắn';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
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
              if (value != newPassword) {
                return 'Vui lòng nhập đúng mật khẩu đã nhập ở trên';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }
}
