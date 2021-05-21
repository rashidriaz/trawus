import 'package:flutter/material.dart';
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
  final location = await Location().getLocation();
  final coordinates =
      Coordinates(longitude: location.longitude, latitude: location.latitude);
  return coordinates;
}
