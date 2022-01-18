import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mmm_trans/screens/artistMapLocation.dart';
import 'package:mmm_trans/screens/artistCommentary.dart';
import 'package:mmm_trans/screens/home.dart';
import 'package:mmm_trans/screens/map.dart';
import 'package:mmm_trans/screens/profile.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Transmusicales',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(fontFamily: 'Montserrat'),
        initialRoute: '/home',
        routes: <String, WidgetBuilder>{
          '/home': (BuildContext context) => new Home(),
          "/map": (BuildContext context) => new Map(),
          "/profile": (BuildContext context) => new Profile(),
          "/commentary": (BuildContext context) => new artistCommentary(),
          "/artistLocation": (BuildContext context) => new artistMapLocation(),
        });
  }
}
