import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mmm_trans/constants/Theme.dart';
import 'package:mmm_trans/widgets/navbar.dart';
import 'package:mmm_trans/constants/TransData.dart';
import 'package:mmm_trans/widgets/drawer.dart';

class Map extends StatefulWidget {
  Map({Key key}) : super(key: key);

  @override
  _MapState createState() => _MapState();
}

class _MapState extends State<Map> {
  Set<Marker> _markers = HashSet<Marker>();
  bool _showMapStyle = false;
  GoogleMapController _mapController;

  @override
  void initState() {
    super.initState();
  }

  void addMarker(int id, double lat, double long, String nom, String annee,
      String recordId) {
    setState(() {
      _markers.add(
        Marker(
            markerId: MarkerId(id.toString()),
            position: LatLng(lat, long),
            infoWindow: InfoWindow(
                title: nom,
                snippet: annee,
                onTap: () {
                  Navigator.pushNamed(context, '/profile', arguments: recordId);
                })),
      );
    });
  }

  void _onMapCreated(GoogleMapController controller) async {
    int id = 0;
    _mapController = controller;
    List<TransData> transData = await getDataFromJson();
    transData.forEach((group) => {
          if (group.geometry != null && id < 600)
            {
              id++,
              addMarker(
                  id,
                  group.geometry.coordinates[1],
                  group.geometry.coordinates[0],
                  group.fields.artistes,
                  group.fields.annee,
                  group.recordid),
            }
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Navbar(title: "Map", prefferedHeight: 65.0, searchBar: false),
      backgroundColor: NowUIColors.bgColorScreen,
      // key: _scaffoldKey,
      drawer: NowDrawer(currentPage: "Map"),
      body: Stack(
        children: <Widget>[
          GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: LatLng(48.5721874, 0.0047567),
              zoom: 3,
            ),
            markers: _markers,
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
          ),
        ],
      ),
    );
  }
}
