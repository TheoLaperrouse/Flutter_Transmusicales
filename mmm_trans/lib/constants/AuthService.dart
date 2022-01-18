import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  static FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<User> get user {
    return _auth.authStateChanges();
  }
  static Future<void> signInAnonymously() async{
    await _auth.signInAnonymously();
  }

  static String getUid() {
    return _auth.currentUser.uid;
  }
}
