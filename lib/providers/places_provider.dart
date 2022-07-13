// packages
import 'dart:io';

import 'package:flutter/material.dart';
// models
import 'package:great_places/models/place.dart';
import 'package:great_places/providers/db_providser.dart';

class PlacesProvider with ChangeNotifier {
  List<Place> _palces = [];

  List<Place> get places {
    return [..._palces];
  }

  void addPlace(
    String pickedTitle,
    File pickedImage,
  ) {
    final Place newPlace = Place(
      id: DateTime.now().toString(),
      title: pickedTitle,
      image: pickedImage,
      location: null,
    );
    _palces.add(newPlace);
    notifyListeners();
    DB.insert('user_places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path,
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
              location: null,
            ))
        .toList();
    notifyListeners();
  }
}
