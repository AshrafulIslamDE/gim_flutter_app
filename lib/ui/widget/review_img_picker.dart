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

class ReviewImagePicker extends StatefulWidget {
  final Function(File) callback;
  final double containerHeight;

  ReviewImagePicker({this.containerHeight, this.callback});

  @override
  _ReviewImagePickerState createState() => _ReviewImagePickerState();
}

class _ReviewImagePickerState extends State<ReviewImagePicker> {
  File imageFile;
  String targetPath;

  @override
  void initState() {
    super.initState();
    _initLocalPath();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _settingModalBottomSheet(),
      child: Stack(
        children: <Widget>[
          Container(
            height: widget.containerHeight,
            margin: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.all(Radius.circular(4.0))),
            child: Center(
              child: imageFile == null
                  ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset("images/ic_camera_placeholder.png"),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Text(
                      localize('hint_add_photo'),
                      style: TextStyle(
                        fontSize: responsiveTextSize(16.0),
                        fontFamily: "roboto",
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  )
                ],
              )
                  : new Container(
                decoration: new BoxDecoration(
                  color: const Color(0xff7c94b6),
                  image: new DecorationImage(
                    image: FileImage(imageFile),
                    fit: BoxFit.cover,
                  ),
                  borderRadius:
                  new BorderRadius.all(const Radius.circular(4.0)),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: imageFile == null
                ? SizedBox.shrink()
                : IconButton(
                icon: Icon(CupertinoIcons.clear_circled_solid, color: ColorResource.colorWhite, size: responsiveSize(24.0),),
                onPressed: () {
                  setState(() {
                    imageFile = null;
                    widget.callback(null);
                  });
                }),
          )
        ],
      ),
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
        if (image == null) return;
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
      widget.callback(imageFile);
    });
  }

  _initLocalPath() async {
    Directory tempDir = await getApplicationDocumentsDirectory();
    return targetPath =
        '${tempDir.path}/${DateTime.now().millisecondsSinceEpoch}.jpeg';
  }

  _onImgResponse(File file) {
    if (file == null) {
      _getImage(ImageSource.gallery);
      return;
    }
    imageFile = file;
    widget.callback(imageFile);
  }
}
