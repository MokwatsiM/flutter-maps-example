class UrlHelper {
  static String urlForPhotoRef(String photoRef) {
    return "https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=$photoRef&key=AIzaSyAtKUDi8084qwpy3wgKHwB3LuFnQCY9APw"
        .toString();
  }

  static String urlForPlacesKeyWordAndLocation(
      String keyword, latitude, longitude) {
    print(
        "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=" +
            latitude +
            "," +
            longitude +
            "&radius=1500&type=restaurant&keyword=" +
            keyword +
            "&key=YOUR-KEY".toString());
    return "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=" +
        latitude +
        "," +
        longitude +
        "&radius=1500&type=restaurant&keyword=" +
        keyword +
        "&key=YOUR-KEY".toString();
  }
}
