import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mmm_trans/constants/Theme.dart';
import 'package:mmm_trans/widgets/map-widget.dart';
import 'package:mmm_trans/widgets/navbar.dart';
import 'package:mmm_trans/constants/TransData.dart';
import 'package:mmm_trans/widgets/drawer.dart';

class artistMapLocation extends StatefulWidget {
  artistMapLocation({Key key}) : super(key: key);

  @override
  _ArtistMapLocation createState() => _ArtistMapLocation();
}

class _ArtistMapLocation extends State<artistMapLocation> {
  double x;
  double y;
  String name;
  String annee;
  Set<Marker> _markers = HashSet<Marker>();
  bool initDone = false;
  String artistToSearch;
  GoogleMapController _mapController;

  @override
  void initState() {
    super.initState();
  }

  void addMarker(int id, double lat, double long, String nom, String annee) {
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



  Future<String> _getArtistInformation(String artistId) async {
    List<TransData> transData = await getDataFromJson();
    List<TransData> a =
    transData.where((element) => element.recordid == artistId).toList();
    var artistInfo = a[0];
    x = artistInfo.geometry.coordinates[0];
    y = artistInfo.geometry.coordinates[1];
    name = artistInfo.fields.artistes;
    annee = artistInfo.fields.annee != null
        ? artistInfo.fields.annee
        : "Unknown";
    if(initDone==false){
      addMarker(1, y, x, name, annee);
    }

initDone = true;

    return "hello";
  }

  @override
  Widget build(BuildContext context) {
    artistToSearch = ModalRoute
        .of(context)
        .settings
        .arguments;

    return new FutureBuilder<String>(
      future: _getArtistInformation(artistToSearch), // a Future<String> or null
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return new Text('Press button to start');
          case ConnectionState.waiting:
            return new Container(
              color: Colors.white,
              child: Center(
                  child: CircularProgressIndicator()),
            );
          default:
            if (snapshot.hasError)
              return new Text('Error: ${snapshot.error}');
            else
              return
                Scaffold(
                appBar: Navbar(
                prefferedHeight: 65.0,
                backButton: true,
                title: "Artist Location",
              ),
                backgroundColor: NowUIColors.bgColorScreen,
                // key: _scaffoldKey,
                drawer: NowDrawer(currentPage: "Map"),
                body: Stack(
                  children: <Widget>[
                    GoogleMap(
                      // onMapCreated: _onMapCreated,
                      initialCameraPosition: CameraPosition(
                        target: LatLng(y, x),
                        zoom: 4,
                      ),
                      markers: _markers,
                      myLocationEnabled: true,
                      myLocationButtonEnabled: true,
                    ),
                  ],
                ),
              );
      }
      },
    );
  }

}
