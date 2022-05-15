import 'package:khoaluan_mobile_app/api/dio_helper.dart';
import 'package:khoaluan_mobile_app/api/res_client.dart';
import 'package:khoaluan_mobile_app/model/location_model.dart';
import 'package:khoaluan_mobile_app/repository/repository.dart';

import '../api/api_response.dart';

class LocationRepository extends Repository{

  Future<ApiResponse<LocationModel>> getLocation() async {
    return await RestClient(
      DioHelper.dioObject!,
      baseUrl: "http://192.168.0.3:3000/api"
    ).getLocation().wrap();
  }
}