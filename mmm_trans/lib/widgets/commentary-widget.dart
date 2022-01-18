import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mmm_trans/constants/CommentaryGradesService.dart';

class CommentaryWidget extends StatefulWidget {
  String idArtist;

  CommentaryWidget(this.idArtist);



  @override
  _CommentaryWidget createState() => _CommentaryWidget();
}

class _CommentaryWidget extends State<CommentaryWidget> {
  final messageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(

      body: TextField(maxLines: null, decoration: InputDecoration(hintText: "Write your comment"),
          controller: messageController),
      floatingActionButton: ElevatedButton(
        child: Text('Send'),
        onPressed: () {
          CommentaryGradeService.postCommentary(widget.idArtist,messageController.text);
          messageController.clear();
        },
      ),

    );
  }
}
