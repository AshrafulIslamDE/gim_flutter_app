import 'package:customer/bloc/home/homebloc.dart';
import 'package:customer/core/localization/AppTranslation.dart';
import 'package:customer/ui/home/home_drawer_icon.dart';
import 'package:customer/ui/trip/trip_detail/trip_detail_page.dart';
import 'package:customer/ui/widget/app_bar.dart';
import 'package:customer/ui/widget/autocomplete_widget.dart';
import 'package:customer/ui/widget/navigation_utils.dart';
import 'package:customer/utils/common_utils.dart';
import 'package:customer/utils/screen_dimension_utils.dart';
import 'package:customer/utils/ui_constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import 'bloc/map_tracker_bloc.dart';

class TrackerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<TrackerBloc>(
            create: (_) => TrackerBloc(
                onTapInfo: (trip) => navigateNextScreen(
                    context, TripDetailPageContainer(tripId: trip.tripId)))),
      ],
      child: TrackerPage(),
    );
  }
}

class TrackerPage extends StatefulWidget {
  @override
  TrackerPageState createState() => TrackerPageState();
}

class TrackerPageState extends State<TrackerPage> {
  var focusNode = FocusNode();
  TrackerBloc bloc;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      bloc.getLocations();
    });
    focusNode.addListener(() {
      setState(() {
        bloc.searchFieldFocus = focusNode.hasFocus;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    bloc = Provider.of<TrackerBloc>(context, listen: false);
    bloc.screenWidth = screenWidth(context);
    return SafeArea(
      child: Consumer<TrackerBloc>(
          builder: (context, bloc, _) => Scaffold(
                appBar: AppBarWidget(
                  title: translate(context, 'ttl_txt_track'),
                  shouldShowBackButton: false,
                  leadingWidget: getDrawerIcon(Scaffold.of(context)),
                  action: <Widget>[
                    InkWell(
                      onTap: () {
                        bloc.filterVisibility();
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: SvgPicture.asset(
                          bloc.filterState
                              ? 'svg_img/cancel_blue.svg'
                              : 'svg_img/ic_filter_search.svg',
                          height: 26,
                          width: 26,
                        ),
                      ),
                    )
                  ],
                ),
                body: Stack(
                  children: <Widget>[
                    // Google Map widget

                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      child: Opacity(
                        opacity: bloc.isMapLoading ? 0 : 1,
                        child: GoogleMap(
                          mapToolbarEnabled: false,
                          initialCameraPosition: CameraPosition(
                            target: bloc.target,
                            zoom: bloc.initialZoom,
                          ),
                          markers: bloc.markers,
                          minMaxZoomPreference: bloc.minMaxZoom,
                          onMapCreated: bloc.onCreated,
                          myLocationButtonEnabled: false,
                          padding: EdgeInsets.only(top: 120),
                        ),
                      ),
                    ),

                    // Map loading indicator
                    Opacity(
                      opacity: bloc.isMapLoading ? 1 : 0,
                      child: Center(child: CircularProgressIndicator()),
                    ),

                    // Map markers loading indicator
                    if (bloc.areMarkersLoading)
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Align(
                          alignment: Alignment.topCenter,
                          child: Card(
                            elevation: 2,
                            color: Colors.grey.withOpacity(0.9),
                            child: Padding(
                              padding: const EdgeInsets.all(4),
                              child: Text(
                                'Loading',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                    Visibility(
                      visible: !bloc.filterState,
                      child: Positioned(
                        top: 45,
                        right: 35,
                        child: FloatingActionButton(
                            heroTag: 'live2Trip',
                            child: SvgPicture.asset(
                              'svg_img/ic_fab_lv.svg',
                              width: 25,
                              height: 25,
                              color: ColorResource.colorWhite,
                            ),
                            backgroundColor: ColorResource.colorMariGold,
                            onPressed: () {
                              // Provider.of<MyTripStatusBloc>(context,listen: false).;
                              var bloc =
                                  Provider.of<HomeBloc>(context, listen: false);
                              bloc.homePageIndex = 1;
                              bloc.myTripTabIndex = 2;
                              bloc.notifyListeners();
                            }),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(children: <Widget>[
                          Container(
                            width: double.infinity,
                            color: ColorResource.marigold_opacity_20,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(top: 8.0, bottom: 8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  /*Padding(
                                    padding: const EdgeInsets.only(left: 20.0),
                                    child: InkWell(
                                      onTap: () => bloc.onRefresh(),
                                      child: Icon(
                                        Icons.arrow_back_ios,
                                        color: ColorResource.colorMarineBlue,
                                        size: 20,
                                      ),
                                    ),
                                  ),*/
                                  Expanded(
                                    child: Text(
                                      bloc.trackTruckCount(translate(
                                          context, 'track_truck_hnt')),
                                      style: TextStyle(
                                          fontFamily: 'roboto',
                                          color: ColorResource.colorMarineBlue,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16.0),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Visibility(
                            visible: bloc.filterState,
                            child: AutocompleteTextField(
                              focusNode: focusNode,
                              hasFocus: bloc.searchFieldFocus,
                              hintText: translate(context, 'etr_hnt'),
                              suggestionList: bloc.locations,
                              onSuggestionItemSelected: (value) {
                                bloc.filterVisibility();
                                bloc.reDrawMarker(value);
                              },
                            ),
                          ),
                        ]),
                        Visibility(
                          visible: !bloc.noTrackTruck,
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Container(
                              margin: const EdgeInsets.only(bottom: 80.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  InkWell(
                                    child: Image.asset('images/ic_zoom.png',
                                        width: 80, height: 80),
                                    onTap: () {
                                      bloc.zoomOut();
                                    },
                                  ),
                                  InkWell(
                                    child: Image.asset('images/ic_refresh.png',
                                        width: 80, height: 80),
                                    onTap: () {
                                      bloc.onRefresh();
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Visibility(
                      visible: bloc.noTrackTruck,
                      child: Center(
                        child: Container(
                          padding: EdgeInsets.all(responsiveSize(10.0)),
                          margin: EdgeInsets.all(responsiveSize(20.0)),
                          decoration: new BoxDecoration(
                              color: Colors.white,
                              borderRadius: new BorderRadius.all(
                                  const Radius.circular(10.0))),
                          child: Text(
                            translate(context, 'no_track_truck'),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: responsiveTextSize(18.0),
                                fontFamily: 'roboto',
                                color: ColorResource.colorBlack),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )),
    );
  }
}
