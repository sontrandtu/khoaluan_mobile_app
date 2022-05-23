import 'package:khoaluan_mobile_app/base/base_view_model.dart';
import 'package:khoaluan_mobile_app/repository/post_repository.dart';

class EditPostViewModel extends BaseViewModel{

  PostRepository postRepo;
  EditPostViewModel({required this.postRepo}) : super(postRepo);

}