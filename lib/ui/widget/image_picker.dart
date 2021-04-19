import 'dart:io';

import 'package:customer/core/localization/AppTranslation.dart';
import 'package:customer/ui/widget/navigation_utils.dart';
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

class ImagePickerWidget extends StatefulWidget {
  String withImageText1;
  String withImageText2;
  String withoutImageText1;
  String withoutImageText2;
  Function(File) onImageCallback;
  var placeHolderImage;
  var netWorkImage;

  ImagePickerWidget(
      {Key key,
      this.withImageText1,
      this.withImageText2,
      this.withoutImageText1,
      this.withoutImageText2,
      this.netWorkImage,
      this.onImageCallback,
      this.placeHolderImage = "images/ic_camera_placeholder.png"})
      : super(key: key);

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
        GestureDetector(
          onTap: () => _settingModalBottomSheet(),
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
                  child: imageFile == null
                      ? new Stack(
                          children: <Widget>[
                            new Center(
                              child: widget.netWorkImage == null
                                  ? Image.asset(
                                      widget.placeHolderImage,
                                      width: responsiveTextSize(60),
                                      height: responsiveTextSize(60),
                                    )
                                  : getNetworkImage(context,
                                      url: widget.netWorkImage,
                                      height: 60,
                                      width: 100),
                            ),
                          ],
                        )
                      : new Container(
                          height: responsiveTextSize(60),
                          width: responsiveTextSize(100),
                          decoration: new BoxDecoration(
                            color: const Color(0xff7c94b6),
                            image: new DecorationImage(
                              image: FileImage(imageFile),
                              fit: BoxFit.cover,
                            ),
                            borderRadius: new BorderRadius.all(
                                const Radius.circular(4.0)),
                          ),
                        ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          imageFile == null
                              ? widget.withoutImageText1
                              : widget.withImageText1,
                          style: TextStyle(
                              fontFamily: "roboto",
                              fontWeight: FontWeight.w700,
                              fontSize: responsiveTextSize(16.0),
                              color: ColorResource.greyish_brown),
                          textAlign: TextAlign.start,
                        ),
                        Text(
                          imageFile == null
                              ? widget.withoutImageText2
                              : widget.withImageText2,
                          style: TextStyle(
                              fontFamily: "roboto",
                              fontWeight: FontWeight.w300,
                              fontSize: responsiveTextSize(16.0),
                              color: ColorResource.greyish_brown),
                          textAlign: TextAlign.start,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          right: 2.0,
          top: 8.0,
          child: imageFile == null
              ? SizedBox.shrink()
              : IconButton(
                  icon: Image.asset("images/ic_cross_fill.png"),
                  onPressed: () {
                    setState(() {
                      imageFile = null;
                      widget.onImageCallback(null);
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
      widget.onImageCallback(imageFile);
    });
  }

  _onImgResponse(File file) {
    if (file == null) {
      _getImage(ImageSource.gallery);
      return;
    }
    imageFile = file;
    widget.onImageCallback(imageFile);
  }

  _initLocalPath() async {
    Directory tempDir = await getApplicationDocumentsDirectory();
    return targetPath =
        '${tempDir.path}/${DateTime.now().millisecondsSinceEpoch}.jpeg';
  }

/*File croppedFile = await ImageCropper.cropImage(
      sourcePath: image.path,
      maxWidth: 512,
      maxHeight: 512,
    );
    var tmpDir=await initLocalPath();
    final target = "$tmpDir/${DateTime.now().millisecondsSinceEpoch}.jpeg";
    var result = await FlutterImageCompress.compressAndGetFile(
        croppedFile.absolute.path,
        target,
        quality: 50);
    setState(() {
      imageFile = result;
      widget.onImageCallback(imageFile);
    });
  }
  initLocalPath() async{
    Directory tempDir = await getApplicationDocumentsDirectory();
    return tempDir.path;
  }*/
}
