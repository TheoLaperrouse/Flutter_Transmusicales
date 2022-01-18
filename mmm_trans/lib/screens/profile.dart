import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:mmm_trans/constants/AuthService.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:logger/logger.dart';
import 'package:mmm_trans/constants/CommentaryGradesService.dart';
import 'package:mmm_trans/constants/Theme.dart';
import 'package:mmm_trans/constants/TransData.dart';
import 'package:mmm_trans/widgets/drawer.dart';
import 'package:mmm_trans/widgets/navbar.dart';
import 'package:spotify/spotify.dart';
import 'package:spotify_sdk/spotify_sdk.dart';

class Profile extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Profile> {
  final Logger _logger = Logger();
  bool _loading = false;
  bool _connected = false;
  String authorName = "Unknown";
  String defaultImageArtiste =
      "https://myfanproduction.nyc3.digitaloceanspaces.com/assets/default_music-2029fd95fc23619604423e93786d424e75e0928ff52f65cd5b6cbc342ce672b1.png";
  int followers;
  int popularity;
  String albumUrl;
  String albumName;
  String albumUri;
  String imageArtist;
  String dateSortie;
  bool initDone = false;
  String statusSpotify;
  String artistToSearch;
  TransData artistJsonInfo;
  double moyenneArtist;

  Future _initFunctionSpotify(artistToSearch) async {
    var credentials = SpotifyApiCredentials(
        "6abd6b78ccf449fd833bc034dad9fc23", "5cdbaa929d284903a847e3aca84c8687");
    var spotify = SpotifyApi(credentials);
    var search = await spotify.search
        .get(artistToSearch)
        .first(1)
        .catchError((e) => print(""));
    if (search == null) {
      return;
    }

    search.forEach((pages) {
      if (pages != null && pages.items != null && pages.items.isNotEmpty) {
        pages.items.forEach((item) {
          if (item is Artist) {
            setState(() {
              authorName = item.name;
              followers = item.followers.total;
              popularity = item.popularity;
              if (item.images != null && item.images.isNotEmpty) {
                imageArtist = item.images.first.url;
              }
            });
          }
          if (item is AlbumSimple) {
            setState(() {
              albumName = item.name;
              dateSortie = item.releaseDate;
              albumUri = item.uri;
              albumUrl = item.images.first.url;
            });
          }
        });
      }
    });
  }

  void updateMoyenne(String artistName) async {
    var moy = await CommentaryGradeService.getGrade(artistName);
    setState(() {
      moyenneArtist = moy;
    });
  }

