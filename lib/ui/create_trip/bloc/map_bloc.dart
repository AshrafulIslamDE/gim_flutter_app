import 'dart:async';
import 'dart:io';

import 'package:customer/bloc/base_bloc.dart';
import 'package:customer/data/repository/google_repository.dart';
import 'package:customer/data/repository/user_repository.dart';
import 'package:customer/model/google/address_component.dart';
import 'package:customer/model/profile/invoice_status.dart';
import 'package:customer/networking/api_response.dart';
import 'package:customer/utils/common_utils.dart';
import 'package:customer/utils/image_utils.dart';
import 'package:customer/utils/permission_handler.dart';
import 'package:customer/utils/prefs.dart';
import 'package:customer/utils/ui_constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:geocoder/geocoder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import '../model/create_trip_request.dart';

class MapBloc extends BaseBloc {
  static const String pickUp = 'source';
  static const String dropOff = 'destination';
  static LatLng _defaultPosition = LatLng(23.8103, 90.4125);
  int _markerIdCounter = 0;
  Map<MarkerId, Marker> _markers = {};
  Map<String, LatLng> selCoordinates = {};
  final Set<Polyline> _polyLines = {};
  TextEditingController _srcAddressController = TextEditingController();
  TextEditingController _dstAddressController = TextEditingController();
  Completer<GoogleMapController> _mapController = Completer();
  GoogleMapController _controller;
  BitmapDescriptor pickUpPin;
  BitmapDescriptor dropOffPin;
  var _mapIdleSubscription;
  LatLngBounds latLngBounds;
  String buttonText;
  String pickUpDistrictCode = "";
  String dropOffDistrictCode = "";
  String polygon = "";
  bool isInvalidCall = false;
  bool _isFocusNodeSrc = true;
  Function _callback;
  bool isInvAct;
  bool myLocVis = true;
  bool isFromDropDown = false;
  final FocusNode tecSrcFocus = FocusNode();
  final FocusNode tecDstFocus = FocusNode();
  final PermissionsHandler _permissionsHandler = PermissionsHandler();

  LatLng get initialPosition => _defaultPosition;

  Set<Marker> get mapMarkers => Set<Marker>.of(_markers.values);

  Set<Polyline> get polyLines => _polyLines;

  bool get isFocusNodeSrc => _isFocusNodeSrc;

  get srcAddressController => _srcAddressController;

  get dstAddressController => _dstAddressController;

  get minMaxZoom =>
      AppConstants.iSiOS13 ? MinMaxZoomPreference(0.0, 13.99) : null;

  set setInvalidCall(bool invalidCall) {
    isInvalidCall = invalidCall;
  }

  setIsFocusNodeSrc(bool isFocusedSrcNode) {
    _isFocusNodeSrc = isFocusedSrcNode;
  }

  set callback(Function callback) {
    _callback = callback;
  }

  MapBloc() {
    _defaultPosition = LatLng(23.8103, 90.4125);
    invoiceStatus();
    createMarkerImageFromAsset();
    selCoordinates.clear();
  }

  set sourceAddress(String address) {
    _srcAddressController.text = address;
  }

  set destinationAddress(String address) {
    _dstAddressController.text = address;
  }

  _setCurrentLocation() async {
    if (isInvalidCall) return;
    var location = new Location();
    var currentLocation = await location.getLocation();
    Map addresses = await getAddress(
        Coordinates(currentLocation.latitude, currentLocation.longitude));
    if (addresses != null) {
      String isoCode = addresses["countryCode"];
      if (isoCode == 'BD' || isoCode == 'BGD') {
        isFocusNodeSrc
            ? _srcAddressController.text = addresses["address"]
            : _dstAddressController.text = addresses["address"];
        updatePosition(
            LatLng(currentLocation.latitude, currentLocation.longitude));
        return;
      }
      _callback();
      addresses = await getAddress(
          Coordinates(_defaultPosition.latitude, _defaultPosition.longitude));
      if (addresses != null)
        isFocusNodeSrc
            ? _srcAddressController.text = addresses["address"]
            : _dstAddressController.text = addresses["address"];
      updatePosition(_defaultPosition);
    }
  }

  _initPrevState() {
    polyLines.clear();
    latLngBounds = null;
    if (mapMarkers.length > 1) {
      mapMarkers.clear();
      _markers.clear();
      _markerIdCounter = 0;
      Marker updatedMarker = Marker(
        markerId: MarkerId(_markerIdVal()),
        position: _defaultPosition,
        icon: _isFocusNodeSrc ? pickUpPin : dropOffPin,
        infoWindow: InfoWindow(
            title: "",
            snippet: 'You can move the map to reposition pin on the map'),
      );
      _markers[MarkerId(_markerIdVal())] = updatedMarker;
    }
    Future.delayed(Duration(seconds: 2)).asStream().listen((_) {
      isInvalidCall = false;
    });
    myLocVis = true;
  }

  void createRoute() {
    _polyLines.add(Polyline(
        polylineId: PolylineId(selCoordinates[pickUp].toString()),
        width: 6,
        points: _convertToLatLng(_decodePoly(polygon)),
        color: Colors.black));
  }

