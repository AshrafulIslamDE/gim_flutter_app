/*
import 'package:clustering_google_maps/clustering_google_maps.dart';
import 'package:customer/networking/api_response.dart';
import 'package:customer/ui/tracker/bloc/map_tracker_bloc.dart';
import 'package:customer/ui/tracker/map_helper.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class TrackerClusterScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<TrackerBloc>(create: (_) => TrackerBloc()),
      ],
      child: TrackerClusterPage(),
    );
  }
}

class TrackerClusterPage extends StatefulWidget {
  final List<LatLngAndGeohash> geohashlist;

  TrackerClusterPage({Key key, this.geohashlist}) : super(key: key);

  @override
  _TrackerScreenState createState() => _TrackerScreenState();
}


class _TrackerScreenState extends State<TrackerClusterPage> {
  ClusteringHelper clusteringHelper;
  final CameraPosition initialCameraPosition =
  CameraPosition(target: LatLng(0.000000, 0.000000), zoom: 0.0);
  TrackerBloc bloc;
  Set<Marker> markers = Set();

  void _onMapCreated(GoogleMapController mapController) async {
    print("onMapCreated");
    initMemoryClustering();
    clusteringHelper?.mapController = mapController;
    clusteringHelper?.updateMap();
  }

*/
/*  updateMarkers(Set<Marker> markers) {
    setState(() async {
      var futureMrkers=await markers.map((item)async{
        var icon=await MapHelper.getMarkerImageFromUrl('images/2.0x/ic_pin_truck_idle.png');
        for(int index=0;index<bloc.LatLngAndGeohashList.length;index++) {
          return item.copyWith(
              iconParam: icon
          );
        }
        return item;

      }) as Set<Marker>;

      this.markers = futureMrkers;
    });
  }*//*


  void _updateMarkers(Set<Marker> markers) async {

  //  final knownMarkers = _convertToKnownMarkerSet(markers);
    setState(() {
      this.markers = markers;
    });
  }

  Set<Marker> _convertToKnownMarkerSet(Set<Marker> clusteredMarkers) {
    final Set<Marker> newMarkers = Set();
    for (Marker marker in clusteredMarkers) {
      final converted = _getKnownMarker(marker);
      newMarkers.add(converted);
    }
    return newMarkers;
  }

  Marker _getKnownMarker(Marker newMarker) {
    for (Marker marker in bloc.markers) { //`allMapMarkers` is set of all my markers.
      if (marker.position == newMarker.position) {
        print("new marker");
        return newMarker.copyWith(
          iconParam: marker.icon
        );
      }
    }
    return newMarker;
  }

 initMemoryClustering() {
    clusteringHelper = ClusteringHelper.forMemory(
      list: bloc.LatLngAndGeohashList,
      updateMarkers: _updateMarkers,
      aggregationSetup: AggregationSetup(markerSize: 150),
    );

 }

 updateClusteringData(){
   clusteringHelper.updateData(bloc.LatLngAndGeohashList);
 }
  @override
  void initState() {
    bloc=Provider.of<TrackerBloc>(context, listen: false);
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      var listItem=await bloc.getLocations();
      updateClusteringData();
      bloc.notifyListeners();
      Future.delayed(Duration(milliseconds: 2000)).then((onValue) =>
          clusteringHelper?.mapController.animateCamera(CameraUpdate.newLatLngZoom(bloc.target, 10)));
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Clustering Example"),
      ),
      body: Consumer<TrackerBloc>(
        builder: (context,bloc,_)=> GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition: initialCameraPosition,
          markers: markers,
          onCameraMove: (newPosition) =>
              clusteringHelper?.onCameraMove(newPosition, forceUpdate: false),
          onCameraIdle: clusteringHelper?.onMapIdle,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: bloc.LatLngAndGeohashList == null ? Icon(Icons.content_cut) : Icon(Icons.update),
        onPressed: () {
          if (bloc.LatLngAndGeohashList == null) {
            //Test WHERE CLAUSE
          }
          //Force map update
          clusteringHelper.updateMap();
        },
      ),
    );
  }
}*/
