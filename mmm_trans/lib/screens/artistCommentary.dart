import 'package:flutter/material.dart';
import 'package:mmm_trans/widgets/commentary-widget.dart';
import 'package:mmm_trans/widgets/list-commentaire.dart';
import 'package:mmm_trans/widgets/navbar.dart';
import 'package:mmm_trans/widgets/drawer.dart';

class artistCommentary extends StatefulWidget {
  String idArtist;
  String nomArtist;

  @override
  _Commentary createState() => _Commentary();
}

class _Commentary extends State<artistCommentary> {
  @override
  Widget build(BuildContext context) {
    var idArtist = ModalRoute.of(context).settings.arguments;
    return Scaffold(
        appBar: Navbar(
          prefferedHeight: 65.0,
          backButton: true,
          title: "Commentary",
        ),
        drawer: NowDrawer(currentPage: "Settings"),
        body: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Flexible(
                flex: 9,
                child: Container(
                    color: Colors.amber[500], child: ListCommentaire(idArtist)),
              ),
              Flexible(
                flex: 1,
                child: Container(
                  //alignment: Alignment.bottomCenter,
                  //height: 50,
                  color: Colors.amber[600],
                  child: CommentaryWidget(idArtist),
                ),
              )
            ],
          ),
        ));
  }
}
