import 'dart:async';
import 'dart:io';

/*import 'package:clustering_google_maps/clustering_google_maps.dart';*/
import 'package:customer/bloc/base_bloc.dart';
import 'package:customer/model/tracker/location_response.dart';
import 'package:customer/networking/api_response.dart';
import 'package:customer/ui/tracker/repo/tracker_repo.dart';
import 'package:customer/utils/custom_marker_bitmap.dart';
import 'package:fluster/fluster.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../map_helper.dart';
import '../map_marker.dart';

class TrackerBloc extends BaseBloc {
  double screenWidth;
  final Set<Marker> markers = Set();
  double initialZoom = 10;
  double _currentZoom = 10;
  final int _minClusterZoom = 0;
  final int _maxClusterZoom = 13;
  LocationResponse _locations;
  bool isMapLoading = true;
  bool areMarkersLoading = true;
  Fluster<MapMarker> _clusterManager;
  LatLng target = LatLng(23.8103, 90.4125);
  final Completer<GoogleMapController> _mapController = Completer();
  BitmapDescriptor clusterMarker;
  BitmapDescriptor idleTruckMarker;
  BitmapDescriptor runningTruckMarker;
  CustomMarkerBitmap markerBitmap;
  bool isShowingSel = false;
  double mapPad = 120.0;
  bool searchFieldFocus = false;
  bool _isFilterVisible = false;
  TruckLocations _selTruck;
  bool noTrackTruck = false;
  MinMaxZoomPreference _minMaxZoom = MinMaxZoomPreference(0.0, 13.99);
  final Function(TruckLocations) onTapInfo;

  /*List<LatLngAndGeohash> _LatLngAndGeohashList=[];

  List<LatLngAndGeohash> get LatLngAndGeohashList => _LatLngAndGeohashList;

  set LatLngAndGeohashList(List<LatLngAndGeohash> value) {
    _LatLngAndGeohashList = value;
    // notifyListeners();
  }*/
  get locations => _locations?.locations;

  get filterState => _isFilterVisible;

  get minMaxZoom => _minMaxZoom;

  TrackerBloc({this.onTapInfo}) {
    _loadMarkerImg();
    markerBitmap = CustomMarkerBitmap();
  }

  void onCreated(GoogleMapController controller) {
    _mapController.complete(controller);
    isMapLoading = false;
    notifyListeners();
  }

  getLocations() async {
    isLoading = true;
    ApiResponse apiResponse = await TrackerRepo.getLocations();
    checkResponse(apiResponse, successCallback: () async {
      _locations = LocationResponse.fromJson(apiResponse.data);
      if(locations.length <= 0){
        noTrackTruck = true;
        areMarkersLoading = false;
        notifyListeners();
        return;
      }
      /*fillGeoList();*/
      _drawMarkers();
    });
  }

  /*fillGeoList(){
    LatLngAndGeohashList=[];
    for(var item in _locations.locations)
      LatLngAndGeohashList.add(LatLngAndGeohash(LatLng(item.latitude,item.longitude)));
  }*/
  void _drawMarkers() async {
    final List<MapMarker> markers = [];
    for (TruckLocations tripLoc in locations) {
      markers.add(
        MapMarker(
          tripLoc: tripLoc,
          onTapInfo: onTapInfo,
          callback: reDrawMarker,
          id: tripLoc.toString(),
          position: LatLng(tripLoc.latitude, tripLoc.longitude),
          bitmap: tripLoc.speed == 0 ? idleTruckMarker : runningTruckMarker,
        ),
      );
    }
    if (_selTruck != null) markers.addAll(await _getSubMarkers());
    _clusterManager = await MapHelper.initClusterManager(
      markers,
      _minClusterZoom,
      _maxClusterZoom,
      idleTruckMarker,
    );
    updateMarkers();
  }

  void updateMarkers([double updatedZoom]) {
    if (_clusterManager == null || updatedZoom == _currentZoom) return;
    if (updatedZoom != null) {
      _currentZoom = updatedZoom;
    }
    areMarkersLoading = true;
    markers
      ..clear()
      ..addAll(MapHelper.getClusterMarkers(_clusterManager, _currentZoom));
    areMarkersLoading = false;
    _updatePosition();
  }

