import 'package:flutter/material.dart';

import '../../../../widgets/field/custom_input_field.dart';

class PhoneNumberForm extends StatelessWidget {
  final Function(String? phoneNumber)? phoneNumberCallBack;
  final GlobalKey<FormState> phoneNumberKey;

  const PhoneNumberForm({
    Key? key,
    required this.phoneNumberKey,
    this.phoneNumberCallBack,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: phoneNumberKey,
      child: Column(
        children: [
          const Text(
            "Nhập số điện thoại của bạn",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 32),
          CustomInputField(
            maxLength: 10,
            keyboardType: TextInputType.number,
            onChanged: (value) => phoneNumberCallBack?.call(value),
            labelWidget: RichText(
              text: TextSpan(
                children: [
                  const TextSpan(text: '* ', style: TextStyle(color: Colors.red,fontWeight: FontWeight.w400, fontFamily: 'Roboto', fontSize: 14)),
                  TextSpan(text: 'Số điện thoại',style: TextStyle(color: Colors.black.withOpacity(0.4), fontFamily: 'Roboto', fontSize: 14),),
                ],
              ),
            ),
            validator: (String? value) {
              if (value!.isEmpty) {
                return 'Vui lòng nhập số điện thoại';
              }
              if (value.length < 10) {
                return 'Số điện thoại phải đủ 10 chữ số';
              }
              if(!RegExp("(84|0[3|5|7|8|9])+([0-9]{8})").hasMatch(value)){
                return "Số điện thoại sai định dạng";
              }
              return null;
            },
          ),
        ],
      ),
    );
  }
}