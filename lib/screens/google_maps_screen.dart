import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:great_places/models/location.dart';

class GoogleMapsScreen extends StatefulWidget {
  final Location location;
  final bool isSelecting;

  const GoogleMapsScreen({
    Key? key,
    this.location = const Location(
      latitude: 37.4275,
      longitude: -122.0304,
      address: '',
    ),
    this.isSelecting = false,
  }) : super(key: key);

  @override
  State<GoogleMapsScreen> createState() => _GoogleMapsScreenState();
}

class _GoogleMapsScreenState extends State<GoogleMapsScreen> {
  LatLng? _position;

  void _getUserLocation(LatLng position) {
    setState(() {
      _position = position;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your map'),
        actions: <Widget>[
          if (widget.isSelecting)
            IconButton(
              onPressed: _position == null
                  ? null
                  : () {
                      Navigator.of(context).pop(_position);
                    },
              icon: const Icon(Icons.check),
            ),
        ],
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(
            widget.location.latitude,
            widget.location.longitude,
          ),
          zoom: 13,
        ),
        onTap: widget.isSelecting ? _getUserLocation : null,
        markers: {
          if (_position != null || !widget.isSelecting)
            Marker(
              markerId: MarkerId('m1'),
              position: _position ??
                  LatLng(
                    widget.location.latitude,
                    widget.location.longitude,
                  ),
            ),
        },
      ),
    );
  }
}