  void _updatePosition() async {
    GoogleMapController controller = await _mapController.future;
    if (_selTruck != null) {
      controller.animateCamera(
          CameraUpdate.newLatLngBounds(bound(_selTruck), mapPad));
      controller.showMarkerInfoWindow(MarkerId(_selTruck.toString()));
    } else {
      controller.animateCamera(CameraUpdate.newLatLngBounds(getBound(locations),mapPad));
    }
    notifyListeners();
  }

  _getSubMarkers() async {
    return [
      MapMarker(
        tripLoc: _selTruck,
        id: _selTruck.pickUplat.toString(),
        address: _selTruck.pickUpAddress,
        position: LatLng(_selTruck.pickUplat, _selTruck.pickUplon),
        bitmap: await markerBitmap.createCustomMarkerBitmap(
            _selTruck.pickUpAddress, true,
            size: screenWidth),
      ),
      MapMarker(
        tripLoc: _selTruck,
        address: _selTruck.dropOffAddress,
        id: _selTruck.dropOfflat.toString(),
        position: LatLng(_selTruck.dropOfflat, _selTruck.dropOfflon),
        bitmap: await markerBitmap.createCustomMarkerBitmap(
            _selTruck.dropOffAddress, false,
            size: screenWidth),
      ),
    ];
  }

  reDrawMarker(selMarker) {
    _selTruck = selMarker;
    _drawMarkers();
  }

  onRefresh() {
    _removeInfoWindow();
    isShowingSel = false;
    getLocations();
  }

  zoomOut() {
    _mapController.future.then((controller) {
      controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: target,
        zoom: initialZoom,
      )));
    });
    _removeInfoWindow();
  }

  filterVisibility() {
    _isFilterVisible = !_isFilterVisible;
    notifyListeners();
  }

  _removeInfoWindow() async {
    if (_selTruck != null) {
      var markerId = MarkerId(_selTruck.toString());
      GoogleMapController controller = await _mapController.future;
      controller.isMarkerInfoWindowShown(markerId).then((val) {
        controller.hideMarkerInfoWindow(markerId);
        _selTruck = null;
      });
    }
  }

  LatLngBounds bound(truckLoc) {
    var latitudes = [
      truckLoc.latitude,
      truckLoc.pickUplat,
      truckLoc.dropOfflat
    ];
    var longitudes = [
      truckLoc.longitude,
      truckLoc.pickUplon,
      truckLoc.dropOfflon
    ];
    latitudes.sort((a, b) {
      if (a == b) {
        return 0;
      } else if (a > b) {
        return 1;
      } else {
        return -1;
      }
    });
    longitudes.sort((a, b) {
      if (a == b) {
        return 0;
      } else if (a > b) {
        return 1;
      } else {
        return -1;
      }
    });
    return LatLngBounds(
        southwest: LatLng(latitudes[0], longitudes[0]),
        northeast: LatLng(latitudes[2], longitudes[2]));
  }

  LatLngBounds getBound(List<TruckLocations> locations) {
    var lat = [];
    var lng = [];
    for(TruckLocations tl in locations){
      lat.add(tl.latitude);
      lng.add(tl.longitude);
    }
    lat.sort((a, b) {
      if (a == b) {
        return 0;
      } else if (a > b) {
        return 1;
      } else {
        return -1;
      }
    });
    lng.sort((a, b) {
      if (a == b) {
        return 0;
      } else if (a > b) {
        return 1;
      } else {
        return -1;
      }
    });
    return LatLngBounds(
        southwest: LatLng(lat[0], lng[0]),
        northeast: LatLng(lat[lat.length-1], lng[lng.length-1]));
  }

  trackTruckCount(String label) {
    return _locations == null
        ? ""
        : label +
            "${_locations.totalTrackableTruck.toString()}" +
            "/" +
            "${_locations.totalLiveTruck.toString()}";
  }

  _loadMarkerImg() async {
    idleTruckMarker =
        await MapHelper.getMarkerImageFromUrl(Platform.isIOS ? 'images/ic_pin_truck_idle.png' : 'images/2.0x/ic_pin_truck_idle.png');
    runningTruckMarker =
        await MapHelper.getMarkerImageFromUrl(Platform.isIOS ? 'images/ic_pin_truck_moving.png' : 'images/2.0x/ic_pin_truck_moving.png');
  }
}
