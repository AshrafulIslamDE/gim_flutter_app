import 'package:customer/core/localization/AppTranslation.dart';
import 'package:customer/utils/common_utils.dart';
import 'package:customer/utils/screen_dimension_utils.dart';
import 'package:customer/utils/ui_utils.dart';
import 'package:customer/utils/image_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SpinnerWidget extends StatelessWidget {
  List items;
  final bool withImg;
  final Function onSelected;

  SpinnerWidget({this.items, this.onSelected, this.withImg = false}) {
    if (items == null) items = List();
  }

  @override
  Widget build(BuildContext context) {
    int mIndex = 0;

    return Container(
      height: MediaQuery.of(context).copyWith().size.height / 3,
      color: isDarkModeEnabled() ? Colors.black : Colors.white,
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              CupertinoButton(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    translate(context, "txt_cancel"),
                    style: TextStyle(
                        color: isDarkModeEnabled()
                            ? Colors.white
                            : Colors.lightBlue,
                        fontSize: 20),
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              Expanded(
                child: CupertinoButton(
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      translate(context, 'clear_selection'),
                      style: TextStyle(
                          color: isDarkModeEnabled()
                              ? Colors.white
                              : Colors.lightBlue,
                          fontSize: 20),
                    ),
                  ),
                  onPressed: () {
                    onSelected(null);
                    Navigator.pop(context);
                  },
                ),
              ),
              CupertinoButton(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    translate(context, "txt_done"),
                    style: TextStyle(
                        color: isDarkModeEnabled()
                            ? Colors.white
                            : Colors.lightBlue,
                        fontSize: 20),
                  ),
                ),
                onPressed: () {
                  if (!isNullOrEmptyList(items)) onSelected(items[mIndex]);
                  Navigator.pop(context);
                },
              ),
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 14.0, right: 14.0),
              child: CupertinoPicker(
                  itemExtent: 46.0,
                  backgroundColor:
                      isDarkModeEnabled() ? Colors.black : Colors.white,
                  onSelectedItemChanged: (int index) {
                    mIndex = index;
                  },
                  children:
                      new List<Widget>.generate(items.length, (int index) {
                    return new Center(
                      child: withImg
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                /*items[index].image != null
                                    ? getNetworkImage(context,
                                        width: 35,
                                        height: 20,
                                        url: items[index].image,
                                        fit: BoxFit.fill,
                                        placeHolderImage: 'images/logo_tsp.png')
                                    : Container()*/
                                items[index].image!=null? getNetworkImageProvider(
                                        height: 20.0,
                                        width: 35.0,
                                        placeHolderImage: 'images/logo_tsp.png',
                                        url: items[index].image):Container()
                                ,
                                SizedBox(
                                  width: 4.0,
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  child: Text(
                                    items[index].toString(),
                                    style: TextStyle(
                                        height: 0.77,
                                        fontFamily: 'roboto',
                                        fontSize: responsiveTextSize(16.0),
                                        color: isDarkModeEnabled()
                                            ? Colors.white
                                            : Colors.black),
                                  ),
                                )
                              ],
                            )
                          : Container(
                              alignment: Alignment.center,
                              child: Text(items[index].toString(),
                                  style: TextStyle(
                                      fontFamily: 'roboto',
                                      fontSize: responsiveTextSize(16.0),
                                      color: isDarkModeEnabled()
                                          ? Colors.white
                                          : Colors.black))),
                    );
                  })),
            ),
          ),
        ],
      ),
    );
  }
}
