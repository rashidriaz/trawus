import 'package:geocode/geocode.dart';
import 'package:location/location.dart';
import 'package:trawus/Models/location_address.dart';

Future<LocationAddress> getLocationAddress(Coordinates coordinates) async {
  final address = await GeoCode().reverseGeocoding(
      latitude: coordinates.latitude, longitude: coordinates.longitude);
  final locationAddress =
      LocationAddress(coordinates: coordinates, streetAddress: address.streetAddress, city: address.city);
  return locationAddress;
}

Future<Coordinates> getCurrentLocationCoordinates() async {
  Location location = new Location();

  bool _serviceEnabled;
  PermissionStatus _permissionGranted;
  LocationData _locationData;

  _serviceEnabled = await location.serviceEnabled();
  if (!_serviceEnabled) {
    _serviceEnabled = await location.requestService();
    if (!_serviceEnabled) {
      return null;
    }
  }

  _permissionGranted = await location.hasPermission();
  if (_permissionGranted == PermissionStatus.denied) {
    _permissionGranted = await location.requestPermission();
    if (_permissionGranted != PermissionStatus.granted) {
      return null;
    }
  }

  _locationData = await location.getLocation();

  final coordinates =
      Coordinates(longitude: _locationData.longitude, latitude: _locationData.latitude);
  return coordinates;
}
