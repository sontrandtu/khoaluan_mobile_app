import 'package:khoaluan_mobile_app/model/get_lat_lng_model.dart';
import 'package:khoaluan_mobile_app/model/location_model.dart';
import 'package:khoaluan_mobile_app/model/post_address_model.dart';
import 'package:khoaluan_mobile_app/repository/repository.dart';

import '../api/api_response.dart';

class LocationRepository extends Repository{

  Future<ApiResponse<LocationModel>> getLocation() async {
    return await apiClient!.getLocation().wrap();
  }

  Future<ApiResponse<LatLngModel>> getLatLng({PostAddressModel? address}) async {
    return await apiClient!.getLatLng(address: address).wrap();
  }
}