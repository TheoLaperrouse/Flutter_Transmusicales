import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mmm_trans/constants/Theme.dart';
import 'package:mmm_trans/widgets/navbar.dart';
import 'package:mmm_trans/widgets/drawer.dart';

class MapWidget extends StatefulWidget {
  double lat;
  double long;
  String annee;
  String artistes;

  MapWidget(this.lat,this.long,this.annee,this.artistes, {Key key})
      : super(key: key);


  @override
  _MapWidgetState createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  Set<Marker> _markers = HashSet<Marker>();
  bool _showMapStyle = false;
  GoogleMapController _mapController;


  @override
  void initState() {
    super.initState();
  }

  void addMarker(int id, double lat, double long, String nom, String annee) {
    print("Coordinates : " + lat.toString() + " " + long.toString());
    setState(() {
      _markers.add(Marker(
          markerId: MarkerId(id.toString()),
          position: LatLng(lat, long),
          infoWindow: InfoWindow(
            title: nom,
            snippet: annee,
          )));
    });
  }

  void _onMapCreated(GoogleMapController controller) async {
    int id = 0;
    _mapController = controller;
    addMarker(
        id,
        widget.lat,
        widget.long,
        widget.artistes,
        widget.annee);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: LatLng(widget.lat, widget.long),
              zoom: 4,
            ),
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            markers: _markers,


          ),
        ],
      ),
    );
  }
}
