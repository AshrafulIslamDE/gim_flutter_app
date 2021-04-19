import 'package:flutter/cupertino.dart';

class PlacePrediction {
  final String description;
  final String id;
  final String address;
  final String placeId;
  final IconData iconData;

  final double lat;
  final double lon;

  final isMyLoc;

  PlacePrediction(this.description, this.iconData,{this.id, this.placeId,this.address, this.lat, this.lon, this.isMyLoc = false});

  @override
  String toString() {
    return description;
  }
}
