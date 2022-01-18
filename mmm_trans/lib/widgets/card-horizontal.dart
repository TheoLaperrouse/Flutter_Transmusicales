import 'package:flutter/material.dart';
import 'package:mmm_trans/constants/Theme.dart';

class CardHorizontal extends StatelessWidget {
  CardHorizontal(
      {this.title = "Placeholder Title",
      this.infoTxt = "",
      this.titleSize = 12,
      this.flexImage = 1,
      this.flexText = 1,
      this.maxLines = 10,
      this.cta = "",
      this.img = "https://via.placeholder.com/200",
      this.tap = defaultFunc});

  final String cta;
  final String img;
  final Function tap;
  final String title;
  final double titleSize;
  final int flexImage;
  final int flexText;
  final String infoTxt;
  final int maxLines;

  static void defaultFunc() {
    print("the function works!");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 130,
        child: GestureDetector(
          onTap: tap,
          child: Card(
            elevation: 3,
            shadowColor: NowUIColors.muted.withOpacity(0.22),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(4.0))),
            child: Row(
              children: [
                Flexible(
                  flex: this.flexImage,
                  child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(4.0),
                              bottomLeft: Radius.circular(4.0)),
                          image: DecorationImage(
                            image: NetworkImage(img),
                            fit: BoxFit.cover,
                          ))),
                ),
                Flexible(
                    flex: this.flexText,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(title,
                              style: TextStyle(
                                  color: NowUIColors.text, fontWeight: FontWeight.bold, fontSize: this.titleSize),
                              overflow: TextOverflow.ellipsis,
                              maxLines: this.maxLines,
                              softWrap: true,
                          ),
                            Text(infoTxt,
                              style: TextStyle(
                                  color: NowUIColors.secondary, fontSize: 14)),
                          Text(cta,
                              style: TextStyle(
                                  color: NowUIColors.primary,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600))
                        ],
                      ),
                    ))
              ],
            ),
          ),
        ));
  }
}
