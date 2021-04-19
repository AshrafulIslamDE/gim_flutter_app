import 'dart:io';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:customer/core/localization/AppTranslation.dart';
import 'package:customer/networking/api_response.dart';
import 'package:customer/styles.dart';
import 'package:customer/ui/create_trip/bloc/trip_summary_bloc.dart';
import 'package:customer/ui/create_trip/model/create_trip_request.dart';
import 'package:customer/ui/home/homepage.dart';
import 'package:customer/ui/widget/app_button.dart';
import 'package:customer/ui/widget/base_widget.dart';
import 'package:customer/ui/widget/caller_layout.dart';
import 'package:customer/ui/widget/create_trip_title_widget.dart';
import 'package:customer/ui/widget/full_screen_image.dart';
import 'package:customer/ui/widget/navigation_utils.dart';
import 'package:customer/utils/analytics.dart';
import 'package:customer/utils/app_data_ui_utils.dart';
import 'package:customer/utils/common_utils.dart';
import 'package:customer/utils/date_time_utils.dart';
import 'package:customer/utils/firebase_analytics_utils.dart';
import 'package:customer/utils/image_utils.dart';
import 'package:customer/utils/screen_dimension_utils.dart';
import 'package:customer/utils/ui_constant.dart';
import 'package:customer/utils/ui_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateTripDetailScreen extends StatelessWidget {
  final File imageFile;
  final bool showProdType;
  final bool showDistributor;
  final String paymentMethod;

  CreateTripDetailScreen(
      {this.imageFile,
      this.showProdType = true,
      this.showDistributor = true, this.paymentMethod});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<TripSummaryBloc>(
            create: (_) => TripSummaryBloc()),
      ],
      child: TripDetailPage(
        imageFile: imageFile,
        showProdType: showProdType,
        paymentMethod: paymentMethod,
        showDistributor: showDistributor,
      ),
    );
  }
}

class TripDetailPage extends StatefulWidget {
  final File imageFile;
  final bool showProdType;
  final bool showDistributor;
  final String paymentMethod;

  TripDetailPage({this.imageFile,
    this.paymentMethod,
    this.showProdType,
    this.showDistributor});

  @override
  TripDetailPageState createState() => TripDetailPageState();
}

