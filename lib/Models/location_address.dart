import 'package:flutter/material.dart';
import 'package:geocode/geocode.dart';

class LocationAddress {
  static LocationAddress defaultAddress = LocationAddress(
      coordinates: Coordinates(latitude: 31.582045, longitude: 74.329376),
      streetAddress: "Lahore",
      city: "Lahore");

  final Coordinates coordinates;
  final String streetAddress;
  final String city;

  const LocationAddress(
      {@required this.coordinates, @required this.streetAddress, @required this.city});

  bool equals(LocationAddress address) {
    if (address == null || coordinates == null) {
      // if this condition returns true, it means that one of the LocationAddresses is null
      return false;
    }
    return (address.coordinates.longitude == coordinates.longitude &&
        address.coordinates.latitude == coordinates.latitude);
  }
}
