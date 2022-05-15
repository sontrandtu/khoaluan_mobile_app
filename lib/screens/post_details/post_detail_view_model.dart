import 'package:khoaluan_mobile_app/base/base_view_model.dart';
import 'package:khoaluan_mobile_app/model/post_details_model.dart';

import '../../repository/post_repository.dart';

class PostDetailsViewModel extends BaseViewModel{
  PostRepository postRepo;
  final String postId;

  PostDetailsModel postDetailsModel = PostDetailsModel();

  PostDetailsViewModel({required this.postRepo, required this.postId}) : super(postRepo){
    getData();
  }

  Future<void> getData() async{

    setLoading = true;
    final response = await postRepo.getDetailsPostById(postId: postId);
    if(response.isOk){
      postDetailsModel = response.data ?? PostDetailsModel();
    }
    setLoading = false;
  }


  String imageUrl(String url) {
    return url.replaceAll("localhost", "10.0.2.2");
  }

}