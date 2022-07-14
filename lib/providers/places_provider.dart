// packages
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:great_places/models/location.dart';
// models
import 'package:great_places/models/place.dart';
import 'package:great_places/providers/db_providser.dart';

class PlacesProvider with ChangeNotifier {
  List<Place> _palces = [];

  List<Place> get places {
    return [..._palces];
  }

  Place findById(String id) {
    return _palces.firstWhere((place) => place.id == id);
  }

  void addPlace(
    String pickedTitle,
    File pickedImage,
    Location location,
  ) {
    final Place newPlace = Place(
      id: DateTime.now().toString(),
      title: pickedTitle,
      image: pickedImage,
      location: Location(
        latitude: location.latitude,
        longitude: location.longitude,
        address: location.address,
      ),
    );
    _palces.add(newPlace);
    notifyListeners();
    DB.insert('user_places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path,
      'latitude': newPlace.location.latitude,
      'longitude': newPlace.location.longitude,
      'address': newPlace.location.address,
    });
  }

  Future<void> fetchAndSetPlaces() async {
    final List<Map<String, dynamic>> dataList = await DB.getData('user_places');
    _palces = dataList
        .map((item) => Place(
              id: item['id'],
              title: item['title'],
              image: File(
                item['image'],
              ),
              location: Location(
                address: item['address'],
                longitude: item['longitude'],
                latitude: item['latitude'],
              ),
            ))
        .toList();
    notifyListeners();
  }
}
