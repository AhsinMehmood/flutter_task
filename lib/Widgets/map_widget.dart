import 'package:custom_info_window/custom_info_window.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../Controllers/app_settings.dart';
import '../Controllers/routes_controller.dart';

class LiveMapWidget extends StatefulWidget {
  const LiveMapWidget({super.key});

  @override
  State<LiveMapWidget> createState() => _LiveMapWidgetState();
}

class _LiveMapWidgetState extends State<LiveMapWidget> {
  String _darkMapStyle = '';
  @override
  void initState() {
    super.initState();
    _loadMapStyles();
  }

  Future _loadMapStyles() async {
    _darkMapStyle = await rootBundle.loadString('assets/dark_mode_map.json');
    Future.delayed(const Duration(microseconds: 10)).then((value) {
      final RoutesController routesController =
          Provider.of<RoutesController>(context, listen: false);
      routesController.getBuses();
    });
  }

  @override
  Widget build(BuildContext context) {
    final AppSettingsController appSettingsController =
        Provider.of<AppSettingsController>(context);
    final RoutesController routesController =
        Provider.of<RoutesController>(context);

    return Stack(
      children: [
        GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition: routesController.buses.isEmpty
              ? const CameraPosition(
                  target: LatLng(0, 0),
                  zoom: 10.0,
                )
              : CameraPosition(
                  target: LatLng(routesController.buses.first.lat,
                      routesController.buses.first.lon),
                  zoom: 10.0,
                ),
          markers: routesController.markers.toSet(),
          zoomControlsEnabled: false,
          compassEnabled: false,
          polylines: routesController.polyLines,
          mapToolbarEnabled: false,
          onTap: (position) {
            routesController.clearPolyLines();
            routesController.addMarkers(routesController.buses);
            routesController.customInfoWindow.hideInfoWindow!();
          },
          onCameraMove: (position) {
            routesController.customInfoWindow.onCameraMove!();
          },
          //       onTap: (position){
          //          final newMarker = Marker(
          //   markerId: MarkerId(position.toString()),
          //   position: position,
          //   icon: BitmapDescriptor.defaultMarker,
          // );
          // routesController.selectMarker(newMarker);
          //       },
          myLocationButtonEnabled: false,
          onMapCreated: (GoogleMapController controller) {
            routesController.customInfoWindow.googleMapController = controller;

            routesController.initMapController(controller);

            if (appSettingsController.isDark) {
              controller.setMapStyle(_darkMapStyle);
            }
          },
        ),
        // if (routesController.polyGoneRouteId != '')
        CustomInfoWindow(
          controller: routesController.customInfoWindow,
          height: 100,
          width: 200,
          offset: 50,
        ),
      ],
    );
  }
}
