import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:map_launcher/map_launcher.dart' as launcher;
import 'package:place_finder/viewmodels/place_listviewmodels.dart';
import 'package:place_finder/viewmodels/place_viewmodel.dart';
import 'package:place_finder/widgets/place_list.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Completer<GoogleMapController> _controller = Completer();
  GoogleMapController mapController;

  Position _position;
  LatLng _center;
  @override
  void initState() {
    _getLocation();
    super.initState();
  }

  Future<void> _getLocation() async {
    _position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high)
        .then((Position value) {
      _center = LatLng(value.latitude, value.longitude);
      print(_center);
      return value;
    });
  }

  Future<void> _onMapCreated(GoogleMapController controller) async {
    mapController = controller;
    _position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    print(_position);
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
            target: LatLng(_position.latitude, _position.longitude), zoom: 18),
      ),
    );
  }

  Set<Marker> _getPlaceMarkers(List<PlaceViewmodel> places) {
    return places.map((place) {
      print(place.name);
      return Marker(
          markerId: MarkerId(place.placeId),
          icon: BitmapDescriptor.defaultMarker,
          infoWindow: InfoWindow(title: place.name),
          position: LatLng(place.latitude, place.longitude));
    }).toSet();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<PlaceListViewModel>(context);

    return Scaffold(
        body: Stack(
      children: [
        GoogleMap(
            mapType: viewModel.mapType,
            markers: _getPlaceMarkers(viewModel.places),
            myLocationEnabled: true,
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: LatLng(-26.5535, 28.3199),
              zoom: 18,
            )),
        SafeArea(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              onSubmitted: (value) {
                viewModel.fetchPlacesByKeywordAndPossition(
                    value,
                    _position.latitude.toString(),
                    _position.longitude.toString());
              },
              decoration: InputDecoration(
                  labelText: "Search Here",
                  fillColor: Colors.white,
                  filled: true),
            ),
          ),
        ),
        Visibility(
          visible: viewModel.places.length > 0 ? true : false,
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Align(
                  alignment: Alignment.bottomLeft,
                  child: FlatButton(
                    minWidth: 350,
                    onPressed: () {
                      showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return PlaceList(
                              places: viewModel.places,
                              onSelected: _openMapsFor,
                            );
                          });
                    },
                    color: Colors.grey,
                    child: Text(
                      "Show List",
                      style: TextStyle(color: Colors.white),
                    ),
                  )),
            ),
          ),
        ),
        Positioned(
          top: 150,
          right: 5,
          child: FloatingActionButton(
            onPressed: () {
              viewModel.toggleMapType();
            },
            child: Icon(Icons.map),
          ),
        )
      ],
    ));
  }

  Future<void> _openMapsFor(PlaceViewmodel placeViewmodel) async {
    if (await launcher.MapLauncher.isMapAvailable(launcher.MapType.google)) {
      await launcher.MapLauncher.showMarker(
        mapType: launcher.MapType.google,
        coords:
            launcher.Coords(placeViewmodel.latitude, placeViewmodel.longitude),
        title: placeViewmodel.name,
      );
    } else if (await launcher.MapLauncher.isMapAvailable(
        launcher.MapType.apple)) {
      await launcher.MapLauncher.showMarker(
        mapType: launcher.MapType.apple,
        coords:
            launcher.Coords(placeViewmodel.latitude, placeViewmodel.longitude),
        title: placeViewmodel.name,
      );
    }
  }
}
