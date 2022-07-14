import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:great_places/providers/google_maps_provider.dart';
import 'package:great_places/screens/google_maps_screen.dart';
import 'package:location/location.dart';

class LocationInputWidget extends StatefulWidget {
  final Function sendLocation;

  LocationInputWidget(
    this.sendLocation, {
    Key? key,
  }) : super(key: key);

  @override
  State<LocationInputWidget> createState() => _LocationInputWidgetState();
}

class _LocationInputWidgetState extends State<LocationInputWidget> {
  String? _previewImageUrl;

  void _addLocation(double latitude, double longitude) async {
    setState(() {
      _previewImageUrl = GoogleMapsProvider.getUrl(
        latitude: latitude,
        longitude: longitude,
      );
    });
    widget.sendLocation(latitude, longitude);
  }

  Future<void> _getUserLocation() async {
    final LocationData? locationData = await Location().getLocation();
    if (locationData != null) {
      _addLocation(
        locationData.latitude as double,
        locationData.longitude as double,
      );
    }
  }

  Future<void> _chooseInMap() async {
    final LatLng? locationChoose = await Navigator.of(context).push(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (ctx) => GoogleMapsScreen(
          isSelecting: true,
        ),
      ),
    );
    if (locationChoose != null) {
      _addLocation(
        locationChoose.latitude,
        locationChoose.longitude,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          width: double.infinity,
          height: 185,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Colors.grey,
            ),
          ),
          alignment: Alignment.center,
          child: _previewImageUrl == null
              ? Text(
                  'No Location Chosen.',
                  textAlign: TextAlign.center,
                )
              : Image.network(
                  _previewImageUrl as String,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            TextButton.icon(
              onPressed: _getUserLocation,
              label: const Text('Current location'),
              icon: const Icon(
                Icons.location_on,
              ),
              style: TextButton.styleFrom(
                textStyle: TextStyle(
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
            TextButton.icon(
              onPressed: _chooseInMap,
              label: const Text('Choose in map'),
              icon: const Icon(
                Icons.map,
              ),
              style: TextButton.styleFrom(
                textStyle: TextStyle(
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
