import 'dart:convert';

import 'package:http/http.dart' as http;

const GOOGLE_MAPS_KEY = 'AIzaSyBOi07BiJck-OXkB3xKkbwO4G55WCjybfc';

class GoogleMapsProvider {
  static String getUrl({
    required double latitude,
    required double longitude,
  }) {
    return 'https://maps.googleapis.com/maps/api/staticmap?center=$latitude,$longitude&zoom=16&size=600x300&maptype=roadmap&markers=color:red%7Clabel:%7C$latitude,$longitude&key=$GOOGLE_MAPS_KEY';
  }

  static Future<String> getAddress(double latitude, double longitude) async {
    final Uri url = Uri.parse(
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$latitude,$longitude&key=$GOOGLE_MAPS_KEY');
    final http.Response addressResponse = await http.get(url);
    return json.decode(addressResponse.body)['results'][0]['formatted_address'];
  }
}
