import 'dart:io';

import 'package:customer/core/localization/AppTranslation.dart';
import 'package:customer/ui/widget/retake_crop_preview.dart';
import 'package:customer/utils/image_utils.dart';
import 'package:customer/utils/screen_dimension_utils.dart';
import 'package:customer/utils/ui_constant.dart';
import 'package:customer/utils/ui_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

import 'navigation_utils.dart';

class ImagePickerWidget extends StatefulWidget {
  final double imgWidth;
  final double imgHeight;
  final Function(File) imageFile;
  final double containerHeight;

  ImagePickerWidget(
      {this.imgWidth, this.imgHeight, this.containerHeight, this.imageFile});

  @override
  ImagePickerWidgetState createState() => ImagePickerWidgetState();
}

class ImagePickerWidgetState extends State<ImagePickerWidget> {
  File imageFile;
  String targetPath;

  @override
  void initState() {
    super.initState();
    _initLocalPath();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          height: widget.containerHeight,
          padding: EdgeInsets.all(responsiveSize(20.0)),
          //margin: EdgeInsets.only(left: responsiveSize(10.0), right: responsiveSize(10.0)),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius:
                  BorderRadius.all(Radius.circular(responsiveSize(4.0)))),
          child: InkWell(
            onTap: () => _settingModalBottomSheet(),
            child: Row(
              children: <Widget>[
                new Center(
                  child: imageFile == null
                      ? new Stack(
                          children: <Widget>[
                            Container(
                              child: new Image.asset(
                                'images/ic_camera_placeholder.png',
                                height: responsiveSize(56.0),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ],
                        )
                      : new Container(
                          height: widget.imgHeight == null
                              ? responsiveSize(60.0)
                              : widget.imgHeight,
                          width: widget.imgWidth == null
                              ? responsiveSize(100.0)
                              : widget.imgWidth,
                          decoration: new BoxDecoration(
                            color: const Color(0xff7c94b6),
                            image: new DecorationImage(
                              image: FileImage(imageFile),
                              fit: BoxFit.cover,
                            ),
                            borderRadius: new BorderRadius.all(
                                Radius.circular(responsiveSize(4.0))),
                          ),
                        ),
                ),
                Expanded(
                    child: Padding(
                  padding: EdgeInsets.only(left: responsiveSize(10.0)),
                  child: Text(
                    imageFile == null
                        ? AppTranslations.of(context).text("txt_goods_ns_img")
                        : AppTranslations.of(context).text("txt_goods_os_img"),
                    style: TextStyle(
                        fontFamily: "roboto",
                        fontWeight: FontWeight.w300,
                        fontSize: responsiveTextSize(16.0),
                        color: ColorResource.warmGrey),
                    textAlign: TextAlign.center,
                  ),
                ))
              ],
            ),
          ),
        ),
        Positioned(
          right: responsiveSize(2.0),
          top: responsiveSize(-8.0),
          child: imageFile == null
              ? SizedBox.shrink()
              : IconButton(
                  icon: Image.asset("images/ic_cross_fill.png"),
                  onPressed: () {
                    setState(() {
                      imageFile = null;
                      widget.imageFile(null);
                    });
                  }),
        )
      ],
    );
  }

  _settingModalBottomSheet() {
    hideSoftKeyboard(context);
    settingModalBottomSheet(context, getImage: (src) {
      _getImage(src);
    });
  }

  Future _getImage(ImageSource source) async {
    var image;
    switch (source) {
      case ImageSource.gallery:
        image = await ImagePicker.pickImage(source: ImageSource.gallery);
        if (image != null)
          navigateNextScreen(context, RetakeCropPreview(image, _onImgResponse));
        return;
      case ImageSource.camera:
        image = await ImagePicker.pickImage(source: ImageSource.camera);
        if(image == null) return;
        break;
    }
    var result = await FlutterImageCompress.compressAndGetFile(
        image?.path, targetPath ?? _initLocalPath(),
        quality: 88);

    File croppedFile = await ImageCropper.cropImage(
      sourcePath: result?.path,
      maxWidth: 512,
      maxHeight: 512,
    );

    setState(() {
      imageFile = croppedFile;
      widget.imageFile(imageFile);
    });
  }

  _onImgResponse(File file) {
    if (file == null) {
      _getImage(ImageSource.gallery);
      return;
    }
    imageFile = file;
    widget.imageFile(imageFile);
  }

  _initLocalPath() async {
    Directory tempDir = await getApplicationDocumentsDirectory();
    return targetPath =
        '${tempDir.path}/${DateTime.now().millisecondsSinceEpoch}.jpeg';
  }
}
/*File croppedFile = await ImageCropper.cropImage(
      sourcePath: image.path,
      maxWidth: 512,
      maxHeight: 512,
    );
    if (imgPath == null) imgPath = initLocalPath();
    var result = await FlutterImageCompress.compressAndGetFile(
        croppedFile.path, imgPath,
        quality: 88);
    setState(() {
      imageFile = result;
      widget.imageFile(imageFile);
    });*/
