import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:khoaluan_mobile_app/base/base_view_model.dart';
import 'package:khoaluan_mobile_app/model/update_user_model.dart';
import 'package:khoaluan_mobile_app/repository/user_repository.dart';
import 'package:firebase_core/firebase_core.dart' as firebase_core;

class UpdateUserViewModel extends BaseViewModel{
  UserRepository userRepo;

  File? image;
  String? userId = '';
  UpdateUserModel userModel = UpdateUserModel();
  UpdateUserViewModel({required this.userRepo}) : super(userRepo){
    getData();
  }

  Future<void> getData() async{
    setLoading = true;
    final response = await userRepo.getInfo();
    if(response.isOk){
      userModel.name = response.data?.name;
      userModel.phoneNumber = response.data?.phoneNumber;
      userModel.userName = response.data?.userName;
      userModel.email = response.data?.email;
      userModel.imageUrl = response.data?.imageUrl;
      userId = response.data?.id;
    }
    setLoading = false;
  }

  uploadImage({ErrorCallback? errorCallback}) async {
    setLoading = true;
    final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
    try{
      var snapshot = await _firebaseStorage.ref('images/${image?.path}').putFile(image!);
      userModel.imageUrl = await snapshot.ref.getDownloadURL();
    } on firebase_core.FirebaseException catch (e){
      errorCallback?.call("Upload ảnh thất bại, vui lòng thử lại");
    }
    setLoading = false;
  }

  Future<void> updateUser({ErrorCallback? errorCallback, SuccessCallback? successCallback}) async{
    setLoading = true;
    if(image != null){
      await uploadImage();
    }
    final response = await userRepo.updateUser(updateUser: userModel, id: userId);
    if(response.isOk){
      successCallback?.call("Cập nhật user thành công");
    } else{
      errorCallback?.call("Cập nhật thất bại, vui lòng thử lại");
    }
  }
}
