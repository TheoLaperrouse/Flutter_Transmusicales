import 'package:flutter/material.dart';
import 'package:mmm_trans/constants/Theme.dart';

class CardSmall extends StatelessWidget {
  CardSmall(
      {this.title = "Placeholder Title",
      this.titleSize = 12,
      this.height = 235,
      this.flexImage = 11,
      this.flexText = 9,
      this.maxLines = 10,
      this.cta = "",
      this.infoTxt = "",
      this.img = "https://via.placeholder.com/200",
      this.tap = defaultFunc});

  final String cta;
  final String img;
  final Function tap;
  final String title;
  final double titleSize;
  final double height;
  final int flexImage;
  final int flexText;
  final int maxLines;
  final String infoTxt;

  static void defaultFunc() {
    print("the function works!");
  }

  @override
  Widget build(BuildContext context) {
    return Flexible(
        child: Container(
      height: this.height,
      child: GestureDetector(
        onTap: tap,
        child: Card(
            elevation: 3,
            shadowColor: NowUIColors.muted.withOpacity(0.22),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(4.0))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                    flex: this.flexImage,
                    child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(4.0),
                                topRight: Radius.circular(4.0)),
                            image: DecorationImage(
                              image: NetworkImage(img),
                              fit: BoxFit.cover,
                            )))),
                Flexible(
                    flex: this.flexText,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 16.0, bottom: 16.0, left: 16.0, right: 16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(title,
                              style: TextStyle(
                                  color: NowUIColors.text, fontSize: titleSize),
                            overflow: TextOverflow.ellipsis,
                            maxLines: this.maxLines,
                            softWrap: true,),
                          Text(infoTxt,
                            style: TextStyle(
                                color: NowUIColors.secondary, fontSize: 14),
                            overflow: TextOverflow.ellipsis,
                            maxLines: this.maxLines,
                            softWrap: true,),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(cta,
                                style: TextStyle(
                                    color: NowUIColors.primary,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600)),
                          )
                        ],
                      ),
                    ))
              ],
            )),
      ),
    ));
  }
}
