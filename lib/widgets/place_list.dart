import 'package:flutter/material.dart';
import 'package:place_finder/utils/url_helper.dart';
import 'package:place_finder/viewmodels/place_viewmodel.dart';

class PlaceList extends StatelessWidget {
  final List<PlaceViewmodel> places;
  final Function(PlaceViewmodel) onSelected;

  PlaceList({this.places, this.onSelected});
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: places.length ?? 0,
        itemBuilder: (BuildContext context, int index) {
          var place = this.places[index];
          return ListTile(
            onTap: () {
              this.onSelected(place);
            },
            leading: place.photoUrl.contains("assets")
                ? Container(
                    width: 100,
                    height: 100,
                    child: Image.asset(
                      place.photoUrl,
                      fit: BoxFit.cover,
                    ),
                  )
                : Container(
                    width: 100,
                    height: 100,
                    child: Image.network(
                      UrlHelper.urlForPhotoRef(place.photoUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
            title: Text(place.name),
          );
        });
  }
}
