import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapWidget extends StatefulWidget {
  const MapWidget({super.key});

  @override
  State<MapWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  static const LatLng _pGooglePlex = LatLng(
    9.470167382036111,
    77.80435422074858,
  );
  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      initialCameraPosition: CameraPosition(target: _pGooglePlex, zoom: 13),
      markers: {
        Marker(
          markerId: MarkerId("_currentLocation"),
          icon: BitmapDescriptor.defaultMarker,
          position: _pGooglePlex,
        ),
        // Marker(
        //   markerId: MarkerId("_sourceLocation"),
        //   icon: BitmapDescriptor.defaultMarker,
        //   position: _pApplePlex,
        // ),
      },
    );
  }
}
