import 'package:flutter/material.dart';
import 'package:geocode/geocode.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:trawus/presentation/screens/map_screen/components/map_screen_app_bar.dart';

import 'components/camera_position.dart';

class MapScreen extends StatefulWidget {
  final Coordinates initialLocation;

  MapScreen({
    @required this.initialLocation,
  });

  @override
  _MapScreenState createState() {
    final location =
        LatLng(initialLocation.latitude, initialLocation.longitude);
    return _MapScreenState(location);
  }
}

class _MapScreenState extends State<MapScreen> {
  LatLng _currentlyPickedLocation;
  Set<Marker> _mapMarkers = {};

  _MapScreenState(this._currentlyPickedLocation);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: mapScreenAppBar(
        onPressed: _currentlyPickedLocation == null
            ? null
            : () {
                Navigator.of(context).pop(_currentlyPickedLocation);
              },
      ),
      body: GoogleMap(
        myLocationEnabled: true,
        buildingsEnabled: true,
        indoorViewEnabled: true,
        compassEnabled: true,
        myLocationButtonEnabled: true,
        rotateGesturesEnabled: true,
        scrollGesturesEnabled: true,
        zoomGesturesEnabled: true,
        zoomControlsEnabled: true,
        trafficEnabled: true,
        tiltGesturesEnabled: true,
        mapType: MapType.normal,
        onMapCreated: _onMapCreated,
        initialCameraPosition: cameraPosition(
          _currentlyPickedLocation,
        ),
        onTap: _selectLocation,
        markers: _mapMarkers,
      ),
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      _mapMarkers.add(
        Marker(
          markerId: MarkerId("1"),
          position: _currentlyPickedLocation,
          infoWindow: InfoWindow(
              title: "Your Current Location",
              snippet: "You are currently here!"),
        ),
      );
    });
  }

  void _selectLocation(LatLng position) {
    setState(() {
      _currentlyPickedLocation = position;
      _mapMarkers.removeWhere((element) => element.markerId == MarkerId("1"));
      _mapMarkers.add(
        Marker(
          markerId: MarkerId("1"),
          //hard coding the id because we always gonna have only one marker on the screen
          position: _currentlyPickedLocation,
          infoWindow: InfoWindow(
              title: "Your selected Location",
              snippet: "You selected this position!"),
        ),
      );
    });
  }
}
