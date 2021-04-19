import 'package:customer/core/localization/AppTranslation.dart';
import 'package:customer/styles.dart';
import 'package:customer/ui/widget/app_bar.dart';
import 'package:customer/ui/widget/base_widget.dart';
import 'package:customer/ui/widget/caller_layout.dart';
import 'package:customer/ui/widget/map_img_widget.dart';
import 'package:customer/utils/app_data_ui_utils.dart';
import 'package:customer/utils/common_utils.dart';
import 'package:customer/utils/date_time_utils.dart';
import 'package:customer/utils/screen_dimension_utils.dart';
import 'package:customer/utils/ui_constant.dart';
import 'package:customer/utils/ui_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:screenshot/screenshot.dart';
import 'bloc/receipt_bloc.dart';
import 'package:wc_flutter_share/wc_flutter_share.dart';

class ViewReceiptScreen extends StatelessWidget {
  final int tripId;

  ViewReceiptScreen(this.tripId);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ReceiptBloc>(create: (_) => ReceiptBloc()),
      ],
      child: ViewReceiptPage(tripId),
    );
  }
}

class ViewReceiptPage extends StatefulWidget {
  final ScreenshotController screenshotController = ScreenshotController();
  final int tripId;

  ViewReceiptPage(this.tripId);

  @override
  _ViewReceiptState createState() => _ViewReceiptState();
}

