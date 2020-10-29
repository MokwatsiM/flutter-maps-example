import 'dart:convert';

import 'package:http/http.dart';
import 'package:place_finder/models/place.dart';
import 'package:place_finder/utils/url_helper.dart';
import 'package:http/http.dart' as http;

class WebService {
  Future<List<Place>> fetchPlacesByKeyWordAndPosition(
      String keyWord, String latitude, String longitude) async {
    final url =
        UrlHelper.urlForPlacesKeyWordAndLocation(keyWord, latitude, longitude);
    final Response response = await http.get(url);
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      final Iterable results = jsonResponse['results'];
      return results.map((place) => Place.fromJson(place)).toList();
    } else {
      throw Exception("Unable to perform request");
    }
  }
}

class Position {
  String latitude;
  String longitude;
}
