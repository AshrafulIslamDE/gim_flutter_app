import 'package:customer/core/localization/AppTranslation.dart';
import 'package:customer/data/local/db/customer_trip_cancel_reason.dart';
import 'package:customer/networking/api_response.dart';
import 'package:customer/ui/review/add_rating_page.dart';
import 'package:customer/ui/trip/booking_detail/cancel_reason_page.dart';
import 'package:customer/ui/trip/trip_detail/widget/trip_info_widget.dart';
import 'package:customer/ui/trip/trip_detail/widget/user_truck_info_widget.dart';
import 'package:customer/ui/widget/app_bar.dart';
import 'package:customer/ui/widget/base_widget.dart';
import 'package:customer/ui/widget/caller_layout.dart';
import 'package:customer/ui/widget/driver_item_widget.dart';
import 'package:customer/ui/widget/map_img_widget.dart';
import 'package:customer/ui/widget/app_button.dart';
import 'package:customer/ui/widget/navigation_utils.dart';
import 'package:customer/ui/widget/partner_item_widget.dart';
import 'package:customer/ui/widget/trip_address_widget.dart';
import 'package:customer/ui/widget/truck_item_widget.dart';
import 'package:customer/utils/analytics.dart';
import 'package:customer/utils/common_utils.dart';
import 'package:customer/utils/date_time_utils.dart';
import 'package:customer/utils/screen_dimension_utils.dart';
import 'package:customer/utils/firebase_analytics_utils.dart';
import 'package:customer/utils/ui_constant.dart';
import 'package:customer/utils/ui_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../styles.dart';
import 'bloc/booking_detail_bloc.dart';

enum TRIP_STATUS { BOOKED, RUNNING, COMPLETED, CANCELLED }

class BookingDetailContainer extends StatelessWidget {
  final int tripId;
  final TRIP_STATUS tripStatus;

  BookingDetailContainer(
      {this.tripId, this.tripStatus = TRIP_STATUS.BOOKED});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<BookingDetailBloc>(
            create: (_) => BookingDetailBloc(ModalRoute.of(context).settings.arguments)),
      ],
      child: BookingDetailPage(tripId: tripId, tripStatus: tripStatus),
    );
  }
}

class BookingDetailPage extends StatefulWidget {
  final int tripId;
  TRIP_STATUS tripStatus;

  BookingDetailPage({this.tripId, this.tripStatus});

  @override
  _BookingDetailPageState createState() => _BookingDetailPageState();
}

