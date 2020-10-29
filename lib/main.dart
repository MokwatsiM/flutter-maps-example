import 'package:flutter/material.dart';
import 'package:place_finder/pages/home_page.dart';
import 'package:place_finder/viewmodels/place_listviewmodels.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ChangeNotifierProvider(
        create: (context) => PlaceListViewModel(),
        child: HomePage(),
      ),
    );
  }
}
