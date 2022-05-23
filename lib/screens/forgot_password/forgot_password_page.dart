import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:khoaluan_mobile_app/screens/forgot_password/components/new_password_form.dart';
import 'package:khoaluan_mobile_app/screens/forgot_password/forgot_password_view_model.dart';
import 'package:khoaluan_mobile_app/theme/app_bar.dart';
import 'package:khoaluan_mobile_app/utils/extensions/context_extension.dart';
import 'package:provider/provider.dart';

import '../../page_routes.dart';
import '../../widgets/buttons/custom_default_button.dart';
import '../../widgets/cover_loading.dart';
import '../login_and_register/register/components/phone_number_form.dart';
import '../login_and_register/register/components/verify_phone_number_form.dart';
class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  int currentStep = 0;
  GlobalKey<FormState> phoneNumberKey = GlobalKey<FormState>();
  GlobalKey<FormState> confirmPasswordKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool isPassPhoneNumber = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.hideKeyboard();
      },
      child:Consumer<ForgotPasswordViewModel>(
        builder: (context, viewModel, child) => Scaffold(
          key: _scaffoldKey,
          resizeToAvoidBottomInset: true,
          appBar: const DefaultAppBar(
            title: "Quên mật khẩu",
            canBack: true,
          ),
          body: CoverLoading(
            showLoading: viewModel.isLoading,
            child: SafeArea(
              child: Stepper(
                currentStep: currentStep,
                physics: const ClampingScrollPhysics(),
                onStepCancel: currentStep == 0 ? null : () => setState(() => currentStep--),
                controlsBuilder: (BuildContext context, ControlsDetails details){
                  return Container(
                    margin: const EdgeInsets.only(top: 50),
                    child: Row(
                      children: [
                        currentStep == 1 ? Expanded(
                          child: CustomDefaultButton(
                            onTap: (){
                              setState(() {
                                currentStep --;
                              });
                            },
                            height: 50,
                            title: "Quay lại".toUpperCase(),
                            padding: 20,
                          ),
                        ) : const SizedBox(),
                        Expanded(
                          child: CustomDefaultButton(
                            onTap: (){
                              if(currentStep == 2){
                                if(confirmPasswordKey.currentState!.validate()){
                                  viewModel.forgotPassword(
                                      errorCallback: (error){
                                        Fluttertoast.showToast(msg: error ?? "Có lỗi xảy ra, vui lòng thử lại", backgroundColor: Colors.red);
                                      },
                                      successCallback: (mes) async{
                                        Fluttertoast.showToast(msg: mes, backgroundColor: Colors.green);
                                        Navigator.of(_scaffoldKey.currentContext!, rootNavigator: true)
                                            .pushNamedAndRemoveUntil(
                                            PageRoutes.loginPage, (route) => false);
                                      }
                                  );
                                }
                              }else if(currentStep == 0){
                                if(phoneNumberKey.currentState!.validate()){
                                  viewModel.getOTP(
                                      successCallback: (mes){
                                        isPassPhoneNumber = true;
                                        setState(() {
                                          currentStep ++;
                                        });
                                      },
                                    errorCallback: (error){
                                        Fluttertoast.showToast(msg: error ?? '', backgroundColor: Colors.red);
                                    }
                                  );
                                } else{
                                  context.showMessage("Bạn vui lòng điền đầy đủ số điện thoại", type: MessageType.error);
                                }
                              } else{
                                if(viewModel.otp?.length == 6){
                                  viewModel.verifyOTP(
                                      successCallback: (mes){
                                        setState(() {
                                          currentStep++;
                                        });
                                        Fluttertoast.showToast(msg: mes, backgroundColor: Colors.green);
                                      },
                                      errorCallback: (error){
                                        Fluttertoast.showToast(msg: error ?? "Có lỗi xảy ra, vui lòng thử lại", backgroundColor: Colors.red);
                                      }
                                  );
                                }else{
                                  context.showMessage("Bạn vui lòng điền đầy đủ mã OTP", type: MessageType.error);

                                }
                              }
                            },
                            height: 50,
                            title: "Tiếp tục".toUpperCase(),
                            padding: 20,
                          ),
                        ),
                        SizedBox(width: currentStep == 1 ? 12 : 0),
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
                      phoneNumberCallBack: (phoneNumber) => viewModel.newPassword?.phoneNumber = phoneNumber,
                    ),
                  ),
                  Step(
                    state: currentStep > 1 ? StepState.complete : StepState.indexed,
                    isActive: currentStep >= 1,
                    title: Text("Mã OTP",
                        style: Theme.of(context).textTheme.bodyText2),
                    content: VerifyOTPForm(
                      phoneNumber: viewModel.newPassword?.phoneNumber,
                      otpCallBack: (otp){
                        viewModel.otp = otp ?? '';
                      },
                    ),
                  ),
                  Step(
                    isActive: currentStep >= 2,
                    title: Text("Thông tin",
                        style: Theme.of(context).textTheme.bodyText2),
                    content: NewPasswordForm(
                      confirmPasswordKey: confirmPasswordKey,
                      newPasswordCallBack: (newPassword) => viewModel.newPassword?.newPassword = newPassword,
                    )
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
