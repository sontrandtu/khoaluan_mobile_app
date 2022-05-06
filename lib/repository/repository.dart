
import '../api/dio_helper.dart';
import '../api/res_client.dart';
import '../preference/preference.dart';

class Repository {
  RestClient? apiClient;

  Repository() {
    apiClient = RestClient(DioHelper.dioObject!);
  }

  String? get accessToken => PreferenceManager.getValue<String>(PreferenceManager.KEY_TOKEN);

}
