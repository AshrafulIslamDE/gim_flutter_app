import 'package:customer/flavor/flavor_config.dart';
import 'package:customer/model/place/PlacePrediction.dart';
import 'package:customer/utils/ui_constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class GoogleMapsServices {
  Future<List<Map>> getRouteCoordinates(LatLng l1, LatLng l2) async {
    List<Map> map = List<Map>();
    String url =
        "https://maps.googleapis.com/maps/api/directions/json?origin=${l1.latitude},${l1.longitude}&destination=${l2.latitude},${l2.longitude}&key=${FlavorConfig.instance.values.GOOGLE_API_KEY}";
    http.Response response = await http.get(url);
    Map values = jsonDecode(response.body);
    Map bounds = values["routes"][0]["bounds"];
    map.add(bounds["northeast"]);
    map.add(bounds["southwest"]);
    map.add({"points": values["routes"][0]["overview_polyline"]["points"]});
    return map;
  }

  Future<List> getListOfPlaces(String input) async {
    String url =
        "https://maps.googleapis.com/maps/api/place/autocomplete/json?components=country:bd&region=bd&types=address&input=$input&key=${FlavorConfig.instance.values.GOOGLE_API_KEY}";
    http.Response response = await http.get(url);
    List values = jsonDecode(response.body)["predictions"];
    List pds = List();
    pds = values
        .map((prediction) => PlacePrediction(
            prediction['description'], CupertinoIcons.location_solid,
            id: prediction['id'], placeId: prediction['place_id']))
        .toList();
    pds.insert(
        0,
        PlacePrediction(
            TextConst.CURRENT_LOCATION, Icons.my_location));
    return pds;
  }

  Future<Map> getDetailsByPlaceId(String placeId) async {
    String url =
        "https://maps.googleapis.com/maps/api/place/details/json?placeid=$placeId&key=${FlavorConfig.instance.values.GOOGLE_API_KEY}";
    http.Response response = await http.get(url);
    Map values = jsonDecode(response.body)['result']['geometry']['location'];
    return values;
  }
}
