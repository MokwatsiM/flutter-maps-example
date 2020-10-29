import 'package:place_finder/models/place.dart';

class PlaceViewmodel {
  Place _place;
  PlaceViewmodel({Place place}) : this._place = place;

  String get placeId {
    return _place.placeId;
  }

  String get name {
    return _place.name;
  }

  String get photoUrl {
    return _place.photoUrl;
  }

  double get latitude {
    return _place.geometry.location.lat;
  }

  double get longitude {
    return _place.geometry.location.lng;
  }
}
