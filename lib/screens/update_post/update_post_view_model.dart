
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:khoaluan_mobile_app/base/base_view_model.dart';
import 'package:khoaluan_mobile_app/model/category_model.dart';
import 'package:khoaluan_mobile_app/model/location_model.dart';
import 'package:khoaluan_mobile_app/model/my_post_model.dart';
import 'package:khoaluan_mobile_app/model/update_post_model.dart';
import 'package:khoaluan_mobile_app/repository/category_repository.dart';
import 'package:khoaluan_mobile_app/repository/location_repository.dart';
import 'package:khoaluan_mobile_app/repository/post_repository.dart';
import 'package:collection/collection.dart';
import 'package:firebase_core/firebase_core.dart' as firebase_core;

import '../../model/gender_model.dart';

class UpdatePostViewModel extends BaseViewModel{

  PostRepository postRepo;
  CategoryRepository categoryRepo;
  LocationRepository locationRepo;
  UpdatePostModel? updatePostModel = UpdatePostModel();
  Info? info = Info();
  List<NewRelatedImage>? newRelatedImages;
  List<OldRelatedImage>? oldRelatedImages;
  List<CategoryModel> categories = [];
  List<File> selectedImages = [];
  List<String> listImagesLink = [];
  String city = '';
  List<GenderModel> gender = [
    GenderModel(name: "Nam", id: "male"),
    GenderModel(name: "Nữ", id: "female"),
    GenderModel(name: "Tất cả", id: "all"),
  ];
  String district = '';
  LocationModel locationModel = LocationModel();
  DataPost dataPost;

  UpdatePostViewModel({required this.categoryRepo, required this.postRepo, required this.locationRepo, required this.dataPost}) : super(postRepo) {
    getData();
  }
  updateImages(List<String> listPath){
    selectedImages = listPath.map((e) => File(e)).toList();
    notifyListeners();
  }

  Future<void> getData() async{
    setLoading = true;
    final response = await Future.wait([locationRepo.getLocation(), categoryRepo.getCategories()]);
    if(response[0].isOk){
      locationModel = response[0].data as LocationModel;
      city = locationModel.city?[0].name ?? '';
      district = locationModel.districts?.singleWhereOrNull((element) => element.code == int.parse(dataPost.districtId.toString()))?.name ?? '';
    }
    if(response[1].isOk){
      categories = response[1].data as List<CategoryModel>;
    }
    info?.categoryId = dataPost.categoryId;
    info?.description = dataPost.description;
    info?.cityId = dataPost.cityId;
    info?.countDay = dataPost.countDay;
    info?.id = dataPost.id;
    info?.imagePost = dataPost.imagePost;
    info?.objectId = dataPost.objectId;
    info?.price = dataPost.price;
    info?.status = dataPost.status;
    info?.title = dataPost.title;
    info?.userId = dataPost.userId;
    info?.districtId = dataPost.districtId;
    oldRelatedImages = dataPost.relatedImagesLists?.map((e) => OldRelatedImage(id: e.id, url: e.url)).toList();
    setLoading = false;
  }

  uploadMultiImage({ErrorCallback? errorCallback}) async {
    setLoading = true;
    final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
    for(File f in selectedImages){
      try{
        var snapshot = await _firebaseStorage.ref('images/${f.path}').putFile(f);
        String downloadUrl = await snapshot.ref.getDownloadURL();
        listImagesLink.add(downloadUrl);
      } on firebase_core.FirebaseException catch (e){
        errorCallback?.call("Upload ảnh thất bại, vui lòng thử lại");
      }
    }
    setLoading = false;
  }

  Future<void> updatePost({ErrorCallback? errorCallback, SuccessCallback? successCallback}) async{
    setLoading = true;
    if(selectedImages.isEmpty){
      updatePostModel?.newRelatedImage = oldRelatedImages?.map((e) => NewRelatedImage(url: e.url)).toList();
    } else{
      await uploadMultiImage();
      updatePostModel?.newRelatedImage = listImagesLink.map((e) => NewRelatedImage(url: e)).toList();
      info?.imagePost = listImagesLink.first;
    }

    updatePostModel?.info = info;
    final response = await postRepo.updatePost(postId: dataPost.id,updatePostModel: updatePostModel);
    if(response.isOk){
      successCallback?.call("Cập nhật bài viết thành công");
    }else{
      errorCallback?.call(response.messages);
    }
    setLoading = false;
  }

  String? get categoryName{
    return categories.singleWhereOrNull((element) => element.id == dataPost.categoryId)?.name;
  }

  String? get objectName{
    return gender.singleWhereOrNull((element) => element.id == dataPost.objectId)?.name;
  }



}