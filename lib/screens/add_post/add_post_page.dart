import 'package:flutter/material.dart';
import 'package:khoaluan_mobile_app/screens/add_post/add_post_view_model.dart';
import 'package:khoaluan_mobile_app/theme/app_bar.dart';
import 'package:khoaluan_mobile_app/utils/dialog_utils.dart';
import 'package:khoaluan_mobile_app/utils/extensions/context_extension.dart';
import 'package:dotted_decoration/dotted_decoration.dart';
import 'package:khoaluan_mobile_app/widgets/buttons/custom_default_button.dart';
import 'package:khoaluan_mobile_app/widgets/buttons/custom_drop_down_button.dart';
import 'package:khoaluan_mobile_app/widgets/cover_loading.dart';
import 'package:khoaluan_mobile_app/widgets/field/custom_input_field.dart';
import 'package:provider/provider.dart';

import '../../theme/color.dart';

class AddPostPage extends StatefulWidget {
  const AddPostPage({Key? key}) : super(key: key);


  @override
  State<AddPostPage> createState() => _AddPostPageState();
}

class _AddPostPageState extends State<AddPostPage> {

  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  TextEditingController? controller;

  bool? _isValidCity;
  bool? _isValidDistrict;
  bool? _isValidCategories;
  bool? _isValidHumanType;

