import 'package:cached_network_image/cached_network_image.dart';
import 'package:customer/utils/common_utils.dart';
import 'package:customer/utils/screen_dimension_utils.dart';
import 'package:customer/utils/ui_constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:html/dom.dart' as dom;

class ProfileImageBoxWidget extends StatefulWidget {
  final String withoutImageText;
  final String withImageText;
  final Function onTapCallback;
  final String placeHolderImage;
  final String imgUrl;
  final bool isHtmlText;
  ProfileImageBoxWidget(
      {Key key,
      this.withImageText,
      this.withoutImageText,
      this.onTapCallback,
      this.placeHolderImage,
      this.imgUrl,
      this.isHtmlText = false})
      : super(key: key){
  //  print("imageurl:${imgUrl}");

  }

  @override
  ProfileImageBoxWidgetState createState() => ProfileImageBoxWidgetState();
}

class ProfileImageBoxWidgetState extends State<ProfileImageBoxWidget> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        GestureDetector(
          onTap: () {
            widget.onTapCallback();
          },
          child: Container(
            padding:
                EdgeInsets.only(left: 16.0, top: 10, bottom: 10, right: 16.0),
            margin: EdgeInsets.only(top: 15.0),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.all(Radius.circular(6.0))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                new Center(
                  child: isNullOrEmpty(widget.imgUrl)
                      ? new Stack(
                          children: <Widget>[
                            new Center(
                              child: Image.asset(
                                widget.placeHolderImage,
                                width: responsiveSize(60),
                                height: responsiveSize(60),
                              ),
                            ),
                          ],
                        )
                      :
                  CachedNetworkImage(
                          imageUrl: widget.imgUrl  ,
                          placeholder: (context, url) => CircularProgressIndicator(),
                           errorWidget: (context, url, error) => Image.asset(widget.placeHolderImage),
                          imageBuilder: (context, imageProvider) => Container(
                            height: responsiveSize(60),
                            width: responsiveSize(100),
                            decoration: BoxDecoration(
                              color: const Color(0xff7c94b6),
                              image: DecorationImage(
                                  image: imageProvider, fit: BoxFit.contain),
                              borderRadius: new BorderRadius.all(
                                  const Radius.circular(4.0)),
                            ),
                          ),
                        ),
                ),
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: !widget.isHtmlText
                      ? Text(
                          widget.imgUrl == null
                              ? widget.withoutImageText
                              : widget.withImageText,
                          style: TextStyle(
                              fontFamily: "roboto",
                              fontWeight: FontWeight.w300,
                              fontSize: responsiveTextSize(16),
                              color: ColorResource.brownish_grey),
                          textAlign: TextAlign.start,
                        )
                      : Align(alignment: Alignment.centerLeft,
                        child: Html(
                            shrinkToFit: true,
                            blockSpacing: 0.0,
                            padding: EdgeInsets.all(0.0),
                            defaultTextStyle: TextStyle(
                                color: ColorResource.brownish_grey,
                                fontFamily: 'roboto',
                                fontWeight: FontWeight.w400,
                                fontSize: responsiveTextSize(16)),
                            data: widget.imgUrl == null
                                ? widget.withoutImageText
                                : widget.withImageText,
                            customTextStyle:
                                (dom.Node node, TextStyle baseStyle) {
                              if (node is dom.Element) {
                                switch (node.localName) {
                                  case "big":
                                    return baseStyle.merge(
                                        TextStyle(height: 0, fontSize: responsiveTextSize(21)));
                                }
                              }
                              return baseStyle;
                            }),
                      ),
                ))
              ],
            ),
          ),
        ),
      ],
    );
  }
}
