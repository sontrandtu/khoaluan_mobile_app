
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:khoaluan_mobile_app/utils/extensions/context_extension.dart';
import 'package:khoaluan_mobile_app/utils/extensions/text_styles_extension.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../../theme/color.dart';

class VerifyOTPForm extends StatefulWidget {
  final String? phoneNumber;
  final Function(String?)? otpCallBack;
  const VerifyOTPForm({
    this.phoneNumber,
    Key? key, this.otpCallBack,
  }) : super(key: key);

  @override
  State<VerifyOTPForm> createState() => _VerifyOTPFormState();
}

class _VerifyOTPFormState extends State<VerifyOTPForm> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.hideKeyboard(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Text('XÁC NHẬN OTP', style: context.textStyle(color: AppColors.secondaryColor).size18.w700.fontQuicksand),
          ),
          const SizedBox(height: 20),
          Text(
            'Mã xác nhận được gửi về thuê bao:',
            style: context.textStyle(color: Colors.black),
          ),
          const SizedBox(height: 6),
          Text(
            widget.phoneNumber ?? "",
            style: context.textStyle(color: AppColors.primaryColor).w700.size16,
          ),
          const SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: PinCodeTextField(
              length: 6,
              obscureText: false,
              animationType: AnimationType.fade,
              textStyle: TextStyle(color: AppColors.primaryColor),
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              pinTheme: PinTheme.defaults(
                shape: PinCodeFieldShape.box,
                borderRadius: BorderRadius.circular(8.0),
                fieldHeight: 40,
                fieldWidth: 40,
                activeColor: AppColors.pinCodeTextFieldColor,
                inactiveColor: AppColors.inactiveButton,
                selectedColor: AppColors.pinCodeTextFieldColor,
                inactiveFillColor: AppColors.inactiveButton,
                activeFillColor: AppColors.pinCodeTextFieldColor,
                selectedFillColor: AppColors.pinCodeTextFieldColor,
              ),
              animationDuration: const Duration(milliseconds: 300),
              enableActiveFill: true,
              onChanged: (value) => widget.otpCallBack?.call(value),
              appContext: context,
            ),
          ),
        ],
      ),
    );
  }
}