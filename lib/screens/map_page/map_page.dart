import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:khoaluan_mobile_app/screens/map_page/map_view_model.dart';
import 'package:khoaluan_mobile_app/utils/extensions/context_extension.dart';
import 'package:khoaluan_mobile_app/widgets/cover_loading.dart';
import 'package:provider/provider.dart';
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
    zoom: 16,
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
    final viewModel = context.watch<MapViewModel>();
    viewModel.context = context;
    return Scaffold(
      appBar: const DefaultAppBar(
        title: "Bản đồ",
      ),
      body: CoverLoading(
          isStack: true,
          showLoading: viewModel.isLoading,
          child: GoogleMap(
            initialCameraPosition: _myLocation,
            zoomControlsEnabled: false,
            myLocationEnabled: true,
            mapToolbarEnabled: true,

            myLocationButtonEnabled: false,
            markers: Set<Marker>.of(viewModel.markers),
            onMapCreated: (GoogleMapController _controller) async {
              controller = _controller;
            },
            // markers: markers,
          ),
        ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 80),
        child: GPSButton(
          onLatLng: (LatLng onLatLng, String message) {
            if (message.isNotEmpty) {
              context.showMessage(message, type: MessageType.error);
            }
            controller.animateCamera(
              CameraUpdate.newCameraPosition(
                CameraPosition(target: onLatLng, zoom: 16),
              ),
            );
          },
        ),
      ),
    );
  }
}
