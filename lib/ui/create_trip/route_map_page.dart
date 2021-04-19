import 'package:customer/core/localization/AppTranslation.dart';
import 'package:customer/ui/widget/app_button.dart';
import 'package:customer/ui/widget/base_widget.dart';
import 'package:customer/ui/widget/caller_layout.dart';
import 'package:customer/ui/widget/create_trip_title_widget.dart';
import 'package:customer/ui/widget/google_placces_widget.dart';
import 'package:customer/ui/widget/navigation_utils.dart';
import 'package:customer/utils/screen_dimension_utils.dart';
import 'package:customer/utils/analytics.dart';
import 'package:customer/utils/firebase_analytics_utils.dart';
import 'package:customer/utils/ui_constant.dart';
import 'package:customer/utils/ui_utils.dart';
import 'package:firebase_performance/firebase_performance.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import 'additional_detail_page.dart';
import 'bloc/map_bloc.dart';

class CreateTripMapScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<MapBloc>(create: (_) => MapBloc()),
      ],
      child: MapSrcDstPicker(),
    );
  }
}

class MapSrcDstPicker extends StatefulWidget {
  @override
  MapSrcDstPickerState createState() => MapSrcDstPickerState();
}

class MapSrcDstPickerState
    extends BasePageWidgetState<MapSrcDstPicker, MapBloc> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final Trace trace = FirebasePerformance.instance.newTrace('create_trip_map');
  MapBloc mapBloc;

  @override
  void initState() {
    trace.start();
    super.initState();
  }
  @override
  PreferredSizeWidget getAppbar() {
    return CreateTripHeader(
      currentStep: 2,
      isShowBackButton: true,
    );
  }

  @override
  getFloatingActionButton() => Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Visibility(
            visible: Provider.of<MapBloc>(context).myLocVis,
            child: FloatingActionButton(
              heroTag: 'currentLoc',
              backgroundColor: ColorResource.colorWhite,
              child: Icon(Icons.my_location, color: ColorResource.warm_grey),
              onPressed: () {
                mapBloc.isFocusNodeSrc
                    ? mapBloc.srcAddressController.text = ''
                    : mapBloc.dstAddressController.text = '';
                currentLocation();
              },
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          CallerWidget(
            autoAlignment: false,
            extSpacing: responsiveSize(20.0),
          ),
        ],
      );

  @override
  List<Widget> getPageWidget() {
    mapBloc = Provider.of<MapBloc>(context);
    mapBloc.callback = outSideBd;
    return [
      Stack(
        children: <Widget>[
          GoogleMap(
            onTap: (_) => hideSoftKeyboard(context),
            markers: mapBloc.mapMarkers,
            onMapCreated: mapBloc.onCreated,
            initialCameraPosition: CameraPosition(
              target: mapBloc.initialPosition,
              zoom: mapBloc.minMaxZoom?.maxZoom ?? 14.0 ,
            ),
            onCameraMove: mapBloc.onCameraMove,
            onCameraIdle: mapBloc.onCameraIdle(mapBloc.isFocusNodeSrc
                ? mapBloc.srcAddressController
                : mapBloc.dstAddressController),
            polylines: mapBloc.polyLines,
            zoomGesturesEnabled: true,
            minMaxZoomPreference:  mapBloc.minMaxZoom,
            myLocationButtonEnabled: false,
            padding: EdgeInsets.fromLTRB(0, 100.0, 0, 120.0),
            cameraTargetBounds: CameraTargetBounds(mapBloc.latLngBounds),
          ),
          Container(
            child: Column(
              children: <Widget>[
                SizedBox(height: responsiveSize(20)),
                GooglePlacesSearchWidget(
                  isSrc: true,
                  bloc: mapBloc,
                  focusNode: mapBloc.tecSrcFocus,
                  callBack: focusListener,
                  immediateSuggestion: false,
                  hintText: translate(context, 'epa_or_dp'),
                  typeAheadController: mapBloc.srcAddressController,
                  onSuggestionItemSelected: (value) {
                    value.isMyLoc ? currentLocation() : mapBloc.getPosUsingPlaceId(value);
                  },
                ),
                GooglePlacesSearchWidget(
                  isSrc: false,
                  bloc: mapBloc,
                  focusNode: mapBloc.tecDstFocus,
                  callBack: focusListener,
                  immediateSuggestion: false,
                  hintText: translate(context, 'eda_or_dp'),
                  typeAheadController: mapBloc.dstAddressController,
                  onSuggestionItemSelected: (value) {
                    value.isMyLoc ? currentLocation() : mapBloc.getPosUsingPlaceId(value);
                  },
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
          Positioned.fill(
            child: Container(
              margin: EdgeInsets.only(bottom: 20.0, left: 10.0, right: 10.0),
              child: Align(
                  alignment: Alignment.bottomCenter,
                  child: FilledColorButton(
                    buttonText: mapBloc.buttonText == null
                        ? AppTranslations.of(context).text("txt_pick")
                        : mapBloc.buttonText,
                    onPressed: handleButtonAction,
                  )),
            ),
          ),
        ],
      )
    ];
  }

  void focusListener(bool isSrcFocus) {
    mapBloc.setIsFocusNodeSrc(isSrcFocus);
    mapBloc.handleFocusState(isSrcFocus
        ? translate(context, 'txt_pick')
        : translate(context, 'txt_drop'));
  }

  handleButtonAction() {
    if (mapBloc.buttonText
                .compareTo(AppTranslations.of(context).text("txt_pick")) ==
            0 &&
        (mapBloc.srcAddressController.text.isEmpty ||
            mapBloc.selCoordinates[MapBloc.pickUp] == null)) {
      showSnackBar(scaffoldKey.currentState,
          AppTranslations.of(context).text("txt_epa"));
      return;
    } else if (mapBloc.buttonText
                .compareTo(AppTranslations.of(context).text("txt_drop")) ==
            0 &&
        (mapBloc.dstAddressController.text.isEmpty ||
            mapBloc.selCoordinates[MapBloc.dropOff] == null)) {
      showSnackBar(scaffoldKey.currentState,
          AppTranslations.of(context).text("txt_eda"));
      return;
    }
    mapBloc?.handleButtonClickState(
        translate(context, 'txt_pick'),
        translate(context, 'txt_drop'),
        translate(context, 'txt_next'),
        navigate);
  }

  currentLocation() {
    mapBloc?.checkLocPermission();
  }

  outSideBd() {
    showSnackBar(
        scaffoldKey.currentState, AppTranslations.of(context).text("txt_obd"));
  }

  navigate() async {
    trace.stop();
    FireBaseAnalytics().logEvent(
        AnalyticsEvents.EVENT_CREATE_TRIP_ADDRESS_SELECT, null);
    navigateNextScreen(
        context,
        CreateTripAdditionalDetailScreen(
            invoiceActivated: mapBloc.isInvAct ?? false));
  }
}
