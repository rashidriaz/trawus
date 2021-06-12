import 'package:flutter/material.dart';
import 'package:geocode/geocode.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:trawus/Models/location_address.dart';
import 'package:trawus/domain/helpers/geocode_helper.dart';
import 'package:trawus/domain/helpers/google_maps_helper.dart';
import 'package:trawus/presentation/screens/map_screen/map_screen.dart';

import '../../../../constants.dart';

// ignore: must_be_immutable
class InputLocationForProduct extends StatefulWidget {
  final Function onSelectPlace;
  LocationAddress address;

  InputLocationForProduct(this.onSelectPlace, this.address);

  @override
  _InputLocationState createState() => _InputLocationState();
}

class _InputLocationState extends State<InputLocationForProduct> {
  String _previewImageUrl;

  @override
  Widget build(BuildContext context) {
    if (_previewImageUrl == null) {
      _showPreview(widget.address.coordinates);
    }
    return Column(
      children: [
        Container(
          height: 170,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey),
          ),
          child: _previewImageUrl == null
              ? Text(
            'No Location Chosen',
            textAlign: TextAlign.center,
          )
              : Image.network(
            _previewImageUrl,
            fit: BoxFit.cover,
            width: double.infinity,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextButton.icon(
              icon: Icon(
                Icons.location_on,
              ),
              label: Text(
                'Current Location',
                style: TextStyle(color: primaryColor),
              ),
              onPressed: _getCurrentUserLocation,
            ),
            TextButton.icon(
              icon: Icon(
                Icons.map,
              ),
              label: Text(
                'Select on Map',
                style: TextStyle(color: primaryColor),
              ),
              onPressed: _selectOnMap,
            ),
          ],
        ),
      ],
    );
  }
  Future<void> _getCurrentUserLocation() async {
    try {
      final coordinates = await getCurrentLocationCoordinates();

      _showPreview(coordinates);
      widget.onSelectPlace(coordinates);
    } catch (error) {
      return;
    }
  }

  Future<Coordinates> _currentLocation() async {
    return await getCurrentLocationCoordinates();
  }

  void _showPreview(Coordinates coordinates) {
    final staticMapImageUrl = LocationHelper.generateLocationPreviewImage(
      latitude: coordinates.latitude,
      longitude: coordinates.longitude,
    );
    setState(() {
      _previewImageUrl = staticMapImageUrl;
    });
  }

  Future<void> _selectOnMap() async {
    final location = await _currentLocation();
    final selectedLocation = await Navigator.of(context).push<LatLng>(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (ctx) => MapScreen(
          initialLocation: location,
        ),
      ),
    );
    if (selectedLocation == null) {
      return;
    }
    Coordinates coordinates = Coordinates(
        latitude: selectedLocation.latitude,
        longitude: selectedLocation.longitude);
    _showPreview(coordinates);
    widget.onSelectPlace(
        latitude: selectedLocation.latitude,
        longitude: selectedLocation.longitude);
  }


}