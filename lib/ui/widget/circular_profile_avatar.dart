import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:customer/core/localization/AppTranslation.dart';
import 'package:customer/ui/widget/navigation_utils.dart';
import 'package:customer/ui/widget/retake_crop_preview.dart';
import 'package:customer/utils/image_utils.dart';
import 'package:customer/utils/screen_dimension_utils.dart';
import 'package:customer/utils/ui_constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class CircularProfileAvatar extends StatefulWidget {
  CircularProfileAvatar(this.imageUrl,
      {Key key,
      this.initialsText = const Text(''),
      this.cacheImage = true,
      this.radius = 40.0,
      this.borderWidth = 0.0,
      this.borderColor = Colors.white,
      this.backgroundColor = Colors.white,
      this.elevation = 0.0,
      this.showInitialTextAbovePicture = false,
      this.onTap,
      this.foregroundColor = Colors.transparent,
      this.placeHolder,
      this.errorWidget,
      this.imageBuilder,
      this.useOldImageOnUrlChange,
      this.imageFile})
      : super(key: key) {
    radius = responsiveSize(radius);
  }

  double radius;

  final double elevation;

  final double borderWidth;

  final Color borderColor;

  final Color backgroundColor;

  final Color foregroundColor;

  final String imageUrl;

  final Text initialsText;

  final bool showInitialTextAbovePicture;

  final bool cacheImage;

  final GestureTapCallback onTap;

  final PlaceholderWidgetBuilder placeHolder;

  final LoadingErrorWidgetBuilder errorWidget;

  final ImageWidgetBuilder imageBuilder;

  final bool useOldImageOnUrlChange;

  final Function(File) imageFile;

  @override
  _CircularProfileAvatarState createState() => _CircularProfileAvatarState();
}

class _CircularProfileAvatarState extends State<CircularProfileAvatar> {
  Widget _initialsText;
  File imageFile;
  String targetPath;

  @override
  void initState() {
    super.initState();
    _initLocalPath();
  }

  @override
  Widget build(BuildContext context) {
    _initialsText = Center(child: widget.initialsText);
    return GestureDetector(
      onTap: () => _settingModalBottomSheet(),
      child: Material(
        type: MaterialType.circle,
        elevation: widget.elevation,
        color: widget.borderColor,
        child: Container(
            height: widget.radius * 2,
            width: widget.radius * 2,
            padding: EdgeInsets.all(widget.borderWidth),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(widget.radius),
                color: widget.borderColor),
            child: Center(
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(widget.radius)),
                child: Stack(
                  fit: StackFit.expand,
                  children: widget.imageUrl == null && imageFile == null
                      ? <Widget>[
                          Container(
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(widget.radius),
                              image: DecorationImage(
                                image: AssetImage("images/user.png"),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          picTransparentOverlay(
                              translate(context, 'txt_upload')),
                        ]
                      : widget.showInitialTextAbovePicture
                          ? <Widget>[
                              profileImage(),
                              Container(
                                decoration: BoxDecoration(
                                  color: widget.foregroundColor,
                                  borderRadius:
                                      BorderRadius.circular(widget.radius),
                                ),
                              ),
                              //_initialsText,
                            ]
                          : <Widget>[
                              //_initialsText,
                              profileImage(),
                              picTransparentOverlay(
                                  translate(context, 'txt_change')),
                            ],
                ),
              ),
            )),
      ),
    );
  }

  Widget picTransparentOverlay(String text) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: ClipRRect(
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(40.0),
            bottomRight: Radius.circular(40.0)),
        clipBehavior: Clip.hardEdge,
        child: Container(
          height: 36.0,
          decoration: BoxDecoration(
            color: Color.fromRGBO(0, 0, 0, 0.14),
          ),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  CupertinoIcons.photo_camera,
                  color: ColorResource.colorWhite,
                ),
                Text(
                  text,
                  style: TextStyle(
                      fontSize: responsiveTextSize(10.0),
                      fontWeight: FontWeight.w500,
                      color: ColorResource.colorWhite),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget profileImage() {
    return widget.cacheImage
        ? ClipRRect(
            borderRadius: BorderRadius.circular(widget.radius),
            child: imageFile?.path == null
                ? CachedNetworkImage(
                    fit: BoxFit.cover,
                    imageUrl: imageFile?.path ?? widget.imageUrl,
                    errorWidget: widget.errorWidget,
                    placeholder: widget.placeHolder,
                    imageBuilder: widget.imageBuilder,
                    useOldImageOnUrlChange:
                        widget.useOldImageOnUrlChange == null
                            ? false
                            : widget.useOldImageOnUrlChange,
                  )
                : CircleAvatar(
                    backgroundImage: FileImage(imageFile),
                  ),
          )
        : CircleAvatar(
            backgroundImage: NetworkImage(widget.imageUrl),
          );
  }

  _settingModalBottomSheet() {
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
        image.path, targetPath ?? _initLocalPath(),
        quality: 88);

    File croppedFile = await ImageCropper.cropImage(
      sourcePath: result.path,
      maxWidth: 512,
      maxHeight: 512,
    );

    setState(() {
      imageFile = croppedFile;
      widget.imageFile(imageFile);
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
    widget.imageFile(imageFile);
  }
}
