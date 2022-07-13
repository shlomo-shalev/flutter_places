// packages
import 'package:flutter/material.dart';
// models
import 'package:great_places/models/place.dart';

class PlacesProvider with ChangeNotifier {
  List<Place> _palces = [];

  List<Place> get places {
    return [..._palces];
  }
}