class _BookingDetailPageState
    extends BasePageWidgetState<BookingDetailPage, BookingDetailBloc> {
  /*it is used to keep record of whether any change happend in this page,
   like start a booked trip or complete a live trip or cancel a booked trip,
   so that user can take appropriate action on trip list when it go back to previous page  */
  bool didChangeHappened = false;
  CustomerTripCancelReason cancelReason;

  /* if user change trip status by calling api like booked trip to live trip, live trip to history trip etc
  and user go back to previous pages, then this implementation carry out the status to refresh previous page trip list
*/
  @override
  Future<bool> onWillPop() async {
    Navigator.pop(context, didChangeHappened);
    return false;
  }

  @override
  onBuildCompleted() {
    if (mounted) _getBookingDetail(widget.tripId, widget.tripStatus, false);
  }

  @override
  PreferredSizeWidget getAppbar() => AppBarWidget(
        title: translate(context, "txt_book_dtl_ttl"),
        shouldShowBackButton: true,
      );

  @override
  getFloatingActionButton() => CallerWidget(autoAlignment: false);

  @override
  List<Widget> getPageWidget() {
    return [
      Consumer<BookingDetailBloc>(
        builder: (context, bloc, _) => Stack(
          children: <Widget>[
            bloc.bookingDetail == null
                ? Container()
                : Container(
                    color: Colors.white,
                    child: SingleChildScrollView(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                          MapImage(
                              imageUrl:
                                  bloc.bookingDetail.staticMapPhotoTwoEighty),
                          Visibility(
                            visible: widget.tripStatus != TRIP_STATUS.COMPLETED,
                            child: Text(
                                widget.tripStatus == TRIP_STATUS.BOOKED
                                    ? getTimeDifferenceInDaysHours(bloc
                                            .bookingDetail.pickupDateTimeUtc)
                                        .toString()
                                        .toUpperCase()
                                    : showEtaTime(
                                        bloc.bookingDetail
                                            .estimatedTravelTimeInMinute,
                                        bloc.bookingDetail.startDateTime),
                                style: widget.tripStatus == TRIP_STATUS.BOOKED
                                    ? Styles.textStyleGreenMed
                                    : Styles.textStyleRedMed),
                          ),
                          Visibility(
                            visible: widget.tripStatus != TRIP_STATUS.COMPLETED,
                            child: Container(
                              margin: EdgeInsets.only(
                                  left: 20.0,
                                  top: 5.0,
                                  right: 20.0,
                                  bottom: 5.0),
                              child: FilledColorButton(
                                buttonText: widget.tripStatus ==
                                        TRIP_STATUS.BOOKED
                                    ? translate(context, "txt_start_trip")
                                    : translate(context, "txt_complete_trip"),
                                onPressed: () {
                                  if (!bloc.isLoading) {
                                    widget.tripStatus == TRIP_STATUS.BOOKED
                                        ? _showDialog(
                                            translate(
                                                context, "start_trip_dlg_ttl"),
                                            null,
                                            translate(context, 'yes')
                                                .toUpperCase(),
                                            translate(context, 'no')
                                                .toUpperCase(),
                                            _onStartTrip)
                                        : _showDialog(
                                            translate(context,
                                                "complete_trip_dlg_ttl"),
                                            null,
                                            translate(context, 'yes')
                                                .toUpperCase(),
                                            translate(context, 'no')
                                                .toUpperCase(),
                                            _onEndTrip);
                                  }
                                },
                              ),
                            ),
                          ),
                          TripInfoWidget(
                            widget.tripId,
                            tripStatus: widget.tripStatus,
                            totalAmount: amountWithCurrencySign(
                                bloc.bookingDetail.bidAmount),
                            advanceAmount: amountWithCurrencySign(
                                bloc.bookingDetail.advance),
                            amountInfo:
                                AppTranslations.of(context).text("txt_ado_lc"),
                          ),
                          AddressWidget(
                            tripItem: bloc.bookingDetail,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: DriverWidget(bloc.bookingDetail,widget.tripStatus,bloc.isEnterpriseUser()),
                          ),
                          PartnerWidget(bloc.bookingDetail,widget.tripStatus,bloc.isEnterpriseUser()),
                          Divider(
                            color: Colors.grey,
                            height: responsiveSize(16.0),
                          ),
                          TruckWidget(bloc.bookingDetail,widget.tripStatus,bloc.isEnterpriseUser()),
                          Divider(
                            color: Colors.grey,
                            height: responsiveSize(16.0),
                          ),
                          Visibility(
                            visible: widget.tripStatus == TRIP_STATUS.BOOKED,
                            child: Container(
                              margin: EdgeInsets.only(
                                  left: 20.0,
                                  top: 10.0,
                                  right: 20.0,
                                  bottom: 20.0),
                              child: FilledColorButton(
                                isFilled: true,
                                textColor: ColorResource.colorMarineBlue,
                                borderColor: Colors.grey,
                                backGroundColor: Colors.white,
                                buttonText:
                                    translate(context, "txt_cancel_trip"),
                                onPressed: () {
                                  if (!bloc.isLoading) {
                                    _showDialog(
                                        translate(
                                            context, "cancel_trip_dlg_ttl"),
                                        null,
                                        translate(context, 'yes').toUpperCase(),
                                        translate(context, 'no').toUpperCase(),
                                        _onCancelReasonPage);
                                  }
                                },
                              ),
                            ),
                          )
                        ]))),
          ],
        ),
      )
    ];
  }

  _getBookingDetail(int tripId, TRIP_STATUS tripStatus, bool listen) {
    submitDialog(context, dismissible: false);
    bloc.getTripDetail(tripId, tripStatus).then((apiRes) {
      _manipulateResponse(apiRes, TRIP_STATUS.BOOKED);
    });
  }

  void _onStartTrip() {
    submitDialog(context, dismissible: false);
    bloc.startTrip(widget.tripId, TRIP_STATUS.RUNNING).then((apiRes) {
      if (!bloc.isApiError(apiRes)) FireBaseAnalytics().logEvent(AnalyticsEvents.EVENT_START_TRIP, AnalyticsParams.USER_ROLE);
      _manipulateResponse(apiRes, TRIP_STATUS.RUNNING);
    });
  }

  _showDialog(String title, String content, String ptvBtnTxt, String negBtnTxt,
      Function callBack) {
    onAlertWithTitlePress(
        context, title, content, ptvBtnTxt, negBtnTxt, callBack);
  }

  _onCancelReasonPage() async {
    final result = await Navigator.push(context,
        MaterialPageRoute(builder: (context) => CancelReasonContainer()));
    if (result != null) _onCancelTrip(result);
  }

  void _onCancelTrip(cancelReason) {
    submitDialog(context, dismissible: false);
    this.cancelReason = cancelReason;
    bloc
        .cancelTrip(widget.tripId, cancelReason.id, TRIP_STATUS.BOOKED)
        .then((apiRes) {
      _manipulateResponse(apiRes, TRIP_STATUS.CANCELLED);
    });
  }

  void _onEndTrip() {
    submitDialog(context, dismissible: false);
    bloc.endTrip(widget.tripId, TRIP_STATUS.COMPLETED).then((apiRes) {
      if (!bloc.isApiError(apiRes)) {
        FireBaseAnalytics().logEvent(AnalyticsEvents.EVENT_COMPLETE_TRIP,AnalyticsParams.USER_ROLE);
        Navigator.pop(context);
        didChangeHappened = true;
        onNavigateToRatingSubmissionScreen();
        return;
      }
      _manipulateResponse(apiRes, TRIP_STATUS.COMPLETED);
    });
  }

  _manipulateResponse(ApiResponse response, TRIP_STATUS tripStatus) {
    Navigator.pop(context);
    if (bloc.isApiError(response)) {
      showAlertWithDefaultAction(context,content: response.message ?? translate(context, 'something_went_wrong'), positiveBtnTxt: AppTranslations.of(context).text("txt_ok"));
      return;
    }
    if (response.message != null)
      showSnackBar(scaffoldState.currentState, response.message);

    if (tripStatus == TRIP_STATUS.BOOKED) return;
    didChangeHappened = true;
    if (tripStatus == TRIP_STATUS.CANCELLED) {
      FireBaseAnalytics().logEvent(AnalyticsEvents.EVENT_CANCEL_TRIP,
          {AnalyticsParams.TRIP_CANCEL_REASON: cancelReason.value});
      showAlertWithDefaultAction(context,
          title: translate(context, "can_trip_dlg_ttl"),
          content: translate(context, "can_trip_dlg_con"),
          positiveBtnTxt: translate(context, "can_trip_dlg_ptv"),
          callback: () => Navigator.pop(context, didChangeHappened));
      return;
    } else if (tripStatus == TRIP_STATUS.COMPLETED ||
        tripStatus == TRIP_STATUS.RUNNING) {
      _getBookingDetail(widget.tripId, widget.tripStatus = tripStatus, false);
    }
  }

  onNavigateToRatingSubmissionScreen() async {
    await navigateNextScreen(context, AddARatingScreen(widget.tripId));
    didChangeHappened = true;
    //  print("result2: $result");
    Navigator.pop(context, didChangeHappened);
  }
}
