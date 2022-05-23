import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:khoaluan_mobile_app/screens/change_phone_number/change_phone_number_view_model.dart';
import 'package:khoaluan_mobile_app/theme/app_bar.dart';
import 'package:khoaluan_mobile_app/utils/extensions/context_extension.dart';
import 'package:khoaluan_mobile_app/widgets/buttons/custom_default_button.dart';
import 'package:provider/provider.dart';

import '../../widgets/field/custom_input_field.dart';

class ChangePhoneNumberPage extends StatefulWidget {
  const ChangePhoneNumberPage({Key? key}) : super(key: key);

  @override
  State<ChangePhoneNumberPage> createState() => _ChangePhoneNumberPageState();
}

class _ChangePhoneNumberPageState extends State<ChangePhoneNumberPage> {

  bool isVisible = true;
  final GlobalKey<FormState> phoneNumberKey = GlobalKey<FormState>();
  final GlobalKey<FormState> verifyPhoneNumberKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DefaultAppBar(title: "Thay đổi số điện thoại"),
      body: Consumer<ChangePhoneNumberViewModel>(
        builder: (context, viewModel, child) => GestureDetector(
          onTap: () => context.hideKeyboard(),
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Visibility(
                  visible: isVisible,
                  child: Form(
                    key: phoneNumberKey,
                    child: Column(
                      children: [
                        const Text(
                          "Nhập số điện thoại mới",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 32),
                        CustomInputField(
                          value: viewModel.userModel.phoneNumber,
                          readOnly: true,
                          maxLength: 10,
                          keyboardType: TextInputType.number,
                          labelWidget: RichText(
                            text: TextSpan(
                              children: [
                                const TextSpan(text: '* ', style: TextStyle(color: Colors.red,fontWeight: FontWeight.w400, fontFamily: 'Roboto', fontSize: 14)),
                                TextSpan(text: 'Số điện thoại cũ',style: TextStyle(color: Colors.black.withOpacity(0.4), fontFamily: 'Roboto', fontSize: 14),),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 32),
                        CustomInputField(
                          maxLength: 10,
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            viewModel.newPhoneNumber.phoneNumber = value;
                          },
                          labelWidget: RichText(
                            text: TextSpan(
                              children: [
                                const TextSpan(text: '* ', style: TextStyle(color: Colors.red,fontWeight: FontWeight.w400, fontFamily: 'Roboto', fontSize: 14)),
                                TextSpan(text: 'Số điện thoại mới',style: TextStyle(color: Colors.black.withOpacity(0.4), fontFamily: 'Roboto', fontSize: 14),),
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
                        const SizedBox(height: 40),
                        CustomDefaultButton(
                          onTap: (){
                            if(phoneNumberKey.currentState!.validate()){
                              viewModel.getOTP(
                                  successCallback: (mes){
                                    Fluttertoast.showToast(msg: mes ?? '', backgroundColor: Colors.green);
                                    setState(() {
                                      isVisible = false;
                                    });
                                    },
                                  errorCallback: (error){
                                    Fluttertoast.showToast(msg: error ?? '', backgroundColor: Colors.red);
                                  }
                              );
                            } else{
                              context.showMessage("Vui lòng nhập số điện thoại mới", type: MessageType.error);
                            }
                        },
                          padding: 10,
                          title: "Lấy mã OTP",
                          height: 50,
                        ),
                      ],
                    ),
                  ),
                ),
                Visibility(
                  visible: !isVisible,
                  child: Form(
                    key: verifyPhoneNumberKey,
                    child: Column(
                      children: [
                        const Text(
                          "Nhập mã OTP",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 32),
                        CustomInputField(
                          maxLength: 6,
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            viewModel.otp = value;
                          },
                          labelWidget: RichText(
                            text: TextSpan(
                              children: [
                                const TextSpan(text: '* ', style: TextStyle(color: Colors.red,fontWeight: FontWeight.w400, fontFamily: 'Roboto', fontSize: 14)),
                                TextSpan(text: 'OTP',style: TextStyle(color: Colors.black.withOpacity(0.4), fontFamily: 'Roboto', fontSize: 14),),
                              ],
                            ),
                          ),
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return 'Vui lòng nhập mã OTP';
                            }
                            if (value.length < 6) {
                              return 'Mã OTP phải đủ 6 kí tự';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 40),
                        CustomDefaultButton(
                          onTap: (){
                            if(verifyPhoneNumberKey.currentState!.validate()){
                              viewModel.verifyOTP(
                                  successCallback: (mes){
                                    Fluttertoast.showToast(msg: mes ?? '', backgroundColor: Colors.green);
                                    Navigator.of(context).pop();
                                  },
                                  errorCallback: (error){
                                    context.showMessage(error, type: MessageType.error);
                                  }
                              );
                            } else{
                              context.showMessage("Vui lòng nhập số điện thoại mới", type: MessageType.error);
                            }
                          },
                          padding: 10,
                          title: "Xác nhận",
                          height: 50,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
