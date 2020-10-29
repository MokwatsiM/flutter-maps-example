import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:place_finder/models/place.dart';
import 'package:place_finder/services/webservice.dart';
import 'package:place_finder/viewmodels/place_viewmodel.dart';

class PlaceListViewModel extends ChangeNotifier {
  List<PlaceViewmodel> places = List<PlaceViewmodel>();
  MapType mapType = MapType.normal;

  void toggleMapType() {
    this.mapType =
        this.mapType == MapType.normal ? MapType.satellite : MapType.normal;
    notifyListeners();
  }

  void fetchPlacesByKeywordAndPossition(
      String keyword, String latitude, String longitude) async {
    final List<Place> placesResults = await WebService()
        .fetchPlacesByKeyWordAndPosition(keyword, latitude, longitude);
    this.places =
        placesResults.map((place) => PlaceViewmodel(place: place)).toList();
    notifyListeners();
  }
}
