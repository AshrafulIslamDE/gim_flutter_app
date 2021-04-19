import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:customer/core/localization/AppTranslation.dart';
import 'package:customer/ui/widget/circular_image.dart';
import 'package:customer/ui/widget/full_screen_image.dart';
import 'package:customer/ui/widget/navigation_utils.dart';
import 'package:customer/utils/common_utils.dart';
import 'package:customer/utils/screen_dimension_utils.dart';
import 'package:customer/utils/ui_constant.dart';
import 'package:customer/utils/ui_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';

getNetworkImageProvider(
    {String url,
    placeHolderImage = 'images/ic_image_preview_placeholder.webp',
    width,
    height,
    isCircleImage = false}) {
  if (isNullOrEmpty(url)) url = "not_available";
  return _sizedContainer(CachedNetworkImage(imageUrl: url), width, height);
}

getCacheNetworkImageProvider(
    {String url,
      placeHolderImage = 'images/ic_image_preview_placeholder.webp',
      width,
      height,
      isCircleImage = false}) {
  if (isNullOrEmpty(url)) url = "not_available";
  return CachedNetworkImageProvider(url);
}

Widget getCircleImage(
    {String url,
    placeHolderImage = 'images/dummy_user_img.png',
    double radius}) {
  //print("enter circle image");
  if(isNullOrEmpty(url))
  return CircleAvatar(
    backgroundImage: AssetImage(placeHolderImage),radius: radius,);
  return CircleImage(
    imageUrl: url,
    radius: radius,
    placeholdeImage: placeHolderImage,
    myImage: getCacheNetworkImageProvider(url: url, placeHolderImage: placeHolderImage),
  );
}

Widget getNetworkImage(context,
    {String url, placeHolderImage, double size, fit = BoxFit.fill,double width,double height,showPlaceHolder=true}) {
    if (placeHolderImage == null)
      placeHolderImage = SvgPicture.asset(
          'svg_img/ic_picture_preview.svg',
          width: width ?? size,
          height: height ?? size, fit: fit
      );
    //Image.asset('images/ic_image_preview_placeholder.webp',width: size,height: size,);//Icon(Icons.image,color: ColorResource.colorMarineBlue,size: size);
    else if (placeHolderImage is String)
      placeHolderImage = Image.asset(placeHolderImage, width: width ?? size,
        height: height ?? size,
        fit: fit,);


  if (isNullOrEmpty(url)) {
    if(showPlaceHolder)
    return placeHolderImage;
    else
      return Container();
  }

  return GestureDetector(
    onTap: () {
      navigateNextScreen(
          context,
          FullScreenImage(
            imageUrl: url,
          ));
    },
    child: CachedNetworkImage(
      width: width??size,
      height: height??size,
      imageUrl: url,
      fit: fit,
      placeholder: (context, url) => showPlaceHolder  ? CircularProgressIndicator() : Container(),
      errorWidget: (context, url, error) => showPlaceHolder?placeHolderImage:Container(),
    ),
  );
}

Future<String> convertImageToBase64(fileData) async {
  if (fileData == null) return null;
  List<int> imageBytes = await fileData.readAsBytesSync();
  print(imageBytes);
  String base64Image = await base64Encode(imageBytes);
  print(base64Image);
  return "data:image/png;base64," + base64Image;
}

Future<BitmapDescriptor> fromAsset(String imgFileName) {
  ImageConfiguration configuration = ImageConfiguration();
  return BitmapDescriptor.fromAssetImage(configuration, imgFileName);
}
settingModalBottomSheet(context,{Function (ImageSource)getImage }) {
  final textStyle=TextStyle(fontSize: responsiveTextSize(18.0),color:isDarkModeEnabled() ? ColorResource.colorWhite : ColorResource.colorMarineBlue);
  if(Platform.isIOS) {
    showCupertinoModalPopup(
        context: context,
        builder: (BuildContext bc) {
          return CupertinoActionSheet(
            actions: <Widget>[
              CupertinoActionSheetAction(
                child: Text(localize("txt_gallery"), style: textStyle,),
                onPressed: () {
                  Navigator.pop(bc);
                  getImage(ImageSource.gallery);
                },
              ),
              CupertinoActionSheetAction(
                child: Text(localize("txt_camera"), style: textStyle),
                onPressed: () {
                  Navigator.pop(bc);
                  getImage(ImageSource.camera);
                },
              )
            ],
            cancelButton: CupertinoActionSheetAction(
              child: Text(localize("txt_cancel"), style: textStyle),
              isDefaultAction: true,
              onPressed: () {
                Navigator.pop(bc, 'Cancel');
              },
            ),
          );
        });
    return;
  }
  showModalBottomSheet(
      context: context,
      builder: (BuildContext bc){
        return Container(
          color: Colors.white,
          child:  Wrap(
            children: <Widget>[
               ListTile(
                  leading:  Icon(Icons.content_copy,size: responsiveSize(24),color: textStyle.color),
                  title:  Text(localize("txt_gallery"),style: textStyle,),
                  onTap: ()  {
                  Navigator.pop(bc);
                   getImage(ImageSource.gallery);
                  }
              ),
               ListTile(
                leading:  Icon(Icons.photo_camera,size:responsiveSize(24),color: textStyle.color,),
                title:  Text(localize("txt_camera"),style: textStyle,),
                onTap: ()  {
                  Navigator.pop(bc);
                  getImage(ImageSource.camera);
                },
              ),
              ListTile(
                leading:  Icon(Icons.clear,size: responsiveSize(24),),
                title:  Text(localize("txt_cancel"),style: TextStyle(fontSize: responsiveTextSize(18)),),
                onTap: () => Navigator.pop(bc),
              ),
            ],
          ),
        );
      }
  );
}

Widget _sizedContainer(Widget child,width,height) {
  return SizedBox(width: width,height: height,child: new Center(child: Center(child: child)));
}
