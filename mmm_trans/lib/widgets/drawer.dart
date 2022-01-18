import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mmm_trans/constants/Theme.dart';
import 'package:url_launcher/url_launcher.dart';

import 'drawer-tile.dart';

class NowDrawer extends StatelessWidget {
  final String currentPage;

  NowDrawer({this.currentPage});

  _launchURL() async {
    const url = 'https://creative-tim.com';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Container(
      //color: NowUIColors.socialFacebook,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [NowUIColors.info, NowUIColors.socialFacebook],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.0, 0.8],
              tileMode: TileMode.clamp,
            ),
          ),
        child: Column(children: [
          Container(
              height: MediaQuery.of(context).size.height * 0.15,
              width: MediaQuery.of(context).size.width * 0.85,
              child: SafeArea(
                bottom: false,
                child: Padding(
                  padding: const EdgeInsets.only(left: 24.0, right: 20.0, top: 11.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    // crossAxisAlignment: CrossAxisAlignment.baseline,
                    children: [
                      Image.asset("assets/imgs/trans.png",),
                      Padding(
                        padding: const EdgeInsets.only(top: 0),
                        child: IconButton(
                            icon: Icon(Icons.menu,
                                color: NowUIColors.white.withOpacity(0.82),
                                size: 24.0),
                            onPressed: () {
                              Navigator.of(context).pop();
                            }),
                      ),
                    ],
                  ),
                ),
              )),
          Expanded(
            flex: 2,
            child: ListView(
              padding: EdgeInsets.only(top: 25, left: 8, right: 16),
              children: [
                DrawerTile(
                    icon: FontAwesomeIcons.music,
                    onTap: () {
                      if (currentPage != "Home")
                        Navigator.pushReplacementNamed(context, '/home');
                    },
                    iconColor: NowUIColors.primary,
                    title: "Artists",
                    isSelected: currentPage == "Home" ? true : false),
                /*DrawerTile(
                    icon: FontAwesomeIcons.dharmachakra,
                    onTap: () {
                      if (currentPage != "Components")
                        Navigator.pushReplacementNamed(context, '/components');
                    },
                    iconColor: NowUIColors.error,
                    title: "Components",
                    isSelected: currentPage == "Components" ? true : false),
                DrawerTile(
                    icon: FontAwesomeIcons.newspaper,
                    onTap: () {
                      if (currentPage != "Articles")
                        Navigator.pushReplacementNamed(context, '/articles');
                    },
                    iconColor: NowUIColors.primary,
                    title: "Articles",
                    isSelected: currentPage == "Articles" ? true : false),
                DrawerTile(
                    icon: FontAwesomeIcons.user,
                    onTap: () {
                      if (currentPage != "Profile")
                        Navigator.pushReplacementNamed(context, '/profile');
                    },
                    iconColor: NowUIColors.warning,
                    title: "Profile",
                    isSelected: currentPage == "Profile" ? true : false),
                DrawerTile(
                    icon: FontAwesomeIcons.fileInvoice,
                    onTap: () {
                      if (currentPage != "Account")
                        Navigator.pushReplacementNamed(context, '/account');
                    },
                    iconColor: NowUIColors.info,
                    title: "Account",
                    isSelected: currentPage == "Account" ? true : false),*/
                DrawerTile(
                    icon: FontAwesomeIcons.mapMarked,
                    onTap: () {
                      if (currentPage != "Map")
                        Navigator.pushReplacementNamed(context, '/map');
                    },
                    iconColor: NowUIColors.success,
                    title: "Map",
                    isSelected: currentPage == "Map" ? true : false),

                /*DrawerTile(
                    icon: FontAwesomeIcons.cog,
                    onTap: () {
                      if (currentPage != "Settings")
                        Navigator.pushReplacementNamed(context, '/spotify');
                    },
                    iconColor: NowUIColors.success,
                    title: "Spotify",
                    isSelected: currentPage == "Settings" ? true : false),*/
              ],
            ),
          ),
          /*Expanded(
            flex: 1,
            child: Container(
                padding: EdgeInsets.only(left: 8, right: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Divider(
                        height: 4,
                        thickness: 0,
                        color: NowUIColors.white.withOpacity(0.8)),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 16.0, left: 16, bottom: 8),
                      child: Text("DOCUMENTATION",
                          style: TextStyle(
                            color: NowUIColors.white.withOpacity(0.8),
                            fontSize: 13,
                          )),
                    ),
                    DrawerTile(
                        icon: FontAwesomeIcons.satellite,
                        onTap: _launchURL,
                        iconColor: NowUIColors.muted,
                        title: "Getting Started",
                        isSelected:
                            currentPage == "Getting started" ? true : false),
                  ],
                )),
          ),*/
        ]),
    ));
  }
}