class TripDetailPageState
    extends BasePageWidgetState<TripDetailPage, TripSummaryBloc> {
  var _tripRequest = CreateTripRequest.instance;

  @override
  onBuildCompleted() {
    if (mounted) setImageAsString();
  }

  @override
  PreferredSizeWidget getAppbar() => CreateTripHeader(
        isShowBackButton: true,
      );

  @override
  getFloatingActionButton() => CallerWidget(autoAlignment: false);

  @override
  List<Widget> getPageWidget() {
    _tripRequest.paymentType = widget.paymentMethod;
    return [
      Stack(
        children: <Widget>[
          Container(
              color: Colors.white,
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            color: ColorResource.lightBlue,
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Center(
                                        child: Image.asset(
                                      "images/pickuparrow.png",
                                      height: 24,
                                      width: 18,
                                    )),
                                    Expanded(
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Row(
                                              children: <Widget>[
                                                Text(
                                                  AppTranslations.of(context)
                                                      .text("tdp_pick_lbl"),
                                                  style: TextStyle(
                                                    color: Color.fromRGBO(
                                                        0, 50, 80, 1.0),
                                                    fontSize:
                                                        responsiveTextSize(
                                                            14.0),
                                                    fontFamily: "roboto",
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 4.0,
                                                ),
                                                Text(
                                                  getLocalizedFormattedDate(
                                                          _tripRequest
                                                              .datetimeUtcStr,
                                                          format:
                                                              defaultPresentationDateFormat)
                                                      .toUpperCase(),
                                                  style: TextStyle(
                                                    color: Color.fromRGBO(
                                                        0, 50, 80, 1),
                                                    fontSize:
                                                        responsiveTextSize(
                                                            14.0),
                                                    fontFamily: "roboto",
                                                    fontWeight: FontWeight.w300,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 2.0,
                                            ),
                                            Text(
                                              _tripRequest.pickUpAddress,
                                              style: Styles.tripDetailAddress,
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 20.0,
                                ),
                                Row(
                                  children: <Widget>[
                                    Center(
                                        child: Image.asset(
                                      "images/dropoffarrow.png",
                                      height: 24,
                                      width: 18,
                                    )),
                                    Expanded(
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                                AppTranslations.of(context)
                                                    .text("tdp_drop_lbl"),
                                                style: TextStyle(
                                                  color: Color.fromRGBO(
                                                      96, 154, 186, 1.0),
                                                  fontSize:
                                                      responsiveTextSize(14.0),
                                                  fontFamily: "roboto",
                                                  fontWeight: FontWeight.w700,
                                                )),
                                            SizedBox(
                                              height: 2.0,
                                            ),
                                            Text(
                                              _tripRequest.dropOffAddress,
                                              style: Styles.tripDetailAddress,
                                              softWrap: true,
                                              maxLines: 2,
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 20.0, top: 20.0),
                            child: Text(
                              translate(context, 'txt_truck_dtl'),
                              style: TextStyle(
                                  fontSize: responsiveTextSize(15.0),
                                  color: Color.fromRGBO(0, 50, 80, 1.0),
                                  fontFamily: "roboto",
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(
                                20.0, 10.0, 20.0, 20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  localize("tdp_type_size_lbl"),
                                  style: Styles.tripDetailLabel,
                                  textAlign: TextAlign.start,
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                                Text(
                                  _tripRequest.truckTypeStr +
                                      ', ' +
                                      localize('number_decimal_count',
                                          dynamicValue:
                                              _tripRequest.truckSizeStr,
                                          symbol: "%f") +
                                      translate(context, 'txt_ton'),
                                  style: Styles.tripDetailValue,
                                  textAlign: TextAlign.start,
                                ),
                                SizedBox(
                                  height: 20.0,
                                ),
                                Row(
                                  children: <Widget>[
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          AppTranslations.of(context)
                                              .text("tdp_pay_type_lbl"),
                                          style: Styles.tripDetailLabel,
                                          textAlign: TextAlign.start,
                                        ),
                                        SizedBox(
                                          height: 5.0,
                                        ),
                                        Text(
                                          widget.paymentMethod,
                                          style: Styles.tripDetailValue,
                                          textAlign: TextAlign.start,
                                        )
                                      ],
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 50.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              AppTranslations.of(context)
                                                  .text("tdp_truck_dimen"),
                                              style: Styles.tripDetailLabel,
                                              textAlign: TextAlign.start,
                                            ),
                                            SizedBox(
                                              height: 5.0,
                                            ),
                                            Consumer<TripSummaryBloc>(
                                                builder: (context, bloc, _) =>
                                                    AutoSizeText(
                                                      setTruckDimension(
                                                          length: _tripRequest
                                                                      .truckLength ==
                                                                  null
                                                              ? null
                                                              : double.parse(
                                                                  _tripRequest
                                                                      .truckLength),
                                                          width: _tripRequest
                                                                      .truckWidth ==
                                                                  null
                                                              ? null
                                                              : double.parse(
                                                                  _tripRequest
                                                                      .truckWidth),
                                                          height: _tripRequest
                                                                      .truckHeight ==
                                                                  null
                                                              ? null
                                                              : double.parse(
                                                                  _tripRequest
                                                                      .truckHeight)),
                                                      style: Styles
                                                          .tripDetailValue,
                                                      textAlign:
                                                          TextAlign.start,
                                                      maxLines: 1,
                                                    ))
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 20.0,
                                ),
                                Text(
                                  AppTranslations.of(context)
                                      .text("tdp_goods_type"),
                                  style: Styles.tripDetailLabel,
                                  textAlign: TextAlign.start,
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                                Text(
                                  isNullOrEmpty(_tripRequest.otherGoodType)
                                      ? _tripRequest.goodsTypeStr
                                      : _tripRequest.otherGoodType,
                                  style: Styles.tripDetailValue,
                                  textAlign: TextAlign.start,
                                ),
                                SizedBox(
                                  height: 20.0,
                                ),
                                Visibility(
                                    visible: bloc.isEnterpriseUser(),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          translate(context, 'txt_opt_inf')
                                              .toUpperCase(),
                                          style: TextStyle(
                                              fontSize:
                                                  responsiveTextSize(15.0),
                                              color: Color.fromRGBO(
                                                  0, 50, 80, 1.0),
                                              fontFamily: "roboto",
                                              fontWeight: FontWeight.w500),
                                        ),
                                        Visibility(
                                        visible: widget.showDistributor,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: <Widget>[
                                              SizedBox(
                                                height: 10.0,
                                              ),
                                              Text(
                                                localize("lbl_distributor")
                                                    .toUpperCase(),
                                                style: Styles.tripDetailLabel,
                                                textAlign: TextAlign.start,
                                              ),
                                              SizedBox(
                                                height: 5.0,
                                              ),
                                              Text(
                                                isNullOrEmpty(
                                                    _tripRequest.distributorStr)
                                                    ? translate(context, 'tdp_np_lbl')
                                                    : _tripRequest.distributorStr
                                                    .replaceAll('\n', ', '),
                                                style: Styles.tripDetailValue,
                                                textAlign: TextAlign.start,
                                              ),
                                            ],
                                          ),
                                        ),
                                        Visibility(
                                          visible: widget.showProdType,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: <Widget>[
                                              SizedBox(
                                                height: 10.0,
                                              ),
                                              Text(
                                                localize("lbl_prd_type")
                                                    .toUpperCase(),
                                                style: Styles.tripDetailLabel,
                                                textAlign: TextAlign.start,
                                              ),
                                              SizedBox(
                                                height: 5.0,
                                              ),
                                              Text(
                                                isNullOrEmpty(_tripRequest.prodType)
                                                    ? translate(context, 'tdp_np_lbl')
                                                    : _tripRequest.prodType,
                                                style: Styles.tripDetailValue,
                                                textAlign: TextAlign.start,
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10.0,
                                        ),
                                        Text(
                                          AppTranslations.of(context)
                                              .text("lbl_lc_no")
                                              .toUpperCase(),
                                          style: Styles.tripDetailLabel,
                                          textAlign: TextAlign.start,
                                        ),
                                        SizedBox(
                                          height: 5.0,
                                        ),
                                        Text(
                                          isNullOrEmpty(_tripRequest.lcNumber)
                                              ? translate(context, 'tdp_np_lbl')
                                              : _tripRequest.lcNumber,
                                          style: Styles.tripDetailValue,
                                          textAlign: TextAlign.start,
                                        ),
                                        SizedBox(
                                          height: 20.0,
                                        ),
                                      ],
                                    )),
                                Text(
                                  translate(context, 'txt_goods_rec')
                                      .toUpperCase(),
                                  style: TextStyle(
                                      fontSize: responsiveTextSize(15.0),
                                      color: Color.fromRGBO(0, 50, 80, 1.0),
                                      fontFamily: "roboto",
                                      fontWeight: FontWeight.w500),
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Text(
                                  AppTranslations.of(context).text('lbl_name'),
                                  style: Styles.tripDetailLabel,
                                  textAlign: TextAlign.start,
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                                Text(
                                  isNullOrEmpty(_tripRequest.receiverName)
                                      ? AppTranslations.of(context)
                                          .text("tdp_np_lbl")
                                      : _tripRequest.receiverName,
                                  style: Styles.tripDetailValue,
                                  textAlign: TextAlign.start,
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Text(
                                  translate(context, 'lbl_contact'),
                                  style: Styles.tripDetailLabel,
                                  textAlign: TextAlign.start,
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                                Text(
                                  isNullOrEmpty(_tripRequest.receiverNumber)
                                      ? translate(context, 'tdp_np_lbl')
                                      : _tripRequest.receiverNumber,
                                  style: Styles.tripDetailValue,
                                  textAlign: TextAlign.start,
                                ),
                                SizedBox(
                                  height: 20.0,
                                ),
                                Text(
                                  AppTranslations.of(context)
                                      .text("tdp_instruction"),
                                  style: Styles.tripDetailLabel,
                                  textAlign: TextAlign.start,
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                                Text(
                                  _tripRequest.specialInsturctions == null
                                      ? AppTranslations.of(context)
                                          .text("tdp_np_lbl")
                                      : _tripRequest.specialInsturctions.trim(),
                                  style: Styles.tripDetailValue,
                                  textAlign: TextAlign.start,
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                widget.imageFile == null
                                    ? SizedBox(
                                        height: 10.0,
                                      )
                                    : Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            AppTranslations.of(context)
                                                .text("tdp_photo_lbl"),
                                            style: Styles.tripDetailLabel,
                                            textAlign: TextAlign.start,
                                          ),
                                          SizedBox(
                                            height: 10.0,
                                          ),
                                          InkWell(
                                            onTap: () {
                                              navigateNextScreen(
                                                  context,
                                                  FullScreenImage(
                                                    isLocal: true,
                                                    imageUrl:
                                                        widget.imageFile.path,
                                                  ));
                                            },
                                            child: Container(
                                                height: 180.0,
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: Colors.grey),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                4.0))),
                                                child: Container(
                                                  decoration: new BoxDecoration(
                                                    color:
                                                        const Color(0xff7c94b6),
                                                    image: new DecorationImage(
                                                      image: FileImage(
                                                          widget.imageFile),
                                                      fit: BoxFit.cover,
                                                    ),
                                                    borderRadius:
                                                        new BorderRadius.all(
                                                            const Radius
                                                                .circular(4.0)),
                                                  ),
                                                )),
                                          ),
                                        ],
                                      ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  FilledColorButton(
                      buttonText:
                          AppTranslations.of(context).text("tdp_btn_txt"),
                      horizonatalMargin: 20.0,
                      verticalMargin: 15.0,
                      onPressed: () => onCreateTripClick()),
                ],
              )),
        ],
      )
    ];
  }

  onCreateTripClick() {
    FireBaseAnalytics()
        .logEvent(AnalyticsEvents.EVENT_CREATE_TRIP_SUBMIT, null);
    var bloc = Provider.of<TripSummaryBloc>(context, listen: false);
    submitDialog(context, dismissible: false);
    bloc.createTrip(_tripRequest).then((apiRes) {
      Navigator.pop(context);
      _manipulateResponse(bloc, apiRes);
    });
  }

  _manipulateResponse(TripSummaryBloc bloc, ApiResponse apiRes) {
    if (bloc.isApiError(apiRes)) {
      showToast(apiRes.message ?? translate(context, 'something_went_wrong'));
      return;
    }
    showAlertWithDefaultAction(context,
        title: AppTranslations.of(context).text("trip_dlg_ttl"),
        content: localize("trip_dlg_con",
            context: context, dynamicValue: bloc.tripNumber),
        positiveBtnTxt: AppTranslations.of(context).text("txt_ok"),
        callback: () => _navigate());
  }

  setImageAsString() async {
    convertImageToBase64(widget.imageFile).then((value) {
      _tripRequest.image = value;
    });
  }

  void _navigate() async {
    FireBaseAnalytics()
        .logEvent(AnalyticsEvents.EVENT_CREATE_TRIP_SUCCESS, null);
    await navigateNextScreen(context, Home(), shouldFinishPreviousPages: true);
  }
}