  @override
  void initState() {
    _isValidCity = false;
    _isValidDistrict = false;
    _isValidCategories = false;
    _isValidHumanType = false;
    controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    controller?.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.hideKeyboard(),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: const DefaultAppBar(title: "Đăng bài"),
        body: Consumer<AddPostViewModel>(
          builder: (context, viewModel, child) => SafeArea(
            child: CoverLoading(
              isStack: true,
              showLoading: viewModel.isLoading,
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(bottom: 32),
                physics: const ClampingScrollPhysics(),
                child: Form(
                  key: globalKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 16, left: 16, top: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 12),
                              child: Text(
                                'Địa chỉ cho thuê:',
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textBlack),
                              ),
                            ),
                            CustomDropdownButton(
                              isValidate: _isValidCity ?? false,
                              data: viewModel.locationModel?.city ?? [],
                              placeholderText: "Tỉnh/Thành phố",
                              type: 1,
                              onSelectedCallback: (city){
                                viewModel.cityName = city.name;
                                viewModel.info.cityId = city.code;
                                if(viewModel.cityName != null){
                                  setState(() => _isValidCity = false);
                                }
                              },
                            ),
                            CustomDropdownButton(
                              isValidate: _isValidDistrict ?? false,
                              data: viewModel.locationModel?.districts ?? [],
                              placeholderText: "Quận/Huyện",
                              type: 1,
                              onSelectedCallback: (district){
                                setState(() {
                                  viewModel.districtName = district.name;
                                  viewModel.info.districtId = district.code;
                                  if(viewModel.districtName != null){
                                    _isValidDistrict = false;
                                  }
                                });
                              },
                            ),
                            const SizedBox(height: 8),
                            CustomInputField(
                              onChanged: (value){
                                viewModel.streetName = value.toString().trim();
                                viewModel.updateAddress();
                              },
                              prefixIcon: const Icon(Icons.place_outlined, color: Colors.black),
                              labelWidget: RichText(
                                text: TextSpan(
                                  children: [
                                    const TextSpan(text: '* ', style: TextStyle(color: Colors.red,fontWeight: FontWeight.w400, fontFamily: 'Roboto', fontSize: 14)),
                                    TextSpan(text: 'Địa chỉ cụ thể',style: TextStyle(color: Colors.black.withOpacity(0.4), fontFamily: 'Roboto', fontSize: 14),),
                                  ],
                                ),
                              ),
                              validator: (value){
                                if(value!.isEmpty){
                                  return "Vui lòng nhập địa chỉ cụ thể";
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 20),
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                      text: 'Địa chỉ: ',
                                      style: Theme.of(context).textTheme.bodyText2?.copyWith(color: Colors.black, fontWeight: FontWeight.w700),
                                  ),
                                  TextSpan(text: viewModel.address?.address ?? "",
                                    style:Theme.of(context).textTheme.bodyText2?.copyWith(color: Colors.black, fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 20),
                              child: Text(
                                'Thông tin liên hệ:',
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textBlack),
                              ),
                            ),
                            CustomInputField(
                              value: viewModel.userModel?.phoneNumber,
                              onChanged: (value){
                                viewModel.userModel?.phoneNumber = value.trim();
                              },
                              prefixIcon: const Icon(Icons.call_outlined, color: Colors.black),
                              labelWidget: RichText(
                                text: TextSpan(
                                  children: [
                                    const TextSpan(text: '* ', style: TextStyle(color: Colors.red,fontWeight: FontWeight.w400, fontFamily: 'Roboto', fontSize: 14)),
                                    TextSpan(text: 'Số điện thoại',style: TextStyle(color: Colors.black.withOpacity(0.4), fontFamily: 'Roboto', fontSize: 14),),
                                  ],
                                ),
                              ),

                              maxLength: 10,
                              keyboardType: TextInputType.phone,
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
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 20),
                              child: Text(
                                'Thông tin mô tả:',
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textBlack),
                              ),
                            ),
                            CustomDropdownButton(
                              isValidate: _isValidCategories ?? false,
                              icons: Icons.house_outlined,
                              data: viewModel.categories,
                              placeholderText: "Danh mục",
                              type: 1,
                              onSelectedCallback: (category){
                                viewModel.info.categoryId = category.id;
                                if(viewModel.info.categoryId != null){
                                  setState(() => _isValidCategories = false);
                                }
                              },
                            ),
                            CustomDropdownButton(
                              isValidate: _isValidHumanType ?? false,
                              icons: Icons.person_search_outlined,
                              data: viewModel.gender,
                              placeholderText: "Đối tượng cho thuế",
                              type: 1,
                              onSelectedCallback: (objectType){
                                viewModel.info.objectId = objectType.id;
                                if(viewModel.info.objectId != null){
                                  setState(() => _isValidHumanType = false);
                                }
                              },
                            ),
                            const SizedBox(height: 8),
                            CustomInputField(
                              prefixIcon: const Icon(Icons.subtitles_outlined, color: Colors.black),
                              labelWidget: RichText(
                                text: TextSpan(
                                  children: [
                                    const TextSpan(text: '* ', style: TextStyle(color: Colors.red,fontWeight: FontWeight.w400, fontFamily: 'Roboto', fontSize: 14)),
                                    TextSpan(text: 'Tiêu đề',style: TextStyle(color: Colors.black.withOpacity(0.4), fontFamily: 'Roboto', fontSize: 14),),
                                  ],
                                ),
                              ),
                              validator: (value){
                                if(value!.isEmpty){
                                  return "Vui lòng nhập địa chỉ cụ thể";
                                }
                                return null;
                              },
                              onChanged: (value){
                                viewModel.info.title = value.trim();
                              },
                            ),
                            const SizedBox(height: 20),
                            TextFormField(
                              controller: controller,
                              maxLines: 4,
                              decoration: InputDecoration(
                                fillColor: Colors.white,
                                  filled: true,
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: AppColors.primaryColor),
                                      borderRadius: BorderRadius.circular(8)),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.grey.withOpacity(0.5)),
                                      borderRadius: BorderRadius.circular(8)),
                                  errorBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(color: Colors.red),
                                      borderRadius: BorderRadius.circular(8)),
                                  focusedErrorBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(color: Colors.red),
                                      borderRadius: BorderRadius.circular(8)),
                                  disabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.grey.withOpacity(0.5)),
                                      borderRadius: BorderRadius.circular(8)),
                                  label: RichText(
                                    text: TextSpan(
                                      children: [
                                        const TextSpan(text: '* ', style: TextStyle(color: Colors.red,fontWeight: FontWeight.w400, fontFamily: 'Roboto', fontSize: 14)),
                                        TextSpan(text: 'Mô tả chi tiết',style: TextStyle(color: Colors.black.withOpacity(0.4), fontFamily: 'Roboto', fontSize: 14),),
                                      ],
                                    ),
                                  ),
                                  hintText: ": diện tích phòng, màu sơn, nội thất, ..."
                              ),
                              onChanged: (value){
                                viewModel.info.description = value.trim();
                              },
                            ),
                            const Padding(
                              padding:  EdgeInsets.symmetric(vertical: 20),
                              child:  Text(
                                'Giá cả:',
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textBlack),
                              ),
                            ),
                            CustomInputField(
                              keyboardType: TextInputType.number,
                              prefixIcon: const Icon(Icons.attach_money_outlined, color: Colors.black),
                              labelWidget: RichText(
                                text: TextSpan(
                                  children: [
                                    const TextSpan(text: '* ', style: TextStyle(color: Colors.red,fontWeight: FontWeight.w400, fontFamily: 'Roboto', fontSize: 14)),
                                    TextSpan(text: 'Giá cho thuê',style: TextStyle(color: Colors.black.withOpacity(0.4), fontFamily: 'Roboto', fontSize: 14),),
                                  ],
                                ),
                              ),
                              validator: (value){
                                if(value!.isEmpty){
                                  return "Vui lòng nhập giá cho thuê";
                                }
                                return null;
                              },
                              onChanged: (value){
                                viewModel.info.price = int.parse(value.trim());
                              },
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Hình ảnh thực tế:',
                                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textBlack),
                                  ),
                                  ElevatedButton(
                                    child: const Text("Chọn hình ảnh"),
                                    onPressed: () {
                                      showModalBottomSheetImage(
                                        context: context,
                                        isMulti: true,
                                        listImageCallback: (pathImages){
                                          viewModel.updateImages(pathImages);
                                        },
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),

                          ],
                        ),
                      ),
                      viewModel.selectedImages.isEmpty ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20).copyWith(bottom: 12),
                        child: Container(
                            alignment: Alignment.center,
                            height: 120,
                            width: double.infinity,
                            decoration: DottedDecoration(
                              strokeWidth: 2,
                              color: Colors.grey,
                              shape: Shape.box,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Text(
                              'Chọn hình ảnh thực tế cho phòng trọ'
                                  '\n(Ít nhất ba ảnh và tối đa 10 ảnh)',
                              textAlign: TextAlign.center,
                            )
                        ),
                      ) : SizedBox(
                        height: 120,
                        child: ListView.separated(
                          padding: const EdgeInsets.symmetric(horizontal: 20).copyWith(bottom: 12),
                          scrollDirection: Axis.horizontal,
                          itemCount: viewModel.selectedImages.length,
                          itemBuilder: (context, index) => SizedBox(
                            height: 100,
                            width: 100,
                            child: Image.file(viewModel.selectedImages[index], fit: BoxFit.cover),
                          ),
                          separatorBuilder: (_, __) {
                            return const SizedBox(width: 12);
                          },
                        ),
                      ),
                      const SizedBox(height: 20),
                      CustomDefaultButton(
                        height: 52,
                        padding: 16,
                        title: "Đăng bài",
                        onTap: (){
                          if(globalKey.currentState!.validate()
                              && viewModel.cityName != null
                              && viewModel.districtName != null
                              && viewModel.info.categoryId != null
                              && viewModel.info.objectId != null
                              && viewModel.selectedImages.isNotEmpty
                          ){
                            viewModel.addPost(
                              errorCallback: (error){
                                context.showMessage(error, type: MessageType.error);
                              },
                              successCallback: (message){
                                context.showMessage(message, type: MessageType.success);
                                Navigator.of(context).pop();
                                setState(() {
                                  controller?.clear();
                                });
                              }
                            );
                          } else {
                            context.showMessage("Bạn vui lòng điền đầy đủ thông tin", type: MessageType.error);
                            if(viewModel.cityName == null){
                              setState(() => _isValidCity = true);
                            }
                            if(viewModel.districtName == null){
                              setState(() => _isValidDistrict = true);
                            }
                            if(viewModel.info.categoryId == null){
                              setState(() => _isValidCategories = true);
                            }
                            if(viewModel.info.objectId == null){
                              setState(() => _isValidHumanType = true);
                            }
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
