
import 'package:cached_network_image/cached_network_image.dart';
import 'package:customer/ui/widget/full_screen_image.dart';
import 'package:customer/ui/widget/navigation_utils.dart';
import 'package:flutter/material.dart';

class CircleImage extends StatefulWidget{
  CachedNetworkImageProvider myImage;
  var placeholdeImage;
  double radius;
  var imageUrl;
  CircleImage({this.myImage, this.placeholdeImage,this.radius,this.imageUrl});

  @override
  _CircularImageState createState() => _CircularImageState();
}

class _CircularImageState extends State<CircleImage> {
  bool _checkLoading = true;

@override
  void initState() {
    super.initState();
    widget.myImage.resolve(ImageConfiguration()).addListener(
        ImageStreamListener((ImageInfo image, bool synchronousCall) {
          if (mounted)
            setState(() => _checkLoading = false);
        }));
  }

  @override
  Widget build(BuildContext context) {
  var shownWidget= _checkLoading == true ? CircleAvatar(
        backgroundImage: AssetImage(widget.placeholdeImage),radius: widget.radius,) :  CircleAvatar(backgroundImage: widget.myImage,radius: widget.radius,);
   return GestureDetector(
     onTap: ()=>navigateNextScreen(context, FullScreenImage(imageUrl:widget.imageUrl ,)),
     child:shownWidget ,
   );
  }
}