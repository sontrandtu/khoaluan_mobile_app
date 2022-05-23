import 'dart:developer';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:khoaluan_mobile_app/api/api_response.dart';
import 'package:khoaluan_mobile_app/base/base_view_model.dart';
import 'package:khoaluan_mobile_app/model/add_post_model.dart';
import 'package:khoaluan_mobile_app/model/category_model.dart';
import 'package:khoaluan_mobile_app/model/gender_model.dart';
import 'package:khoaluan_mobile_app/model/get_lat_lng_model.dart';
import 'package:khoaluan_mobile_app/model/location_model.dart';
import 'package:khoaluan_mobile_app/model/post_address_model.dart';
import 'package:khoaluan_mobile_app/model/user_model.dart';
import 'package:khoaluan_mobile_app/repository/category_repository.dart';
import 'package:khoaluan_mobile_app/repository/location_repository.dart';
import 'package:khoaluan_mobile_app/repository/post_repository.dart';
import 'package:khoaluan_mobile_app/repository/user_repository.dart';
import 'package:firebase_core/firebase_core.dart' as firebase_core;


class AddPostViewModel extends BaseViewModel{
  PostRepository postRepo;
  UserRepository userRepo;
  LocationRepository locationRepo;
  CategoryRepository categoryRepo;

  LocationModel? locationModel;
  AddPostModel addPostModel = AddPostModel();
  Info info = Info();
  List<File> selectedImages = [];
  List<String> listImagesLink = [];
  List<CategoryModel> categories = [];
  UserModel? userModel = UserModel();
  List<GenderModel> gender = [
    GenderModel(name: "Nam", id: "male"),
    GenderModel(name: "Nữ", id: "female"),
    GenderModel(name: "Tất cả", id: "all"),
  ];

  String? cityName;
  String? districtName;
  String? streetName;
  PostAddressModel? address = PostAddressModel();
  LatLngModel latLng = LatLngModel();


  AddPostViewModel({required this.postRepo, required this.userRepo, required this.locationRepo,  required this.categoryRepo}) : super(postRepo){
    getData();
  }

  updateImages(List<String> listPath){
    selectedImages = listPath.map((e) => File(e)).toList();
    notifyListeners();
  }

  updateAddress(){
    address?.address = "$streetName, $districtName, $cityName";
    notifyListeners();
  }

  updateData(){
    notifyListeners();
  }

  Future<void> getData() async{
    setLoading = true;
    final response = await Future.wait([locationRepo.getLocation(), categoryRepo.getCategories(), userRepo.getInfo()]);
    if(response[0].isOk){
      locationModel = (response[0] as ApiResponse<LocationModel>).data ?? LocationModel();
    }
    if(response[1].isOk){
      categories = response[1].data as List<CategoryModel>;
    }
    if(response[2].isOk){
      userModel = response[2].data as UserModel;
    }
    setLoading = false;
  }

  // Future<void> addMultiImages() async{
  //   setLoading = true;
  //   final response = await postRepo.addMultiImages(listImages: selectedImages);
  //   if(response.isOk){
  //     listImagesLink = response.data ?? [];
  //   }
  //   setLoading = false;
  // }


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

  Future<void> getLatLng() async{
    final response = await locationRepo.getLatLng(address: address);
    if(response.isOk){
      latLng = response.data ?? LatLngModel();
      log(response.data?.rootLocation ?? '');
    }
  }

  addPost({SuccessCallback? successCallback, ErrorCallback? errorCallback}) async{
    setLoading = true;
    await getLatLng();
    await uploadMultiImage();
    info.rootLocation = latLng.rootLocation;
    info.infoConnect = userModel?.phoneNumber;
    info.imagePost = listImagesLink[0];
    info.userId = userModel?.id;
    info.street = streetName;
    info.address = address?.address;
    addPostModel.info = info;
    addPostModel.relatedImages = listImagesLink.map((e) => RelatedImage(url: e)).toList();
    final response = await postRepo.addPost(post: addPostModel);
    if(response.isOk){
      successCallback?.call("Đăng bài thành công");
      clearData();
    }else{
      errorCallback?.call(response.messages);
    }
    setLoading = false;
  }

  clearData(){
    addPostModel = AddPostModel();
    info = Info();
    listImagesLink.clear();
    selectedImages.clear();
    notifyListeners();
  }

  // Future<void> addImage() async{
  //   setLoading = true;
  //   final response = await postRepo.addImage(image: selectedImages[0]);
  //   if(response.isOk){
  //     listImagesLink.add(response.data ?? ImageModel()) ;
  //   }
  //   setLoading = false;
  // }
}