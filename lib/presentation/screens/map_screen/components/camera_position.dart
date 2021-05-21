import 'package:google_maps_flutter/google_maps_flutter.dart';

CameraPosition cameraPosition(LatLng location) {
  return CameraPosition(
      target: LatLng(
    location.latitude,
    location.longitude,
  ),
  zoom: 50);
}