  void _addMarker() {
    _markers.clear();
    LatLng sourcePos = _polyLines.elementAt(0).points.elementAt(0);
    LatLng destPos = _polyLines
        .elementAt(_polyLines.length - 1)
        .points
        .elementAt(
            (_polyLines.elementAt(_polyLines.length - 1).points.length - 1));
    _markers[MarkerId(_markerIdVal(increment: false))] = Marker(
        markerId: MarkerId(_markerIdVal(increment: true)),
        position: sourcePos,
        icon: pickUpPin);
    _markers[MarkerId(_markerIdVal(increment: false))] = Marker(
        markerId: MarkerId(_markerIdVal(increment: false)),
        position: destPos,
        icon: dropOffPin);
    notifyListeners();
  }

  List<LatLng> _convertToLatLng(List points) {
    List<LatLng> result = <LatLng>[];
    for (int i = 0; i < points.length; i++) {
      if (i % 2 != 0) {
        result.add(LatLng(points[i - 1], points[i]));
      }
    }
    return result;
  }

  List _decodePoly(String poly) {
    var list = poly.codeUnits;
    var lList = new List();
    int index = 0;
    int len = poly.length;
    int c = 0;

    do {
      var shift = 0;
      int result = 0;
      do {
        c = list[index] - 63;
        result |= (c & 0x1F) << (shift * 5);
        index++;
        shift++;
      } while (c >= 32);
      if (result & 1 == 1) {
        result = ~result;
      }
      var result1 = (result >> 1) * 0.00001;
      lList.add(result1);
    } while (index < len);

    for (var i = 2; i < lList.length; i++) lList[i] += lList[i - 2];

    print(lList.toString());

    return lList;
  }

  void _sendRequest() async {
    List<Map> listOfMap = await GoogleRepository.gDirectionApi(
        selCoordinates[pickUp], selCoordinates[dropOff]);
    polygon = listOfMap.length == 3 ? listOfMap[2]["points"] : "";
    createRoute();
    _addMarker();
    myLocVis = false;
    _bound(listOfMap[0]["lat"], listOfMap[0]["lng"], listOfMap[1]["lat"],
        listOfMap[1]["lng"]);
  }

