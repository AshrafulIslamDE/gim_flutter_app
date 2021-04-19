import 'package:customer/model/tracker/location_response.dart';
import 'package:fluster/fluster.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';

class MapMarker extends Clusterable {
  final String id;
  final String address;
  final LatLng position;
  final TruckLocations tripLoc;
  final BitmapDescriptor bitmap;
  final Function(TruckLocations) onTapInfo;
  final Function(TruckLocations) callback;

  MapMarker(
      {@required this.id,
      @required this.bitmap,
      @required this.position,
      this.onTapInfo,
      this.address,
      isCluster = false,
      clusterId,
      pointsSize,
      childMarkerId,
      this.callback,
      this.tripLoc})
      : super(
          markerId: id,
          latitude: position.latitude,
          longitude: position.longitude,
          isCluster: isCluster,
          clusterId: clusterId,
          pointsSize: pointsSize,
          childMarkerId: childMarkerId,
        );

  Marker toMarker() => Marker(
      markerId: MarkerId(id),
      position: LatLng(
        position.latitude,
        position.longitude,
      ),
      icon: bitmap,
      onTap: () => callback(tripLoc),
      infoWindow: address != null || tripLoc == null
          ? null
          : InfoWindow(
              title: 'Trip No.${tripLoc?.tripNo}  ${tripLoc?.speed != null && tripLoc.speed > 9 ? '(MOVING)' : '(IDLE)'}',
              snippet: tripLoc?.truckRegistrationNumber,
              onTap: () => onTapInfo(tripLoc)));
}
