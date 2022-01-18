import 'package:bad_words/bad_words.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mmm_trans/constants/CommentaryGradesService.dart';
import 'package:mmm_trans/constants/Theme.dart';

class ListCommentaire extends StatefulWidget {
  String IdArtist;

  ListCommentaire(this.IdArtist);

  @override
  _ListCommentaire createState() => _ListCommentaire();
}

class _ListCommentaire extends State<ListCommentaire> {

  String cleanWord(String word) {
    final filter = Filter();
    // check if the string is profane
    if (filter.isProfane(word)) {
      print('The comment contains bad vocabulary !');
    }
    // clean up those bad words
    return filter.clean(word);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: CommentaryGradeService.commentaireStream,
        builder: (context, snapshot) {
          return Scaffold(
            body: ListView.builder(
                itemCount: snapshot.data != null && snapshot.data.docs != null
                    ? snapshot.data.docs.length
                    : 0,
                // ignore: missing_return
                itemBuilder: (BuildContext context, int index) {
                  if (snapshot.data.docs != null) {
                    if (snapshot.data.docs[index].get('artiste') ==
                        widget.IdArtist) {
                      return Card(
                          child:
                  ListTile(
                      trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Icon(Icons.warning_amber_outlined),
                          ]),
                            tileColor: NowUIColors.border,
                              title: Text(snapshot.data.docs[index]
                                          .get('commentaire') ==
                                      null
                                  ? '' : cleanWord(snapshot.data.docs[index].get('commentaire')).toString() )));
                    }
                  }
                }),
          );
        });
  }
}
