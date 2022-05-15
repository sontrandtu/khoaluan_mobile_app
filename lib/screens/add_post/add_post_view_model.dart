import 'dart:io';

import 'package:khoaluan_mobile_app/api/api_response.dart';
import 'package:khoaluan_mobile_app/base/base_view_model.dart';
import 'package:khoaluan_mobile_app/model/add_post_model.dart';
import 'package:khoaluan_mobile_app/model/category_model.dart';
import 'package:khoaluan_mobile_app/model/gender_model.dart';
import 'package:khoaluan_mobile_app/model/image_model.dart';
import 'package:khoaluan_mobile_app/model/location_model.dart';
import 'package:khoaluan_mobile_app/model/user_model.dart';
import 'package:khoaluan_mobile_app/repository/category_repository.dart';
import 'package:khoaluan_mobile_app/repository/location_repository.dart';
import 'package:khoaluan_mobile_app/repository/post_repository.dart';
import 'package:khoaluan_mobile_app/repository/user_repository.dart';


class AddPostViewModel extends BaseViewModel{
  PostRepository postRepo;
  UserRepository userRepo;
  LocationRepository locationRepo;
  CategoryRepository categoryRepo;

  LocationModel? locationModel;
  AddPostModel addPostModel = AddPostModel();
  Info info = Info();
  List<File> selectedImages = [];
  List<ImageModel> listImagesLink = [];
  List<CategoryModel> categories = [];
  UserModel? userModel = UserModel();
  List<GenderModel> gender = [
    GenderModel(name: "Nam", id: "male"),
    GenderModel(name: "Nữ", id: "female"),
  ];

  String? cityName;
  String? districtName;
  String? streetName;
  String? address;


  AddPostViewModel({required this.postRepo, required this.userRepo, required this.locationRepo,  required this.categoryRepo}) : super(postRepo){
    getData();
  }

  updateImages(List<String> listPath){
    selectedImages = listPath.map((e) => File(e)).toList();
    notifyListeners();
  }

  updateAddress(){
    address = "$streetName, $districtName, $cityName";
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

  Future<void> addMultiImages() async{
    setLoading = true;
    final response = await postRepo.addMultiImages(listImages: selectedImages);
    if(response.isOk){
      listImagesLink = response.data ?? [];
    }
    setLoading = false;
  }

  Future<void> addImage() async{
    setLoading = true;
    final response = await postRepo.addImage(image: selectedImages[0]);
    if(response.isOk){
      listImagesLink.add(response.data ?? ImageModel()) ;
    }
    setLoading = false;
  }
}