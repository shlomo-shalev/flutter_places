// packages
import 'dart:io';
import 'package:great_places/models/location.dart';
import 'package:great_places/providers/google_maps_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:great_places/providers/places_provider.dart';
// widgets
import 'package:great_places/widgets/image_input_widget.dart';
import 'package:great_places/widgets/location_input_widget.dart';

class AddPlaceScreen extends StatefulWidget {
  static const routeName = '/add-place';
  const AddPlaceScreen({Key? key}) : super(key: key);

  @override
  State<AddPlaceScreen> createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  final TextEditingController _titleController = TextEditingController();
  File? image;
  Function? handleSaveImage;
  Location? _location;

  void _getImage(File pickedImage, Function saveImage) {
    handleSaveImage = saveImage;
    image = pickedImage;
  }

  void _getLocation(double latitude, double longitude) async {
    _location = Location(
      latitude: latitude,
      longitude: longitude,
      address: await GoogleMapsProvider.getAddress(latitude, longitude),
    );
  }

  _savePlace() {
    if (image == null || _titleController.text.isEmpty) {
      return;
    }
    handleSaveImage!();
    Provider.of<PlacesProvider>(context, listen: false).addPlace(
      _titleController.text,
      image as File,
      _location as Location,
    );
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add place'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: <Widget>[
                    TextField(
                      controller: _titleController,
                      decoration: InputDecoration(
                        label: const Text('Title'),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ImageInputWidget(
                      selectImage: _getImage,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    LocationInputWidget(_getLocation),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 70,
            child: Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  primary: Theme.of(context).colorScheme.secondary,
                ).copyWith(
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                label: const Text('Add place'),
                icon: const Icon(Icons.add),
                onPressed: _savePlace,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
