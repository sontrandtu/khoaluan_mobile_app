import 'dart:io';

import 'package:flutter/material.dart';
import 'package:khoaluan_mobile_app/screens/update_user/update_user_view_model.dart';
import 'package:khoaluan_mobile_app/theme/app_bar.dart';
import 'package:khoaluan_mobile_app/theme/color.dart';
import 'package:khoaluan_mobile_app/utils/dialog_utils.dart';
import 'package:khoaluan_mobile_app/utils/extensions/context_extension.dart';
import 'package:khoaluan_mobile_app/widgets/buttons/custom_default_button.dart';
import 'package:khoaluan_mobile_app/widgets/cover_loading.dart';
import 'package:khoaluan_mobile_app/widgets/custom_cached_network_image.dart';
import 'package:khoaluan_mobile_app/widgets/field/custom_input_field.dart';
import 'package:provider/provider.dart';
import 'package:khoaluan_mobile_app/utils/extensions/string_extension.dart';

class UpdateUserPage extends StatefulWidget {
  const UpdateUserPage({Key? key}) : super(key: key);

  @override
  State<UpdateUserPage> createState() => _UpdateUserPageState();
}

class _UpdateUserPageState extends State<UpdateUserPage> {

  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  File? selectedImage;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.hideKeyboard(),
      child: Scaffold(
        appBar: const DefaultAppBar(title: "Thông tin tài khoản"),
        body: Consumer<UpdateUserViewModel>(
          builder: (context, viewModel, child) => CoverLoading(
            showLoading: viewModel.isLoading,
            isStack: true,
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Form(
                key: globalKey,
                child: Column(
                  children: [
                    Stack(
                      children: [
                        GestureDetector(
                            onTap: (){
                              showModalBottomSheetImage(
                                  context: context,
                                  isMulti: false,
                                  imageCallBack: (image){
                                    setState(() {
                                      selectedImage = File(image);
                                      viewModel.image = selectedImage;
                                    });
                                  }
                              );
                            },
                            child: (selectedImage != null ) ? CircleAvatar(
                              radius: 40,
                              backgroundImage: FileImage(selectedImage!),
                            ) : CustomNetworkImage(
                              url: viewModel.userModel.imageUrl?.imageUrl ?? '',
                              width: 80,
                              height: 80,
                              isCircle: true,
                            )
                        ),
                        Positioned(
                            bottom: 0,
                            right: 0,
                            child:Icon(Icons.camera_alt_outlined, color: AppColors.primaryColor, size: 20,),
                        )
                      ],
                    ),
                    const SizedBox(height: 44),
                    CustomInputField(
                      labelWidget: RichText(
                        text: TextSpan(
                          children: [
                            const TextSpan(text: '* ', style: TextStyle(color: Colors.red,fontWeight: FontWeight.w400, fontFamily: 'Roboto', fontSize: 14)),
                            TextSpan(text: 'Tên đăng nhập',style: TextStyle(color: Colors.black.withOpacity(0.4), fontFamily: 'Roboto', fontSize: 14),),
                          ],
                        ),
                      ),
                      value: viewModel.userModel.userName,
                      enabled: false,
                    ),
                    const SizedBox(height: 20),
                    CustomInputField(
                      labelWidget: RichText(
                        text: TextSpan(
                          children: [
                            const TextSpan(text: '* ', style: TextStyle(color: Colors.red,fontWeight: FontWeight.w400, fontFamily: 'Roboto', fontSize: 14)),
                            TextSpan(text: 'Tên hiển thị',style: TextStyle(color: Colors.black.withOpacity(0.4), fontFamily: 'Roboto', fontSize: 14),),
                          ],
                        ),
                      ),
                      value: viewModel.userModel.name,
                      onChanged: (value){
                        viewModel.userModel.name = value.trim();
                      },
                      validator: (value){
                        if(value!.isEmpty){
                          return "Tên hiển thị không được để trống";
                        }
                        if(value.length <=6){
                          return "Tên hiển thị phải nhiều hơn 5 kí tự";
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
                            TextSpan(text: 'Email',style: TextStyle(color: Colors.black.withOpacity(0.4), fontFamily: 'Roboto', fontSize: 14),),
                          ],
                        ),
                      ),
                      value: viewModel.userModel.email,
                    ),
                    const SizedBox(height: 20,),
                    CustomInputField(
                      enabled: false,
                      labelWidget: RichText(
                        text: TextSpan(
                          children: [
                            const TextSpan(text: '* ', style: TextStyle(color: Colors.red,fontWeight: FontWeight.w400, fontFamily: 'Roboto', fontSize: 14)),
                            TextSpan(text: 'Số điện thoại',style: TextStyle(color: Colors.black.withOpacity(0.4), fontFamily: 'Roboto', fontSize: 14),),
                          ],
                        ),
                      ),
                      value: viewModel.userModel.phoneNumber,
                    ),
                    const SizedBox(height: 44),
                    CustomDefaultButton(
                      onTap: (){
                        if(globalKey.currentState!.validate()){
                          viewModel.updateUser(
                              successCallback: (mes){
                                context.showMessage(mes, type: MessageType.success);
                              },
                              errorCallback: (error){
                                context.showMessage(error, type: MessageType.error);
                              }
                          );
                        } else{
                          context.showMessage("Bạn vui lòng điền đầy đủ thông tin", type: MessageType.error);
                        }
                      },
                      padding: 10,
                      height: 50,
                      title: "Lưu thay đổi",
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
