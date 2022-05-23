import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:khoaluan_mobile_app/widgets/buttons/custom_default_button.dart';
import 'package:khoaluan_mobile_app/screens/login_and_register/register/register_view_model.dart';
import 'package:khoaluan_mobile_app/theme/app_bar.dart';
import 'package:khoaluan_mobile_app/utils/extensions/context_extension.dart';
import 'package:khoaluan_mobile_app/widgets/cover_loading.dart';
import 'package:provider/provider.dart';

import '../../../page_routes.dart';
import 'components/information_form.dart';
import 'components/phone_number_form.dart';
import 'components/verify_phone_number_form.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  int currentStep = 0;
  GlobalKey<FormState> phoneNumberKey = GlobalKey<FormState>();
  GlobalKey<FormState> informationKEy = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool isPassPhoneNumber = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
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
          key: _scaffoldKey,
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
                                  viewModel.registerUser(
                                    errorCallback: (error){
                                      Fluttertoast.showToast(msg: error ?? "Có lỗi xảy ra, vui lòng thử lại", backgroundColor: Colors.red);
                                    },
                                    successCallback: (mes){
                                      Fluttertoast.showToast(msg: mes, backgroundColor: Colors.green);
                                      Navigator.of(_scaffoldKey.currentContext!, rootNavigator: true)
                                          .pushNamedAndRemoveUntil(
                                          PageRoutes.loginPage, (route) => false);;
                                    }
                                  );
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
                                  if(viewModel.otp.length == 6){
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
                        phoneNumberCallBack: (phoneNumber) => viewModel.userModel.phoneNumber = phoneNumber?.trim(),
                      ),
                  ),
                  Step(
                    state: currentStep > 1 ? StepState.complete : StepState.indexed,
                    isActive: currentStep >= 1,
                    title: Text("Mã OTP",
                        style: Theme.of(context).textTheme.bodyText2),
                    content: VerifyOTPForm(
                      phoneNumber: viewModel.userModel.phoneNumber,
                      otpCallBack: (otp){
                        viewModel.otp = otp ?? '';
                      },
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
                        viewModel.userModel.password = password?.trim();
                      },
                      nameCallBack: (name) {
                        viewModel.userModel.name = name?.trim();
                      },
                      emailCallBack: (email) {
                        viewModel.userModel.email = email?.trim();
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