  Future<String> _intitArtistDataFromJson(String artistId) async {
    if (!initDone) {
      // Get Json File
      List<TransData> transData = await getDataFromJson();
      // Get ArtistId
      List<TransData> a =
          transData.where((element) => element.recordid == artistId).toList();
      artistJsonInfo = a[0];
      // Get artist information from Spotify
      await _initFunctionSpotify(artistJsonInfo.fields.artistes);
      // Get the artist's grade
      moyenneArtist =
          await CommentaryGradeService.getGrade(artistJsonInfo.fields.artistes);
      // ignore: unnecessary_statements
      moyenneArtist != null
          ? ((num.parse(moyenneArtist.toStringAsFixed(1)) * 2).round() / 2)
          : null;
    }
    initDone = true;
    return "";
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    artistToSearch = ModalRoute.of(context).settings.arguments;

    return new FutureBuilder<String>(
      future: _intitArtistDataFromJson(artistToSearch),
      // a Future<String> or null
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return new Text('Press button to start');
          case ConnectionState.waiting:
            return new Container(
              color: Colors.white,
              child: Center(child: CircularProgressIndicator()),
            );
          default:
            if (snapshot.hasError)
              return new Text('Error: ${snapshot.error}');
            else
              return Scaffold(
                  extendBodyBehindAppBar: true,
                  appBar: Navbar(
                    backButton: true,
                    prefferedHeight: 100.0,
                    title: "Artist Profile",
                    transparent: true,
                  ),
                  backgroundColor: NowUIColors.bgColorScreen,
                  drawer: NowDrawer(currentPage: "Home"),
                  body: Stack(
                    children: <Widget>[
                      Column(
                        children: [
                          Flexible(
                            flex: 1,
                            child: Container(
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            "assets/imgs/bg-profile.png"),
                                        fit: BoxFit.cover)),
                                child: Stack(
                                  children: <Widget>[
                                    SafeArea(
                                      bottom: false,
                                      right: false,
                                      left: false,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 0, right: 0),
                                        child: Column(
                                          children: [
                                            CircleAvatar(
                                                backgroundImage: NetworkImage(
                                                    imageArtist != null
                                                        ? imageArtist
                                                        : defaultImageArtiste),
                                                radius: 55.0),
                                            Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 24.0),
                                                child: Text(
                                                    authorName != null
                                                        ? authorName
                                                        : "Unknown",
                                                    style: TextStyle(
                                                        fontSize: 30,
                                                        color: NowUIColors
                                                            .white))),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 8.0),
                                              child: RatingBar.builder(
                                                tapOnlyMode: true,
                                                itemSize: 20,
                                                initialRating:
                                                    moyenneArtist != null
                                                        ? moyenneArtist
                                                        : 0,
                                                direction: Axis.horizontal,
                                                allowHalfRating: true,
                                                itemCount: 5,
                                                itemPadding:
                                                    EdgeInsets.symmetric(
                                                        horizontal: 4.0),
                                                itemBuilder: (context, _) =>
                                                    Icon(
                                                  Icons.star,
                                                  color: Colors.amber,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 24.0,
                                                  left: 42,
                                                  right: 32),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                          followers != null
                                                              ? followers
                                                                  .toString()
                                                              : "Unknown",
                                                          style: TextStyle(
                                                              fontSize: 16,
                                                              color: NowUIColors
                                                                  .white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold)),
                                                      Text("Followers",
                                                          style: TextStyle(
                                                              fontSize: 16,
                                                              color: NowUIColors
                                                                  .white))
                                                    ],
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                          popularity != null
                                                              ? popularity
                                                                  .toString()
                                                              : "Unknown",
                                                          style: TextStyle(
                                                              color: NowUIColors
                                                                  .white,
                                                              fontSize: 16.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold)),
                                                      Text("Popularity",
                                                          style: TextStyle(
                                                              fontSize: 16,
                                                              color: NowUIColors
                                                                  .white))
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                )),
                          ),
                          Flexible(
                            flex: 1,
                            child: Container(
                                child: SingleChildScrollView(
                                    child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 50.0, right: 50.0, top: 20.0),
                              child: Column(children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8.0, bottom: 10.0),
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text("Artist Info",
                                        style: TextStyle(
                                            fontSize: 30,
                                            color: NowUIColors.text)),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.center,
                                  child: Text("Edition",
                                      style: TextStyle(
                                          fontSize: 21,
                                          color: NowUIColors.text)),
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                      artistJsonInfo != null &&
                                              artistJsonInfo.fields != null &&
                                              artistJsonInfo.fields.edition !=
                                                  null
                                          ? editionValues.reverse[
                                                  artistJsonInfo.fields.edition]
                                              .toString()
                                          : "Unknown",
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: NowUIColors.text)),
                                ),
                                Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(20, 20, 20, 20),
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              Align(
                                                alignment: Alignment.center,
                                                child: Text("Year",
                                                    style: TextStyle(
                                                        fontSize: 21,
                                                        color:
                                                            NowUIColors.text)),
                                              ),
                                              Align(
                                                alignment: Alignment.center,
                                                child: Text(
                                                    artistJsonInfo != null &&
                                                            artistJsonInfo
                                                                    .fields !=
                                                                null &&
                                                            artistJsonInfo
                                                                    .fields
                                                                    .annee !=
                                                                null
                                                        ? artistJsonInfo
                                                            .fields.annee
                                                        : "Unknown",
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        color:
                                                            NowUIColors.text)),
                                              ),
                                            ]),
                                      ),
                                      Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(20, 0, 0, 0),
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              Align(
                                                alignment: Alignment.center,
                                                child: Text("Country",
                                                    style: TextStyle(
                                                        fontSize: 21,
                                                        color:
                                                            NowUIColors.text)),
                                              ),
                                              Align(
                                                alignment: Alignment.center,
                                                child: Text(
                                                    artistJsonInfo != null &&
                                                            artistJsonInfo
                                                                    .fields !=
                                                                null
                                                        ? artistJsonInfo.fields
                                                                    .couTextEn !=
                                                                "Unknown"
                                                            ? artistJsonInfo
                                                                .fields
                                                                .couTextEn
                                                            : artistJsonInfo
                                                                .fields
                                                                .originePays1
                                                        : "Unknown",
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        color:
                                                            NowUIColors.text)),
                                              ),
                                            ]),
                                      ),
                                    ]),
                                Padding(
                                    padding:
                                        EdgeInsets.fromLTRB(20, 20, 20, 20),
                                    child: Text("Best Album",
                                        style: TextStyle(
                                            fontSize: 30,
                                            color: NowUIColors.text))),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: CachedNetworkImage(
                                        imageUrl: albumUrl != null
                                            ? albumUrl
                                            : defaultImageArtiste,
                                        placeholder: (context, url) =>
                                            new CircularProgressIndicator(),
                                        errorWidget: (context, url, error) =>
                                            new Icon(Icons.error),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  20, 10, 10, 10),
                                              child: Text("Album Name",
                                                  style: TextStyle(
                                                      color: NowUIColors.text,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 15.0),
                                                  textAlign: TextAlign.center)),
                                          Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                20, 0, 0, 0),
                                            child: Text(
                                                albumName != null
                                                    ? albumName
                                                    : "Unknown",
                                                textAlign: TextAlign.center),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                20, 10, 10, 10),
                                            child: Text("Release Date",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color: NowUIColors.text,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 15.0)),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                20, 0, 0, 0),
                                            child: Text(
                                                dateSortie != null
                                                    ? dateSortie
                                                    : "Unknown",
                                                textAlign: TextAlign.center),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(10, 20, 0, 0),
                                  child: Text(
                                      "Listen to " + authorName + " music.",
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: NowUIColors.muted)),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    IconButton(
                                      icon: Icon(Icons.skip_previous),
                                      onPressed: skipPrevious,
                                    ),
                                    IconButton(
                                      icon: Icon(Icons.play_arrow),
                                      onPressed: () async {
                                        await play().then((value) => {
                                              setState(() {
                                                statusSpotify = value;
                                              })
                                            });
                                      },
                                    ),
                                    IconButton(
                                      icon: Icon(Icons.pause),
                                      onPressed: () async {
                                        await pause().then((value) => {
                                              setState(() {
                                                statusSpotify = value;
                                              })
                                            });
                                      },
                                    ),
                                    IconButton(
                                      icon: Icon(Icons.skip_next),
                                      onPressed: skipNext,
                                    ),
                                  ],
                                ),
                                Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                      statusSpotify != null
                                          ? statusSpotify
                                          : "",
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: NowUIColors.text)),
                                ),
                                Align(
                                  alignment: Alignment.center,
                                  child: Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(20, 20, 20, 20),
                                      child: Text("Rate This Artist",
                                          style: TextStyle(
                                              fontSize: 28,
                                              color: NowUIColors.text))),
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 50),
                                  child: RatingBar.builder(
                                      glow: true,
                                      itemSize: 40,
                                      initialRating: 4,
                                      minRating: 1,
                                      direction: Axis.horizontal,
                                      allowHalfRating: true,
                                      itemCount: 5,
                                      itemPadding:
                                          EdgeInsets.symmetric(horizontal: 4.0),
                                      itemBuilder: (context, _) => Icon(
                                            Icons.star,
                                            color: Colors.amber,
                                          ),
                                      onRatingUpdate: (rating) async {
                                        await AuthService.signInAnonymously();
                                        if (await CommentaryGradeService
                                                .postGrade(
                                                    artistJsonInfo
                                                        .fields.artistes,
                                                    rating,
                                                    AuthService.getUid()) ==
                                            0) {
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) =>
                                                _buildPopupDialog(context),
                                          );
                                        }
                                        updateMoyenne(artistJsonInfo
                                            .fields.artistes);
                                      }),
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
                                  child: SizedBox(
                                    width: double.infinity,
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 8),
                                      child: RaisedButton(
                                        textColor: NowUIColors.white,
                                        color: NowUIColors.info,
                                        onPressed: () {
                                          // Respond to button press

                                          Navigator.pushNamed(
                                              context, '/commentary',
                                              arguments: artistToSearch);
                                        },
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(4.0),
                                        ),
                                        child: Padding(
                                            padding: EdgeInsets.only(
                                                left: 16.0,
                                                right: 16.0,
                                                top: 12,
                                                bottom: 12),
                                            child: Text(
                                                "Get " +
                                                    authorName +
                                                    " commentary",
                                                style:
                                                    TextStyle(fontSize: 14.0))),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 50),
                                  child: SizedBox(
                                    width: double.infinity,
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 8),
                                      child: RaisedButton(
                                        textColor: NowUIColors.white,
                                        color: NowUIColors.socialFacebook,
                                        onPressed: () {
                                          // Respond to button press

                                          Navigator.pushNamed(
                                              context, '/artistLocation',
                                              arguments: artistToSearch);
                                        },
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(4.0),
                                        ),
                                        child: Padding(
                                            padding: EdgeInsets.only(
                                                left: 16.0,
                                                right: 16.0,
                                                top: 12,
                                                bottom: 12),
                                            child: Text(
                                                "Get " +
                                                    authorName +
                                                    " location",
                                                style:
                                                    TextStyle(fontSize: 14.0))),
                                      ),
                                    ),
                                  ),
                                ),
                              ]),
                            ))),
                          ),
                        ],
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 0.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: [],
                          ),
                        ),
                      )
                    ],
                  ));
        }
      },
    );
  }

  Widget _buildPopupDialog(BuildContext context) {
    return new AlertDialog(
      title: const Text('Unrecorded vote'),
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('You have already voted for this artist'),
        ],
      ),
      actions: <Widget>[
        new FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          textColor: Theme.of(context).primaryColor,
          child: const Text('Close'),
        ),
      ],
    );
  }

  Future<void> connectToSpotifyRemote() async {
    try {
      setState(() {
        _loading = true;
      });
      var result = await SpotifySdk.connectToSpotifyRemote(
          clientId: "6abd6b78ccf449fd833bc034dad9fc23",
          redirectUrl: "https://www.spotify.com/fr/");
      setStatus(result
          ? 'connect to spotify successful'
          : 'connect to spotify failed');
      setState(() {
        _loading = false;
      });
    } on PlatformException catch (e) {
      setState(() {
        _loading = false;
      });
      setStatus(e.code, message: e.message);
    } on MissingPluginException {
      setState(() {
        _loading = false;
      });
      setStatus('not implemented');
    }
  }

  Future<String> getAuthenticationToken() async {
    try {
      var authenticationToken = await SpotifySdk.getAuthenticationToken(
          clientId: "6abd6b78ccf449fd833bc034dad9fc23",
          redirectUrl: "https://www.spotify.com/fr/",
          scope: 'app-remote-control, '
              'user-modify-playback-state, '
              'playlist-read-private, '
              'playlist-modify-public,user-read-currently-playing');
      setStatus('Got a token: $authenticationToken');
      return authenticationToken;
    } on PlatformException catch (e) {
      setStatus(e.code, message: e.message);
      return Future.error('$e.code: $e.message');
    } on MissingPluginException {
      setStatus('not implemented');
      return Future.error('not implemented');
    }
  }

  Future<String> play() async {
    try {
      await connectToSpotifyRemote();
      await getAuthenticationToken();
      await SpotifySdk.play(spotifyUri: albumUri);
      await SpotifySdk.resume();
      return "Currently playing";
    } on PlatformException catch (e) {
      setStatus(e.code, message: e.message);
      return "Not playing";
    } on MissingPluginException {
      return "Error Connecting to Soptify";
    } catch (error) {
      return "Error Connecting to Soptify";
    }
  }

  Future<String> pause() async {
    try {
      await SpotifySdk.pause();
      return "Music is paused";
    } on PlatformException catch (e) {
      return "Error while pausing";
    } on MissingPluginException {
      return "Error while pausing";
    }
  }

  Future<void> skipNext() async {
    try {
      await SpotifySdk.skipNext();
    } on PlatformException catch (e) {
      setStatus(e.code, message: e.message);
    } on MissingPluginException {
      setStatus('not implemented');
    }
  }

  Future<void> skipPrevious() async {
    try {
      await SpotifySdk.skipPrevious();
    } on PlatformException catch (e) {
      setStatus(e.code, message: e.message);
    } on MissingPluginException {
      setStatus('not implemented');
    }
  }

  void setStatus(String code, {String message = ''}) {
    var text = message.isEmpty ? '' : ' : $message';
    _logger.d('$code$text');
  }
}
