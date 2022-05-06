import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:khoaluan_mobile_app/theme/color.dart';

class GPSButton extends StatelessWidget {
  final Function(LatLng latLng, String message)? onLatLng;

  const GPSButton({
    Key? key,
    this.onLatLng,
  }) : super(key: key);

  Future<void> _determinePosition() async {
    String message = '';
    final bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      message = 'Location services are disabled.';
      // return Future.error('Location services are disabled.');
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        message = 'Location permissions are denied';
        // return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      message = 'Location permissions are permanently denied, we cannot request permissions.';
      // return Future.error('Location permissions are permanently denied, we cannot request permissions.');
    }
    final position = await Geolocator.getCurrentPosition();
    onLatLng?.call(LatLng(position.latitude, position.longitude), message);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52,
      width: 52,
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        shape: BoxShape.circle,
      ),
      child: IconButton(
        icon: const Icon(
          Icons.gps_fixed_outlined,
          color: AppColors.textWhite,
        ),
        onPressed: _determinePosition,
      ),
    );
  }
}
