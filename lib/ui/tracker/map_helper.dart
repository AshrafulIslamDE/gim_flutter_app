import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:customer/utils/image_utils.dart';
import 'package:fluster/fluster.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'map_marker.dart';


class MapHelper {

  static Future<BitmapDescriptor> getMarkerImageFromUrl(
    String url, {
    int targetWidth,
  }) async {
    assert(url != null);
    return fromAsset(url);
  }

  static Future<Fluster<MapMarker>> initClusterManager(
    List<MapMarker> markers,
    int minZoom,
    int maxZoom,
      BitmapDescriptor clusterImage,
  ) async {
    assert(markers != null);
    assert(minZoom != null);
    assert(maxZoom != null);
    assert(clusterImage != null);

    return Fluster<MapMarker>(
      minZoom: minZoom,
      maxZoom: maxZoom,
      radius: 0,
      extent: 2048,
      nodeSize: 64,
      points: markers,
      createCluster: (
        BaseCluster cluster,
        double lng,
        double lat,
      ) =>
          MapMarker(
        id: cluster.id.toString(),
        position: LatLng(lat, lng),
        bitmap: clusterImage,
        isCluster: true,
        clusterId: cluster.id,
        pointsSize: cluster.pointsSize,
        childMarkerId: cluster.childMarkerId,
      ),
    );
  }

  /// Gets a list of markers and clusters that reside within the visible bounding box for
  /// the given [currentZoom]. For more info check [Fluster.clusters].
  static List<Marker> getClusterMarkers(
    Fluster<MapMarker> clusterManager,
    double currentZoom,
  ) {
    assert(currentZoom != null);

    if (clusterManager == null) return [];

    return clusterManager
        .clusters([-180, -85, 180, 85], currentZoom.toInt())
        .map((cluster) => cluster.toMarker())
        .toList();
  }
}
