// packages
import 'dart:io';
// models
import 'package:great_places/models/location.dart';

class Place {
  final String id;
  final String title;
  final File image;
  final Location? location;

  const Place({
    required this.id,
    required this.title,
    required this.image,
    required this.location,
  });
}
