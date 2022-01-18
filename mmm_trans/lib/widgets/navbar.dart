import 'package:filter_list/filter_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mmm_trans/constants/Theme.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import 'input.dart';


class Navbar extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final String categoryOne;
  final String categoryTwo;
  final bool searchBar;
  final bool backButton;
  final bool transparent;
  final bool reverseTextcolor;
  final bool rightOptions;
  final Map<String,List<String>> filters;
  final Function applyFilters;
  final bool isOnSearch;
  final TextEditingController searchController;
  final Function searchOnChanged;
  final bool searchAutofocus;
  final bool noShadow;
  final Color bgColor;
  num prefferedHeight = 180.0;

  Navbar(
      {this.title = "Home",
      this.categoryOne = "",
      this.categoryTwo = "",
      this.filters,
      this.transparent = false,
      this.rightOptions = true,
      this.reverseTextcolor = false,
      this.applyFilters,
      this.searchController,
      this.isOnSearch = false,
      this.searchOnChanged,
      this.searchAutofocus = false,
      this.backButton = false,
      this.noShadow = false,
      this.bgColor = NowUIColors.white,
      this.searchBar = false,
        this.prefferedHeight = 180.0});

 // double _prefferedHeight = 60.0;


  @override
  _NavbarState createState() => _NavbarState();

  @override
  Size get preferredSize => Size.fromHeight(this.prefferedHeight);
}

class _NavbarState extends State<Navbar> {


  Map<String,List<String>> activeFilters = {};

  ItemScrollController _scrollController = ItemScrollController();

  void initState() {
    super.initState();

  }

  void _openFilterDialog(String filterName, List<String> completeList) async {
    await FilterListDialog.display(context,
        allTextList: completeList,
        height: 480,
        borderRadius: 20,
        headlineText: "Filter on "+filterName,
        searchFieldHintText: "Search Here",
        selectedTextList: activeFilters[filterName], onApplyButtonClick: (list) {
          if (list != null) {
            setState(() {

              if(list.toList().isEmpty){
                activeFilters.remove(filterName);
              }
              else{
                activeFilters.update(filterName, (value) => list.toList(), ifAbsent: () => list.toList());
              }

              widget.applyFilters(activeFilters);
            });
            Navigator.pop(context);
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    final bool categories =
        widget.categoryOne.isNotEmpty && widget.categoryTwo.isNotEmpty;
    final bool filtersExist =
        widget.filters == null ? false : (widget.filters.length == 0 ? false : true);


    return Container(
        height: widget.searchBar
            ? (!categories
                ? (filtersExist ? 211.0 : 178.0)
                : (filtersExist ? 262.0 : 210.0))
            : (!categories
                ? (filtersExist ? 162.0 : 102.0)
                : (filtersExist ? 200.0 : 150.0)),
        decoration: BoxDecoration(
            color: !widget.transparent ? widget.bgColor : Colors.transparent,
            boxShadow: [
              BoxShadow(
                  color: !widget.transparent && !widget.noShadow
                      ? NowUIColors.muted
                      : Colors.transparent,
                  spreadRadius: -10,
                  blurRadius: 12,
                  offset: Offset(0, 5))
            ]),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 7, left: 8.0, right: 8.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        IconButton(
                            icon: Icon(
                                !widget.backButton
                                    ? Icons.menu
                                    : Icons.arrow_back_ios,
                                color: !widget.transparent
                                    ? (widget.bgColor == NowUIColors.white
                                        ? NowUIColors.text
                                        : NowUIColors.white)
                                    : (widget.reverseTextcolor
                                        ? NowUIColors.text
                                        : NowUIColors.white),
                                size: 24.0),
                            onPressed: () {
                              if (!widget.backButton)
                                Scaffold.of(context).openDrawer();
                              else
                                Navigator.pop(context);
                            }),
                        Text(widget.title,
                            style: TextStyle(
                                color: !widget.transparent
                                    ? (widget.bgColor == NowUIColors.white
                                        ? NowUIColors.text
                                        : NowUIColors.white)
                                    : (widget.reverseTextcolor
                                        ? NowUIColors.text
                                        : NowUIColors.white),
                                fontWeight: FontWeight.w400,
                                fontSize: 18.0)),
                      ],
                    )
                  ],
                ),
                if (widget.searchBar)
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 8, bottom: 4, left: 15, right: 15),
                    child: Input(
                        placeholder: "Search an artist by his name ...",
                        controller: widget.searchController,
                        onChanged: (value){
                          widget.searchOnChanged(value);
                          },
                        autofocus: widget.searchAutofocus,
                        suffixIcon: Icon(
                          Icons.zoom_in,
                          color: NowUIColors.time,
                          size: 20,
                        ),
                        onTap: () {
                          // if (!widget.isOnSearch)
                          //   Navigator.push(
                          //       context,
                          //       MaterialPageRoute(
                          //           builder: (context) => Search()));
                        }),
                  ),
                SizedBox(
                  height: 10.0,
                ),
                if (categories)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => Trending()));
                        },
                        child: Row(
                          children: [
                            Icon(Icons.camera,
                                color: NowUIColors.text, size: 18.0),
                            SizedBox(width: 8),
                            Text(widget.categoryOne,
                                style: TextStyle(
                                    color: NowUIColors.text, fontSize: 14.0)),
                          ],
                        ),
                      ),
                      SizedBox(width: 30),
                      Container(
                        color: NowUIColors.text,
                        height: 25,
                        width: 1,
                      ),
                      SizedBox(width: 30),
                      GestureDetector(
                        onTap: () {
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => Fashion()));
                        },
                        child: Row(
                          children: [
                            Icon(Icons.shopping_cart,
                                color: NowUIColors.text, size: 18.0),
                            SizedBox(width: 8),
                            Text(widget.categoryTwo,
                                style: TextStyle(
                                    color: NowUIColors.text, fontSize: 14.0)),
                          ],
                        ),
                      )
                    ],
                  ),
                if (filtersExist)
                  Container(
                    height: 40,
                    child: ScrollablePositionedList.builder(
                      itemScrollController: _scrollController,
                      scrollDirection: Axis.horizontal,
                      itemCount: widget.filters.length,
                      itemBuilder: (BuildContext context, int index) {

                        String filterName = widget.filters.keys.toList()[index];

                        return GestureDetector(
                          onTap: () {
                            if(activeFilters != null){
                              if (activeFilters.containsKey(filterName)) {
                                _openFilterDialog(filterName,widget.filters[filterName]);
                              }
                              else{
                                activeFilters.putIfAbsent(filterName, () => []);
                                _openFilterDialog(filterName,widget.filters[filterName]);
                              }
                            }
                          },
                          child: Container(
                              margin: EdgeInsets.only(
                                  left: index == 0 ? 10 : 8, right: 8),
                              padding: EdgeInsets.only(
                                  top: 4, bottom: 4, left: 20, right: 20),
                              // width: 90,
                              decoration: BoxDecoration(
                                  color: activeFilters != null && activeFilters.containsKey(filterName) && activeFilters[filterName].isNotEmpty
                                      ? NowUIColors.info
                                      : NowUIColors.tabs,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(54.0))),
                              child: Center(
                                child: Text(filterName,
                                    style: TextStyle(
                                        color: activeFilters != null && activeFilters.containsKey(filterName) && activeFilters[filterName].isNotEmpty
                                            ? NowUIColors.white
                                            : NowUIColors.black,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14.0)),
                              )),
                        );
                      },
                    ),
                  )
              ],
            ),
          ),
        ));
  }
}
