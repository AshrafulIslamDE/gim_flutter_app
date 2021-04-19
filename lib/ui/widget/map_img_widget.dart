import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class MapImage extends StatelessWidget {
  final String imageUrl;

  MapImage(
      {this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Stack(fit: StackFit.loose, children: [
        AspectRatio(
          aspectRatio: 16 / 7,
          child: CachedNetworkImage(
              imageUrl: imageUrl ?? 'images/map_place_holder.png',
              fit: BoxFit.fill,
              placeholder: (context, url) =>
                  Image.asset('images/map_place_holder.png', fit: BoxFit.fill),
              errorWidget: (context, url, error) =>
                  Image.asset('images/map_place_holder.png', fit: BoxFit.fill)),
        )
      ]),
    );
  }
}
