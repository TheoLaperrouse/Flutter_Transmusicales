import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:spotify/spotify.dart';

class CommentaryGradeService {
  static final CollectionReference commentaireCollection =
      FirebaseFirestore.instance.collection("commentary");
  static final CollectionReference gradeCollection =
      FirebaseFirestore.instance.collection("grade");

  static Stream<QuerySnapshot> get commentaireStream {
    return commentaireCollection
        .orderBy("writtenDate", descending: true)
        .snapshots();
  }

  static Future<DocumentReference> postCommentary(
      String artiste, String commentaire) {
    return commentaireCollection.add({
      'artiste': artiste,
      'commentaire': commentaire,
      'writtenDate': Timestamp.now().toDate(),
    });
  }

  static Future<double> getGrade(String artiste) async {
    double moyenne;
    await gradeCollection
        .where("idArtist", isEqualTo: artiste)
        .limit(1)
        .get()
        .then((value) => value.docs.forEach((element) {
      moyenne = element.data()["moyenne"];
    }));
    return moyenne;
  }


  static Future<int> postGrade(String artiste, double grade, String userUid) async {
    var moyenne;
    var nbreNotes;
    var documentID;
    List<dynamic> userVotes = [];
    await gradeCollection
        .where("idArtist", isEqualTo: artiste)
        .limit(1)
        .get()
        .then((value) => value.docs.forEach((element) {
              moyenne = element.data()["moyenne"];
              nbreNotes = element.data()["nbreNotes"];
              documentID = element.id;
              userVotes = element.data()["userVotes"];
            }));

    if (moyenne != null && nbreNotes != null) {
      if(userVotes.contains(userUid)){
        print('Déjà Voté');
        return 0;
      }
      else{
        userVotes.add(userUid);
        moyenne = (moyenne*nbreNotes + grade) / (nbreNotes + 1);
        nbreNotes += 1;

        await gradeCollection
            .doc(documentID)
            .set({'idArtist':artiste,"moyenne": moyenne, "nbreNotes": nbreNotes,"userVotes" : userVotes}).then(
                (value) => {print("Document successfully updated!")});
      }
    } else {
      userVotes.add(userUid);
      gradeCollection.add({
        'idArtist': artiste,
        'moyenne': grade,
        'nbreNotes': 1,
        'userVotes' : userVotes
      });
    }
    return 1;
  }

}