  void updatePosition(LatLng position) {
    _initPrevState();
    if (position != null) {
      _addPosition(position);
      Future.delayed(Duration(milliseconds: 500), () async {
        GoogleMapController controller = await _mapController.future;
        controller.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: position,
              zoom: 14.0,
            ),
          ),
        );
      });
    }
  }

  _addPosition(LatLng position) {
    _isFocusNodeSrc
        ? selCoordinates[pickUp] = LatLng(position.latitude, position.longitude)
        : selCoordinates[dropOff] =
            LatLng(position.latitude, position.longitude);
  }

  onCameraMove(CameraPosition position) {
    tecSrcFocus.unfocus();
    tecDstFocus.unfocus();
    if (_markers.length > 1) return;
    if (_markers.length > 0) {
      _isFocusNodeSrc
          ? selCoordinates[pickUp] = position.target
          : selCoordinates[dropOff] = position.target;
      MarkerId markerId = MarkerId(_markerIdVal());
      Marker marker = _markers[markerId];
      Marker updatedMarker = marker.copyWith(
        positionParam:
            _isFocusNodeSrc ? selCoordinates[pickUp] : selCoordinates[dropOff],
        iconParam: _isFocusNodeSrc ? pickUpPin : dropOffPin,
        infoWindowParam: InfoWindow(
            title: "",
            snippet: 'You can move the map to reposition pin on the map'),
      );
      _markers[markerId] = updatedMarker;
    }
    notifyListeners();
  }

  onCameraIdle(TextEditingController tec) {
    if (isInvalidCall ||
        (_isFocusNodeSrc && selCoordinates[pickUp] == null) ||
        (!_isFocusNodeSrc && selCoordinates[dropOff] == null)) return;
    _mapIdleSubscription?.cancel();
    _mapIdleSubscription =
        Future.delayed(Duration(milliseconds: 300)).asStream().listen((_) {
      LatLng position =
          _isFocusNodeSrc ? selCoordinates[pickUp] : selCoordinates[dropOff];
      if (position != null) {
        _onLocationChange(position, tec);
        Future.delayed(Duration(milliseconds: 1500)).asStream().listen((_) {
          isFromDropDown = false;
        });
      }
    });
  }

  _onLocationChange(LatLng position, TextEditingController tec) async {
    final coordinates = new Coordinates(position.latitude, position.longitude);
    if (!isFromDropDown) {
      Map addresses = await getAddress(coordinates);
      if (addresses != null) {
        String isoCode = addresses["countryCode"];
        if (isoCode == 'BD' || isoCode == 'BGD') {
          tec.text = addresses["address"];
          _addPosition(position);
        } else {
          updatePosition(_defaultPosition);
          _callback();
        }
      }
    }
  }

  void onCreated(GoogleMapController controller) {
    _controller = controller;
    _onMapCreated();
  }

  _onMapCreated() async {
    Future.delayed(Duration(milliseconds: 250)).asStream().listen((_) {
      checkLocPermission();
    });
    MarkerId markerId = MarkerId(_markerIdVal());
    Marker marker = Marker(
        markerId: markerId,
        position: selCoordinates[pickUp] ?? _defaultPosition,
        draggable: false,
        icon: pickUpPin);
    _markers[markerId] = marker;
    _mapController.complete(_controller);
  }

  _bound(double northLat, double northLng, double southLat, double southLng) {
    latLngBounds = LatLngBounds(
        northeast: LatLng(northLat, northLng),
        southwest: LatLng(southLat, southLng));
    _controller.animateCamera(CameraUpdate.newLatLngBounds(latLngBounds, 20.0));
  }

  String _markerIdVal({bool increment = false}) {
    String val = 'marker_id_$_markerIdCounter';
    if (increment) _markerIdCounter++;
    return val;
  }

  createMarkerImageFromAsset() async {
    fromAsset(Platform.isIOS
            ? 'images/pickup_pin.png'
            : 'images/2.0x/pickup_pin.png')
        .then((bd) {
      pickUpPin = bd;
    });
    fromAsset(Platform.isIOS
            ? 'images/dropoff_pin.png'
            : 'images/2.0x/dropoff_pin.png')
        .then((bd) {
      dropOffPin = bd;
    });
    notifyListeners();
  }

  void handleFocusState(String btnText) {
    LatLng position;
    buttonText = btnText;
    notifyListeners();
    if (_isFocusNodeSrc) {
      position = selCoordinates[pickUp];
    } else if (!_isFocusNodeSrc) {
      if (selCoordinates[dropOff] != null) {
        position = selCoordinates[dropOff];
      }
    }
    updatePosition(position);
  }

  void handleButtonClickState(
      String textPick, String textDrop, String next, VoidCallback callback) {
    isInvalidCall = true;
    if (_srcAddressController.text.isNotEmpty &&
        (buttonText == null || buttonText.compareTo(textPick) == 0)) {
      buttonText = textDrop;
      tecDstFocus.requestFocus();
    } else if (_srcAddressController.text.isNotEmpty &&
        _dstAddressController.text.isNotEmpty &&
        (buttonText.compareTo(textDrop) == 0)) {
      buttonText = next;
      _sendRequest();
    } else if (buttonText.compareTo(next) == 0) {
      CreateTripRequest tripRequest = CreateTripRequest.instance;
      tripRequest.pickUpAddress = _srcAddressController.text;
      tripRequest.dropOffAddress = _dstAddressController.text;
      tripRequest.pickUplat = selCoordinates[pickUp].latitude;
      tripRequest.pickUplon = selCoordinates[pickUp].longitude;
      tripRequest.dropOfflat = selCoordinates[dropOff].latitude;
      tripRequest.dropOfflon = selCoordinates[dropOff].longitude;
      tripRequest.directionPolygon = polygon;
      callback();
      return;
    }
    notifyListeners();
    Future.delayed(Duration(seconds: 2)).asStream().listen((_) {
      isInvalidCall = false;
    });
  }

  invoiceStatus() async {
    if (_isEnterpriseUser()) {
      UserRepository.invoiceActivated().then((apiRes) {
        if (apiRes.status == Status.COMPLETED) {
          Prefs.setBoolean(Prefs.INVOICE_STATUS,
              isInvAct = InvoiceStatus.fromJson(apiRes.data).status ?? false);
        }
      });
    }
  }

  getPosUsingPlaceId(suggestion) {
    isFromDropDown = true;
    isNullOrEmpty(suggestion.placeId)
        ? updatePosition(LatLng(suggestion.lat, suggestion.lon))
        : GoogleRepository.gPlaceDetailApi(suggestion.placeId).then((map) {
            updatePosition(LatLng(map['lat'], map['lng']));
          });
  }

  Future<Map> getAddress(Coordinates coordinates) async {
    Map map = Map();
    AddressComponent address = await GoogleRepository.gGeocode(coordinates);
    List listOfAddress = [];
    if (address?.address_components != null) {
      listOfAddress = address.address_components;
      map["address"] = address.formatted_address.replaceAll(", Bangladesh", "");
    }
    for (var ads in listOfAddress) {
      for (var type in ads.types) {
        print(type);
        if (type == 'country')
          map["countryCode"] = ads.short_name;
        else if (type == 'postal_code') {
          map["address"] = map["address"].replaceAll(ads.short_name, "").trim();
        }
      }
    }
    return map;
  }

  checkLocPermission() async {
    bool granted = await _permissionsHandler.hasLocationPermission();
    if (!granted) {
      bool isGranted = await _permissionsHandler.requestLocationPermission();
      if (isGranted) {
        _setCurrentLocation();
      }
    } else {
      print('Location permission granted checked');
      _setCurrentLocation();
    }
  }

  bool _isEnterpriseUser() => Prefs.getBoolean(Prefs.PREF_IS_ENTERPRISE_USER);

  @override
  void dispose() {
    super.dispose();
  }
}
