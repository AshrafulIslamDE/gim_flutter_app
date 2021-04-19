import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:customer/utils/ui_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FullScreenImage extends StatefulWidget {
  final bool isLocal;
  String imageUrl;
  String placeholdeImage;

  FullScreenImage(
      {this.imageUrl,
      this.placeholdeImage = "images/ic_image_preview_placeholder.webp",
      this.isLocal = false});

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<FullScreenImage> {
  @override
  initState() {
    //SystemChrome.setEnabledSystemUIOverlays([]);
    super.initState();
  }

  @override
  void dispose() {
    //SystemChrome.restoreSystemUIOverlays();
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Padding(
                padding:
                    const EdgeInsets.only(top: kToolbarHeight / 2.5, right: 15),
                child: Align(
                    alignment: Alignment.centerRight,
                    child: Icon(
                      Icons.cancel,
                      color: ColorResource.colorMarineBlue,
                      size: 40,
                    )),
              ),
            ),
            Expanded(
              child: Center(
                child: widget.imageUrl == null
                    ? Image.asset(widget.placeholdeImage)
                    : widget.isLocal
                        ? Container(
                            decoration: BoxDecoration(
                                image: DecorationImage(
                              image: new FileImage(File(widget.imageUrl)),
                            )),
                          )
                        : CachedNetworkImage(
                            imageUrl: widget.imageUrl,
                            placeholder: (context, url) =>
                                CircularProgressIndicator(),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                          ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
