import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:khoaluan_mobile_app/utils/extensions/context_extension.dart';
import '../../theme/app_bar.dart';
import 'components/gps_button.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  late GoogleMapController controller;
  final CameraPosition _myLocation = const CameraPosition(
    target: LatLng(16.053659, 108.1706108),
    zoom: 14.4746,
  );

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DefaultAppBar(
        title: "Bản đồ",
      ),
      body: GoogleMap(
        initialCameraPosition: _myLocation,
        zoomControlsEnabled: false,
        myLocationEnabled: true,
        myLocationButtonEnabled: false,
        onMapCreated: (GoogleMapController _controller) async {
          controller = _controller;
        },
        // markers: markers,
        onTap: (LatLng latLng) {
          log("LatLng: ${latLng.latitude.toString()}, ${latLng.longitude.toString()}");
        },
      ),
      floatingActionButton: GPSButton(
        onLatLng: (LatLng onLatLng, String message) {
          log("LatLng: ${onLatLng.latitude.toString()}, ${onLatLng.longitude.toString()}");
          if (message.isNotEmpty) {
            context.showMessage(message, type: MessageType.error);
          }
          controller.animateCamera(
            CameraUpdate.newCameraPosition(
              CameraPosition(target: onLatLng, zoom: 14),
            ),
          );
        },
      ),
    );
  }
}
