// packages
import 'dart:io';

import 'package:flutter/material.dart';
// models
import 'package:great_places/models/place.dart';

class PlacesProvider with ChangeNotifier {
  List<Place> _palces = [];

  List<Place> get places {
    return [..._palces];
  }

  void addPlace(
    String pickedTitle,
    File pickedImage,
  ) {
    _palces.add(Place(
      id: DateTime.now().toString(),
      title: pickedTitle,
      image: pickedImage,
      location: null,
    ));
    notifyListeners();
  }
}
