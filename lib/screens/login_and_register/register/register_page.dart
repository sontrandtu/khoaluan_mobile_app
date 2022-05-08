import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:khoaluan_mobile_app/widgets/buttons/custom_default_button.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:khoaluan_mobile_app/screens/login_and_register/register/register_view_model.dart';
import 'package:khoaluan_mobile_app/theme/app_bar.dart';
import 'package:khoaluan_mobile_app/utils/extensions/context_extension.dart';
import 'package:khoaluan_mobile_app/utils/extensions/text_styles_extension.dart';
import 'package:khoaluan_mobile_app/widgets/cover_loading.dart';
import 'package:provider/provider.dart';

import '../../../theme/color.dart';
import '../../../widgets/field/custom_input_field.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  int currentStep = 0;
  GlobalKey<FormState> phoneNumberKey = GlobalKey<FormState>();
  GlobalKey<FormState> informationKEy = GlobalKey<FormState>();
  late StreamController<ErrorAnimationType> errorController;

  @override
  void initState() {
    errorController = StreamController<ErrorAnimationType>();
    super.initState();
  }

  @override
  void dispose() {
    errorController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.hideKeyboard();
      },
      child:Consumer<RegisterViewModel>(
        builder: (context, viewModel, child) => Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: const DefaultAppBar(
            title: "Đăng kí tài khoản",
            canBack: true,
          ),
          body: CoverLoading(
            showLoading: viewModel.isLoading,
            child: SafeArea(
              child: Stepper(
                currentStep: currentStep,
                physics: const ClampingScrollPhysics(),
                onStepContinue: () {
                  final isLast = currentStep == 2;
                  if(isLast){
                    print("ạdajdjd");
                  }else{
                    if(phoneNumberKey.currentState!.validate()){
                      setState(() => currentStep++);
                    } else{
                      context.showMessage("Bạn vui lòng điền đầy đủ thông tin", type: MessageType.error);
                    }
                  }
                },
                onStepCancel: currentStep == 0 ? null : () => setState(() => currentStep--),
                controlsBuilder: (BuildContext context, ControlsDetails details){
                  return Container(
                    margin: EdgeInsets.only(top: 50),
                    child: Row(
                      children: [
                        Expanded(
                          child: CustomDefaultButton(
                              onTap: (){
                                final isLast = currentStep == 2;
                                if(isLast){
                                  print("ạdajdjd");
                                }else{
                                  if(phoneNumberKey.currentState!.validate()){
                                    setState(() => currentStep++);
                                  } else{
                                    context.showMessage("Bạn vui lòng điền đầy đủ thông tin", type: MessageType.error);
                                  }
                                }
                              },
                            height: 50,
                            title: "Tiếp tục".toUpperCase(),
                            padding: 20,
                          ),
                        ),
                        SizedBox(width: currentStep == 1 ? 12 : 0),
                        currentStep == 1 ? Expanded(
                          child: CustomDefaultButton(
                            onTap: (){},
                            height: 50,
                            title: "Quay lại".toUpperCase(),
                            padding: 20,
                          ),
                        ) : const SizedBox(),
                      ],
                    ),
                  );
                },
                type: StepperType.horizontal,
                steps: <Step>[
                  Step(
                    state: currentStep > 0 ? StepState.complete : StepState.indexed,
                      isActive: currentStep >= 0,
                      title: Text("SĐT",
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2
                              ?.copyWith(fontWeight: FontWeight.bold)),
                      content: PhoneNumberForm(
                          phoneNumberKey: phoneNumberKey,
                        phoneNumberCallBack: (phoneNumber) => viewModel.userModel.phoneNumber = phoneNumber?.trim(),
                      ),
                  ),
                  Step(
                    state: currentStep > 1 ? StepState.complete : StepState.indexed,
                    isActive: currentStep >= 1,
                    title: Text("Mã OTP",
                        style: Theme.of(context).textTheme.bodyText2),
                    content: Column(
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
                          viewModel.userModel.phoneNumber ?? "",
                          style: context.textStyle(color: AppColors.primaryColor).w700.size16,
                        ),
                        const SizedBox(height: 15),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: PinCodeTextField(
                            length: 6,
                            obscureText: false,
                            animationType: AnimationType.fade,
                            keyboardType: TextInputType.phone,
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
                            errorAnimationController: errorController,
                            onCompleted: (v) {},
                            onChanged: (value) {
                              print(value);
                            },
                            beforeTextPaste: (text) {
                              //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                              //but you can show anything you want here, like your pop up saying wrong paste format or etc
                              return true;
                            },
                            appContext: context,
                          ),
                        ),
                        const SizedBox(height: 5),
                        viewModel.isExpired
                            ? Text('Mã OTP hết hạn', style: context.textStyle(color: AppColors.primaryColor).w700.size14.fontQuicksand)
                            : Text('Mã OTP hết hạn sau ${viewModel.remainingTime}s', style: context.textStyle(color: AppColors.primaryColor).w700.size14.fontQuicksand),
                        const SizedBox(height: 5),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: GestureDetector(
                            onTap: () {
                              // textEditingController.text = '';
                              viewModel.resendOTP();
                            },
                            child: Visibility(
                              visible: viewModel.isExpired,
                              child: Text(
                                'Gửi lại OTP',
                                style: context.textStyle(color: Colors.red).size14.fontQuicksand,
                              ),
                            ),
                          ),
                        ),
                        // const SizedBox(height: 15),
                        // Padding(
                        //   padding: const EdgeInsets.symmetric(horizontal: 20),
                        //   child: Row(
                        //     children: [
                        //       Expanded(
                        //         child: SolidButton(
                        //           text: 'XÁC NHẬN',
                        //           isActive: !viewModel.isExpired && viewModel.otp.length == 6,
                        //           onPressed: () {
                        //             // viewModel.verifyOTP(errorCallback: (message) {
                        //             //   context.showMessage(message);
                        //             // }, successCallback: (message) {
                        //             //   Navigator.pushNamedAndRemoveUntil(context, PageRoutes.main, ModalRoute.withName(PageRoutes.enterPhoneNumber));
                        //             //   //show dialog
                        //             // });
                        //           },
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        // Padding(
                        //   padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom + 20),
                        // )
                      ],
                    ),
                  ),
                  Step(
                    isActive: currentStep >= 2,
                    title: Text("Thông tin",
                        style: Theme.of(context).textTheme.bodyText2),
                    content: InformationForm(
                      informationKey: informationKEy,
                      userNameCallBack: (userName) {
                        viewModel.userModel.userName = userName?.trim();
                      },
                      passwordCallBack: (password) {
                        viewModel.userModel.userName = password?.trim();
                      },
                      nameCallBack: (name) {
                        viewModel.userModel.userName = name?.trim();
                      },
                      emailCallBack: (email) {
                        viewModel.userModel.userName = email?.trim();
                      },
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

class SolidButton extends StatelessWidget {
  final String text;
  final bool isActive;
  final VoidCallback onPressed;

  const SolidButton({Key? key, required this.text, this.isActive = true, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: !isActive,
      child: ElevatedButton(
        onPressed: () {
          if (isActive) onPressed.call();
        },
        style: ButtonStyle(
          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(const EdgeInsets.symmetric(vertical: 10)),
          backgroundColor: MaterialStateProperty.all<Color>(isActive ? AppColors.primaryColor : AppColors.primaryColor.withOpacity(0.4)),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(7),
          ),
          ),
        ),
        child: Text(
          text,
          style: context.textStyle(color: AppColors.textWhite).size16.w700.fontQuicksand,
        ),
      ),
    );
  }
}

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
            labelWidget: const Text('Số điện thoại'),
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
            "Nhập số điện thoại của bạn",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          CustomInputField(
            onChanged: (value) => userNameCallBack?.call(value),
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
            onChanged: (value) => passwordCallBack?.call(value),
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
            onChanged: (value) => nameCallBack?.call(value),
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
            onChanged: (value) => emailCallBack?.call(value),
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
        ],
      ),
    );
  }
}
