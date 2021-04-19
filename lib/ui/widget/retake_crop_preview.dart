import 'dart:io';

import 'package:customer/core/localization/AppTranslation.dart';
import 'package:customer/utils/screen_dimension_utils.dart';
import 'package:customer/utils/ui_constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:path_provider/path_provider.dart';

class RetakeCropPreview extends StatefulWidget {
  final File orgImageFile;
  final Function imgFileResult;

  RetakeCropPreview(this.orgImageFile, this.imgFileResult);

  @override
  RetakeCropPreviewState createState() => RetakeCropPreviewState();
}

class RetakeCropPreviewState extends State<RetakeCropPreview> {
  String targetPath;
  File editedImgFile;
  bool isReCrop = false;

  @override
  void initState() {
    super.initState();
    _initLocalPath();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Padding(
              padding:
                  const EdgeInsets.only(top: kToolbarHeight / 2, right: 10),
              child: Align(
                  alignment: Alignment.centerRight,
                  child: Icon(
                    Icons.cancel,
                    color: ColorResource.colorMarineBlue,
                    size: 40,
                  )),
            ),
          ),
          Container(
            child: Expanded(
              child: Center(
                  child: Image.file(editedImgFile ?? widget.orgImageFile)),
            ),
          ),
          Container(
            color: ColorResource.colorMarineBlue,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                InkWell(
                  onTap: () => _setResponse(null),
                  child: Padding(
                    padding: const EdgeInsets.only(left:24.0, top: 20.0, bottom: 26.0),
                    child: Text(
                      localize('retake'),
                      style: TextStyle(
                        color: ColorResource.colorWhite,
                        fontFamily: 'roboto',
                        fontWeight: FontWeight.w500,
                        fontSize: responsiveDefaultTextSize()
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () => _crop(),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20.0, bottom: 26.0),
                    child: Text(
                      isReCrop ? localize('recrop').toUpperCase(): localize('crop').toUpperCase(),
                      style: TextStyle(
                        color: ColorResource.colorWhite,
                        fontFamily: 'roboto',
                        fontWeight: FontWeight.w500,
                        fontSize: responsiveDefaultTextSize()
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () =>
                      _setResponse(editedImgFile ?? widget.orgImageFile),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20.0, bottom: 26.0, right: 24.0),
                    child: Text(
                      localize('txt_ok'),
                      style: TextStyle(
                        color: ColorResource.colorWhite,
                        fontFamily: 'roboto',
                        fontWeight: FontWeight.w500,
                          fontSize: responsiveDefaultTextSize()
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  _setResponse(File file) {
    Navigator.pop(context);
    widget.imgFileResult(file);
  }

  _crop() async {
    isReCrop = true;

    var result = await FlutterImageCompress.compressAndGetFile(
        widget.orgImageFile?.path, targetPath ?? _initLocalPath(),
        quality: 88);

    File croppedFile = await ImageCropper.cropImage(
      sourcePath: result?.path,
      maxWidth: 512,
      maxHeight: 512,
    );

    setState(() {
      editedImgFile = croppedFile;
    });
  }

  _initLocalPath() async {
    Directory tempDir = await getApplicationDocumentsDirectory();
    return targetPath =
        '${tempDir?.path}/${DateTime.now().millisecondsSinceEpoch}.jpeg';
  }
}