class _ViewReceiptState
    extends BasePageWidgetState<ViewReceiptPage, ReceiptBloc> {
  @override
  onBuildCompleted() {
    if (mounted) bloc.getTripDetail(widget.tripId);
  }

  @override
  PreferredSizeWidget getAppbar() => AppBarWidget(
        title: translate(context, "receipt_head_ttl"),
        shouldShowBackButton: true,
        action: <Widget>[
          Center(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 0.0),
              child: IconButton(
                  icon: Icon(
                    CupertinoIcons.share,
                    color: ColorResource.colorMarineBlue,
                    size: responsiveSize(20.0),
                  ),
                  onPressed: () {
                    widget.screenshotController.capture(pixelRatio: 1.5).then((file) async {
                      await WcFlutterShare.share(
                          sharePopupTitle: 'Share',
                          subject: translate(context, 'vrp_rrg'),
                          text: translate(context, 'vrp_tug'),
                          fileName:
                              'GIM_Receipt_TripNo_${widget.tripId}_${DateFormat("d_MMM_y").format(DateTime.now())}.png',
                          mimeType: 'image/png',
                          bytesOfFile: file.readAsBytesSync());
                    });
                  }),
            ),
          )
        ],
      );

  @override
  getFloatingActionButton() => CallerWidget(autoAlignment: false);

  @override
  List<Widget> getPageWidget() {
    return [
      Consumer<ReceiptBloc>(
        builder: (context, bloc, _) => Stack(
          children: <Widget>[
            bloc.bookingDetail == null
                ? Container()
                : Container(
                    child: SingleChildScrollView(
                        child: Screenshot(
                            controller: widget.screenshotController,
                            child: Container(
                                color: ColorResource.colorWhite,
                                width: MediaQuery.of(context).size.width,
                                child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      MapImage(
                                          imageUrl: bloc.bookingDetail
                                              .staticMapPhotoTwoEighty),
                                      Container(
                                        margin: EdgeInsets.fromLTRB(
                                            20.0, 10.0, 20.0, 10.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          children: <Widget>[
                                            Row(children: [
                                              Text(
                                                translate(context,
                                                            'txt_trip_no')
                                                        .toUpperCase() +
                                                    localize('number_count',
                                                        dynamicValue: bloc
                                                            .bookingDetail
                                                            .tripNumber
                                                            .toString()),
                                                style: Styles.tripNoStyle,
                                              ),
                                              setDistributorTagVisibility(
                                                  bloc.bookingDetail,
                                                  iconSize: 20.0)
                                            ]),
                                            SizedBox(
                                              height: 10.0,
                                            ),
                                            Text(
                                              translate(context, 'txt_customer')
                                                  .toUpperCase(),
                                              style: Styles.blueSmallTextBold,
                                            ),
                                            Text(
                                              bloc.bookingDetail.customerName,
                                              style: Styles.txtStyleBlackNormal,
                                            ),
                                            SizedBox(
                                              height: 10.0,
                                            ),
                                            Text(
                                              translate(context, 'lbl_partner')
                                                  .toUpperCase(),
                                              style: Styles.blueSmallTextBold,
                                            ),
                                            Text(
                                              bloc.bookingDetail.fleetOwnerName,
                                              style: Styles.txtStyleBlackNormal,
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        color: ColorResource.lightBlue,
                                        child: Padding(
                                          padding: const EdgeInsets.all(
                                              DimensionResource.hPad),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Row(
                                                children: <Widget>[
                                                  Center(
                                                      child: Image.asset(
                                                    "images/pickup_pin.png",
                                                    height: responsiveSize(24),
                                                    width: responsiveSize(18),
                                                  )),
                                                  Expanded(
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 10.0),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: <Widget>[
                                                          Row(
                                                            children: <Widget>[
                                                              Text(
                                                                translate(
                                                                    context,
                                                                    "tdp_pick_lbl"),
                                                                style:
                                                                    TextStyle(
                                                                  color: ColorResource
                                                                      .colorMarineBlue,
                                                                  fontSize:
                                                                      responsiveDefaultTextSize(),
                                                                  fontFamily:
                                                                      "roboto",
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700,
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                width: 4.0,
                                                              ),
                                                              Text(
                                                                convertTimestampToDateTime(
                                                                    timestamp: bloc
                                                                        .bookingDetail
                                                                        .startDateTime),
                                                                style:
                                                                    TextStyle(
                                                                  color: ColorResource
                                                                      .colorMarineBlue,
                                                                  fontSize:
                                                                      responsiveDefaultTextSize(),
                                                                  fontFamily:
                                                                      "roboto",
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w300,
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            height: 2.0,
                                                          ),
                                                          Text(
                                                            bloc.bookingDetail
                                                                .pickupAddress,
                                                            style: Styles
                                                                .tripDetailAddress,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                              Container(
                                                alignment: Alignment.topLeft,
                                                height: responsiveSize(30.0),
                                                width: 1.0,
                                                color: Colors.grey,
                                                margin: getResponsiveDimension(
                                                    const EdgeInsets.only(
                                                        left: 8.0, right: 8.0)),
                                              ),
                                              Row(
                                                children: <Widget>[
                                                  Center(
                                                      child: Image.asset(
                                                    "images/dropoff_pin.png",
                                                    height: responsiveSize(24),
                                                    width: responsiveSize(18),
                                                  )),
                                                  Expanded(
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 10.0),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: <Widget>[
                                                          Row(
                                                            children: <Widget>[
                                                              Text(
                                                                  translate(
                                                                      context,
                                                                      "tdp_drop_lbl"),
                                                                  style:
                                                                      TextStyle(
                                                                    color: Color
                                                                        .fromRGBO(
                                                                            96,
                                                                            154,
                                                                            186,
                                                                            1.0),
                                                                    fontSize:
                                                                        responsiveDefaultTextSize(),
                                                                    fontFamily:
                                                                        "roboto",
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w700,
                                                                  )),
                                                              /*SizedBox(
                                                                width: 4.0,
                                                              ),
                                                              Text(
                                                                convertTimestampToDateTime(
                                                                    timestamp: bloc
                                                                        .bookingDetail
                                                                        .dropOffDateTime),
                                                                style:
                                                                    TextStyle(
                                                                  color: ColorResource
                                                                      .colorMarineBlue,
                                                                  fontSize:
                                                                      responsiveDefaultTextSize(),
                                                                  fontFamily:
                                                                      "roboto",
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w300,
                                                                ),
                                                              )*/
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            height: 2.0,
                                                          ),
                                                          Text(
                                                            bloc.bookingDetail
                                                                .dropoffAddress,
                                                            style: Styles
                                                                .tripDetailAddress,
                                                            softWrap: true,
                                                            maxLines: 2,
                                                            textAlign:
                                                                TextAlign.start,
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
                                      ),
                                      Container(
                                        margin: EdgeInsets.fromLTRB(
                                            20.0, 20.0, 20.0, 10.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          children: <Widget>[
                                            Text(
                                              translate(context, 'txt_trk_asg')
                                                  .toUpperCase(),
                                              style: Styles.blueSmallTextBold,
                                            ),
                                            SizedBox(
                                              height: 3.0,
                                            ),
                                            Text(
                                              bloc.bookingDetail.truckRegNo,
                                              style: Styles.txtStyleBlackNormal,
                                            ),
                                            SizedBox(
                                              height: 10.0,
                                            ),
                                            Row(
                                              children: <Widget>[
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: <Widget>[
                                                      Text(
                                                        translate(context,
                                                            "txt_trk_typ"),
                                                        style: Styles
                                                            .blueSmallTextBold,
                                                        textAlign:
                                                            TextAlign.start,
                                                      ),
                                                      SizedBox(
                                                        height: 3.0,
                                                      ),
                                                      Text(
                                                        bloc.bookingDetail
                                                            .truckType,
                                                        style: Styles
                                                            .txtStyleBlackNormal,
                                                        textAlign:
                                                            TextAlign.start,
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 8.0),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: <Widget>[
                                                        Text(
                                                          translate(context,
                                                              "txt_trk_size"),
                                                          style: Styles
                                                              .blueSmallTextBold,
                                                          textAlign:
                                                              TextAlign.start,
                                                        ),
                                                        SizedBox(
                                                          height: 3.0,
                                                        ),
                                                        Text(
                                                          localize(
                                                              'number_decimal_count',
                                                              dynamicValue: bloc
                                                                      .bookingDetail
                                                                      .partnerTruckSize
                                                                      .toString() ??
                                                                  "0.0",
                                                              symbol: "%f"),
                                                          style: Styles
                                                              .txtStyleBlackNormal,
                                                          textAlign:
                                                              TextAlign.start,
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      Divider(),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 20.0,
                                            top: 10.0,
                                            right: 20.0,
                                            bottom: 10.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          children: <Widget>[
                                            Text(
                                              translate(context, 'txt_drv_asg')
                                                  .toUpperCase(),
                                              style: Styles.blueSmallTextBold,
                                            ),
                                            SizedBox(
                                              height: 3.0,
                                            ),
                                            Text(
                                              bloc.bookingDetail.driverName,
                                              style: Styles.txtStyleBlackNormal,
                                            ),
                                          ],
                                        ),
                                      ),
                                      Divider(),
                                      Container(
                                        margin: EdgeInsets.fromLTRB(
                                            20.0, 10.0, 20.0, 10.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          children: <Widget>[
                                            Text(
                                              translate(context, 'vrp_yft'),
                                              style: TextStyle(
                                                  fontSize:
                                                      responsiveTextSize(16.0),
                                                  fontFamily: 'roboto',
                                                  fontWeight: FontWeight.w900,
                                                  color: ColorResource
                                                      .colorMariGold),
                                            ),
                                            Divider(),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 6.0, bottom: 6.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: <Widget>[
                                                  Text(
                                                    translate(
                                                        context, 'vrp_ytb'),
                                                    style: TextStyle(
                                                        fontSize:
                                                            responsiveDefaultTextSize(),
                                                        fontFamily: 'roboto',
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: ColorResource
                                                            .colorMarineBlue),
                                                  ),
                                                  Text(
                                                    amountWithCurrencySign(bloc
                                                        .bookingDetail
                                                        .bidAmount),
                                                    style: TextStyle(
                                                        fontSize:
                                                            responsiveDefaultTextSize(),
                                                        fontFamily: 'roboto',
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: ColorResource
                                                            .colorMarineBlue),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Divider(),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 6.0, bottom: 6.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: <Widget>[
                                                  Text(
                                                    translate(
                                                        context, 'txt_adv'),
                                                    style: TextStyle(
                                                        fontSize:
                                                            responsiveDefaultTextSize(),
                                                        fontFamily: 'roboto',
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: Color.fromRGBO(
                                                            114,
                                                            114,
                                                            114,
                                                            1.0)),
                                                  ),
                                                  Text(
                                                    amountWithCurrencySign(bloc
                                                        .bookingDetail.advance),
                                                    style: TextStyle(
                                                        fontSize:
                                                            responsiveDefaultTextSize(),
                                                        fontFamily: 'roboto',
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: Color.fromRGBO(
                                                            114,
                                                            114,
                                                            114,
                                                            1.0)),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Divider(),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 6.0, bottom: 6.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: <Widget>[
                                                  Text(
                                                    translate(
                                                        context, 'vrp_pat'),
                                                    style: TextStyle(
                                                        fontSize:
                                                            responsiveDefaultTextSize(),
                                                        fontFamily: 'roboto',
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: Color.fromRGBO(
                                                            114,
                                                            114,
                                                            114,
                                                            1.0)),
                                                  ),
                                                  Text(
                                                    (amountWithCurrencySign(bloc
                                                            .bookingDetail
                                                            .bidAmount -
                                                        bloc.bookingDetail
                                                            .advance)),
                                                    style: TextStyle(
                                                        fontSize:
                                                            responsiveDefaultTextSize(),
                                                        fontFamily: 'roboto',
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: Color.fromRGBO(
                                                            114,
                                                            114,
                                                            114,
                                                            1.0)),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Divider(),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 6.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: <Widget>[
                                                  Text(
                                                    translate(
                                                        context, 'vrp_tpa'),
                                                    style: TextStyle(
                                                        fontSize:
                                                            responsiveDefaultTextSize(),
                                                        fontFamily: 'roboto',
                                                        fontWeight:
                                                            FontWeight.w900,
                                                        color: ColorResource
                                                            .colorMarineBlue),
                                                  ),
                                                  Text(
                                                    (amountWithCurrencySign(bloc
                                                        .bookingDetail
                                                        .bidAmount)),
                                                    style: TextStyle(
                                                        fontSize:
                                                            responsiveSize(
                                                                18.0),
                                                        fontFamily: 'roboto',
                                                        fontWeight:
                                                            FontWeight.w900,
                                                        color: ColorResource
                                                            .colorMarineBlue),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20.0,
                                      ),
                                      Container(
                                        padding: EdgeInsets.all(20.0),
                                        height: responsiveSize(106.0),
                                        color: ColorResource.colorMarineBlue,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Stack(
                                              children: <Widget>[
                                                Center(
                                                    child: Image.asset(
                                                  "images/logo_tsp.png",
                                                )),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    Text(
                                                      translate(
                                                          context, 'contact'),
                                                      style: TextStyle(
                                                          fontSize:
                                                              responsiveTextSize(
                                                                  16.0),
                                                          fontFamily: 'roboto',
                                                          fontWeight:
                                                              FontWeight.w300,
                                                          color: ColorResource
                                                              .colorMariGold),
                                                    ),
                                                    Text(
                                                      translate(
                                                          context, 'vrp_cfs'),
                                                      style: TextStyle(
                                                          fontSize:
                                                              responsiveTextSize(
                                                                  12.0),
                                                          fontFamily: 'roboto',
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color: ColorResource
                                                              .light_white),
                                                    ),
                                                    GestureDetector(
                                                      onTap: () {
                                                        call('tel:${translate(context, 'txt_apl_no')}');
                                                      },
                                                      child: Text(
                                                        translate(context,
                                                            'txt_apl_no'),
                                                        style: TextStyle(
                                                            fontSize:
                                                                responsiveTextSize(
                                                                    12.00),
                                                            fontFamily:
                                                                'roboto',
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            color: ColorResource
                                                                .light_white),
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                            Center(
                                                child: Image.asset(
                                              "images/logo_text.png",
                                            )),
                                          ],
                                        ),
                                      )
                                    ]))))),
            showLoader<ReceiptBloc>(bloc),
          ],
        ),
      )
    ];
  }
}
