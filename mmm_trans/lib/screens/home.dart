import 'dart:developer' as dev;
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';

import 'package:filter_list/filter_list.dart';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mmm_trans/constants/Theme.dart';
import 'package:mmm_trans/constants/TransData.dart';
import 'package:mmm_trans/widgets/card-horizontal.dart';
import 'package:mmm_trans/widgets/card-small.dart';
import 'package:mmm_trans/widgets/card-square.dart';
import 'package:mmm_trans/widgets/drawer.dart';
import 'package:mmm_trans/widgets/navbar.dart';
import 'package:spotify/spotify.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final Future<List<TransData>> items = JsonServ().getData();

  MyListView listView = MyListView();

  @override
  Widget build(BuildContext context) {

    return FutureBuilder(
      future: items,
      builder: (context, snapshot) {
        // operation for completed state
        if (snapshot.hasData) {

          if(listView.__myListViewState.artistesList.isEmpty){
            listView.__myListViewState.artistesList = snapshot.data;
          }

          if(listView.__myListViewState.filters.isEmpty){
            listView.__myListViewState.initFilters();
          }

          return Scaffold(
              appBar: Navbar(
                title: "Artists",
                searchBar: true,
                filters: listView.__myListViewState.filters,
                applyFilters: listView.__myListViewState.filterList,
                searchOnChanged: listView.__myListViewState.searchByName,
              ),
              backgroundColor: NowUIColors.bgColorScreen,
              // key: _scaffoldKey,
              drawer: NowDrawer(currentPage: "Home"),
              body: listView
          );
        }

        // spinner for uncompleted state
        return SpinnerWidget();
      },
    );
  }
}

class JsonServ {
  Future<List<TransData>> getData() async {
    final res = await getDataFromJson();
    return res;
  }
}

class MyListView extends StatefulWidget {

  _MyListViewState __myListViewState = _MyListViewState();

  @override
  _MyListViewState createState() => __myListViewState;
}

class _MyListViewState extends State<MyListView> {

  Map<String,List<String>> filters = {};

  List<TransData> artistesList = [];
  List<TransData> listToDisplay = [];
  List<TransData> listToDisplaySave = [];

  static Map<String, String> mapUrlImageArtist = {};
  final artistUrlDefault =
      "https://t4.ftcdn.net/jpg/03/46/93/61/360_F_346936114_RaxE6OQogebgAWTalE1myseY1Hbb5qPM.jpg";

  //MyListView({this.items});

  @override
  Widget build(BuildContext context) {

    if(listToDisplay.isEmpty){
      listToDisplay.addAll(artistesList);
      listToDisplaySave.clear();
      listToDisplaySave.addAll(listToDisplay);
    }

    return ListView.builder(
      itemCount: listToDisplay.length,
        itemBuilder: (context, index) {
          var item = listToDisplay[index];
          return ArtistCard(item);
        });
  }

  void initFilters() {

    filters = {
      "Edition": [],
      "Year": [],
      "Country of origin": [],
    };

    List<String> editions = artistesList.map((e) => editionValues.reverse[e.fields.edition]).toSet().toList().where((element) => element != null).toList();
    editions.sort((a, b) => a.compareTo(b));

    filters["Edition"] = editions;

    List<String> years = artistesList.map((e) => e.fields.annee).toSet().toList().where((element) => element != null).toList();
    years.sort((a, b) => a.compareTo(b));

    filters["Year"] = years;

    List<String> countries = artistesList.map((e) => e.fields.couTextEn).toSet().toList().where((element) => element != null).toList();
    countries.sort((a, b) => a.compareTo(b));

    filters["Country of origin"] = countries;
  }

  void refresh(List<TransData> list){
    setState(() {
      listToDisplay.clear();
      listToDisplay.addAll(list);
      listToDisplaySave.clear();
      listToDisplaySave.addAll(listToDisplay);
    });
  }

  void filterList(Map<String,List<String>> activeFilters) {

    if(activeFilters.isEmpty){
      refresh(artistesList);
      print("ALL = "+listToDisplay.length.toString());
    }
    else {
      List<TransData> filterRes = [];

      activeFilters.keys.toList().forEach((element) {
        switch (element) {

          case "Edition":
            if(activeFilters[element] != null && activeFilters[element].toList().isNotEmpty){
              if(filterRes.isEmpty){
                filterRes.addAll(artistesList.where((e) => activeFilters[element].contains(editionValues.reverse[e.fields.edition])).toList());
                print("EDITION = "+filterRes.length.toString());
              }
              else{
                filterRes = filterRes.where((e) => activeFilters[element].contains(e.fields.edition)).toList();
                print("WITH EDITION = "+filterRes.length.toString());
              }
            }
            break;

          case "Year":
            if(activeFilters[element] != null && activeFilters[element].toList().isNotEmpty){
              if(filterRes.isEmpty){
                filterRes.addAll(artistesList.where((e) => activeFilters[element].contains(e.fields.annee)).toList());
                print("YEAR = "+filterRes.length.toString());
              }
              else{
                filterRes = filterRes.where((e) => activeFilters[element].contains(e.fields.annee)).toList();
                print("WITH YEAR = "+filterRes.length.toString());
              }
            }
            break;

          case "Country of origin":
            if(activeFilters[element] != null && activeFilters[element].toList().isNotEmpty){
              if(filterRes.isEmpty){
                filterRes.addAll(artistesList.where((e) => activeFilters[element].contains(e.fields.couTextEn)).toList());
                print("COUNTRY = "+filterRes.length.toString());
              }
              else{
                filterRes = filterRes.where((e) => activeFilters[element].contains(e.fields.couTextEn)).toList();
                print("WITH COUNTRY = "+filterRes.length.toString());
              }
            }
            break;

          default:
            refresh(artistesList);
            print("DEFAULT = "+listToDisplay.length.toString());
            break;
        }
      });

      refresh(filterRes);
    }
  }

