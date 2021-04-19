import 'dart:convert';

import 'package:customer/model/google/address_component.dart';
import 'package:customer/model/place/PlacePrediction.dart';
import 'package:customer/networking/api_response.dart';
import 'package:customer/utils/common_utils.dart';
import 'package:customer/utils/ui_constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GoogleRepository {
  static var helper = ApiBaseHelper();

  static Future<List> getPlaceSearchResult(pattern) async{
    List<Future> futures = [];
    futures.add(_dbAutoCompleteApi(pattern));
    futures.add(_gAutoCompleteApi(pattern));
    var response = await Future.wait(futures);
    return List.from(response[0])..addAll(response[1]);
  }

  static Future<List> _dbAutoCompleteApi(pattern) async {
    List pds = List();
    pds.add(PlacePrediction(TextConst.CURRENT_LOCATION, Icons.my_location, isMyLoc: true));
    if(isNullOrEmpty(pattern)) return pds;
    ApiResponse response = await helper.get(
        "/v1/enterprise/depotfactory/locations",
        queryParameters: {'searchQuery': '$pattern'});
    if (response.status == Status.COMPLETED) {
      List values = response.data;
      pds.addAll(values
          .map((prediction) => PlacePrediction(
              prediction['name'], CupertinoIcons.location_solid,
              address: prediction['address'], lat: prediction['lat'], lon: prediction['lon']))
          .toList());
    }
    return pds;
  }

  static Future<List> _gAutoCompleteApi(pattern) async {
    List pds = List();
    ApiResponse response =
        await helper.get("/v1/common/gplaceautocomplete", queryParameters: {
      'components': 'country:bd',
      'region': 'bd',
      'types': 'address',
      'input': '$pattern'
    });
    if (response.status == Status.COMPLETED) {
      List values = response.data["predictions"];
      pds.addAll(values
          .map((prediction) => PlacePrediction(
                prediction['description'],
                CupertinoIcons.location_solid,
                id: prediction['id'],
                placeId: prediction['place_id'],
              ))
          .toList());
    }
    return pds;
  }

  static Future<List<Map>> gDirectionApi(origin, destination) async {
    List<Map> map = List<Map>();
    ApiResponse response =
        await helper.get("/v1/common/gdirection", queryParameters: {
      'origin': '${origin.latitude},${origin.longitude}',
      'destination': '${destination.latitude},${destination.longitude}'
    });
    if (response.status == Status.COMPLETED) {
      Map bounds = response.data["routes"][0]["bounds"];
      map.add(bounds["northeast"]);
      map.add(bounds["southwest"]);
      map.add({
        "points": response.data["routes"][0]["overview_polyline"]["points"]
      });
    }
    return map;
  }

  static Future<Map> gPlaceDetailApi(placeId) async {
    Map map = Map();
    ApiResponse response = await helper.get("/v1/common/gplacedetails",
        queryParameters: {'placeid': '$placeId'});
    if (response.status == Status.COMPLETED) {
      map = response.data['result']['geometry']['location'];
    }
    return map;
  }

  static Future<AddressComponent> gGeocode(coordinate) async {
    AddressComponent address;
    ApiResponse response = await helper.get("/v1/common/geocode",
        queryParameters: {
          'latlng': '${coordinate.latitude},${coordinate.longitude}'
        });
    if (response.status == Status.COMPLETED && response.data != null) {
      address = AddressComponent.fromJson(response.data);
    }
    return address;
  }
}