  void searchByName(String value) {
    setState(() {
      listToDisplay.clear();
      listToDisplay = listToDisplaySave.where((e) => e.fields.artistes.toLowerCase().contains(value.toLowerCase())).toList();
      print("SEARCH BAR : "+listToDisplay.length.toString());
    });
  }

  Widget _buildArtisteCardLargev2(item, context) {
    return CardHorizontal(
        cta: "About",
        //title: _artistesList[index].fields.artistes,
        //infoTxt: _artistesList[index].fields.annee,
        title: item.fields.artistes != null ? item.fields.artistes : "-",
        infoTxt: item.fields.annee != null ? item.fields.annee : "-",
        titleSize: 16,
        flexImage: 1,
        flexText: 2,
        maxLines: 2,
        img: mapUrlImageArtist[item.fields.artistes] != null
            ? mapUrlImageArtist[item.fields.artistes]
            : artistUrlDefault,
        //mapUrlImageArtist[item.fields.artistes] != null ? mapUrlImageArtist[item.fields.artistes] : artistUrlDefault,
        //"https://musicimage.xboxlive.com/catalog/video.movie.8D6KGWZL5KNS/image?locale=fr-fr&mode=crop&purposes=BoxArt&q=90&h=225&w=150&format=jpg"
        //_artistesList[index]["image"],
        tap: () {
          Navigator.pushNamed(context, '/profile',
              arguments: item.recordid);
          //ModalRoute.of(context).settings.arguments;
        });
  }
}

class ArtistCard extends StatefulWidget {
  TransData item;

  ArtistCard(this.item);

  @override
  _ArtistCardState createState() => _ArtistCardState();
}

class _ArtistCardState extends State<ArtistCard> {
  var artistUrlDefault =
      "https://t4.ftcdn.net/jpg/03/46/93/61/360_F_346936114_RaxE6OQogebgAWTalE1myseY1Hbb5qPM.jpg";
  var artistUrl;
  var initDone = false;

  Future<String> _getArtistImagebyArtistName(String artistToSearch) async {
    var artistToReturn = artistUrlDefault;
    try {
      var credentials = SpotifyApiCredentials(
          "6abd6b78ccf449fd833bc034dad9fc23",
          "5cdbaa929d284903a847e3aca84c8687");
      var spotify = SpotifyApi(credentials);
      var search = await spotify.search
          .get(artistToSearch)
          .first(1)
          .catchError((e) => print(""));
      if (search == null) {
        return artistToReturn;
      }

      search.forEach((pages) {
        if (pages != null && pages.items != null && pages.items.isNotEmpty) {
          pages.items.forEach((item) {
            if (item is Artist) {
              if (item.images != null && item.images.isNotEmpty) {
                artistToReturn = item.images.first.url;
              }
            }
          });
        }
      });
      return artistToReturn;
    } on Exception catch (_) {
      return artistToReturn;
    }
  }

  Future<void> initImage(String artistToSearch) async {
    await _getArtistImagebyArtistName(artistToSearch).then((result) {
      if (!mounted) return;
      setState(() {
        artistUrl = result;
      });
    });
  }


  @override
  Widget build(BuildContext context) {

    //initImage(widget.item.fields.artistes).then((value) => null);

    return FutureBuilder(
        future: _getArtistImagebyArtistName(widget.item.fields.artistes),
        builder: (context, snapshot) {

          if(snapshot.hasData){
            artistUrl = snapshot.data;
          }

          return CardHorizontal(
              cta: "About",
              //title: _artistesList[index].fields.artistes,
              //infoTxt: _artistesList[index].fields.annee,
              title: widget.item.fields.artistes != null
                  ? widget.item.fields.artistes
                  : "-",
              infoTxt:
              widget.item.fields.annee != null ? widget.item.fields.annee + " edition" : "-",
              titleSize: 16,
              flexImage: 1,
              flexText: 2,
              maxLines: 2,
              img:
              artistUrl != null ? artistUrl : artistUrlDefault,
              tap: () {
                Navigator.pushNamed(context, '/profile',
                    arguments: widget.item.recordid);
                //ModalRoute.of(context).settings.arguments;
              });
        },
    );


  }
}

class SpinnerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          alignment: AlignmentDirectional.bottomCenter,
          child: Column(
            children: <Widget>[
              CircularProgressIndicator(),
            ],
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
          )),
    );
  }
}
