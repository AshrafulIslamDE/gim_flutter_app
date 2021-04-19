import 'package:auto_size_text/auto_size_text.dart';
import 'package:customer/core/localization/AppTranslation.dart';
import 'package:customer/networking/api_response.dart';
import 'package:customer/styles.dart';
import 'package:customer/ui/widget/app_bar.dart';
import 'package:customer/ui/widget/app_button.dart';
import 'package:customer/ui/widget/base_widget.dart';
import 'package:customer/ui/widget/caller_layout.dart';
import 'package:customer/utils/app_data_ui_utils.dart';
import 'package:customer/utils/common_utils.dart';
import 'package:customer/utils/date_time_utils.dart';
import 'package:customer/utils/image_utils.dart';
import 'package:customer/utils/screen_dimension_utils.dart';
import 'package:customer/utils/ui_constant.dart';
import 'package:customer/utils/ui_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'bloc/trip_detail_bloc.dart';

class TripDetailPageContainer extends StatelessWidget {
  final int tripId;
  final bool isCancellable;

  TripDetailPageContainer({this.tripId, this.isCancellable = false});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<TripDetailBloc>(create: (_) => TripDetailBloc()),
      ],
      child: TripDetailPage(
        tripId: tripId,
        isCancellable: isCancellable,
      ),
    );
  }
}

class TripDetailPage extends StatefulWidget {
  final int tripId;
  final bool isCancellable;

  TripDetailPage({this.tripId, this.isCancellable});

  @override
  TripDetailPageState createState() => TripDetailPageState();
}

class TripDetailPageState
    extends BasePageWidgetState<TripDetailPage, TripDetailBloc> {
  @override
  onBuildCompleted() {
    if (mounted) _getTripDetail();
  }

  @override
  PreferredSizeWidget getAppbar() => AppBarWidget(
        title: translate(context, "tdp_hdr_lbl"),
        shouldShowBackButton: true,
      );

  @override
  getFloatingActionButton() => CallerWidget(autoAlignment: false);

  @override
  List<Widget> getPageWidget() {
    return [
      Consumer<TripDetailBloc>(
        builder: (context, bloc, _) => Stack(
          children: <Widget>[
            bloc.tripDetail == null
                ? Container()
                : Column(
                    children: <Widget>[
                      Expanded(
                          child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              color: ColorResource.lightBlue,
                              child: Padding(
                                padding: const EdgeInsets.all(
                                    DimensionResource.hPad),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Center(
                                            child: Image.asset(
                                          "images/pickuparrow.png",
                                          height: responsiveSize(24),
                                          width: responsiveSize(18),
                                        )),
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Row(children: [
                                                  Text(
                                                    translate(context,
                                                                'txt_trip_no')
                                                            .toUpperCase() +
                                                        translate(context,
                                                            'number_count',
                                                            dynamicValue: bloc
                                                                .tripDetail
                                                                .tripNumber
                                                                .toString()),
                                                    style: Styles.tripNoStyle,
                                                  ),
                                                  setDistributorTagVisibility(
                                                      bloc.tripDetail)
                                                ]),
                                                SizedBox(
                                                  height: 3.0,
                                                ),
                                                Row(
                                                  children: <Widget>[
                                                    Text(
                                                      AppTranslations.of(
                                                              context)
                                                          .text("tdp_pick_lbl"),
                                                      style: TextStyle(
                                                        color: ColorResource
                                                            .colorMarineBlue,
                                                        fontSize:
                                                            responsiveDefaultTextSize(),
                                                        fontFamily: "roboto",
                                                        fontWeight:
                                                            FontWeight.w700,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 4.0,
                                                    ),
                                                    Text(
                                                      convertTimestampToDateTime(
                                                          timestamp: bloc
                                                              .tripDetail
                                                              .pickupDateTimeUtc),
                                                      style: TextStyle(
                                                        color: ColorResource
                                                            .colorMarineBlue,
                                                        fontSize:
                                                            responsiveDefaultTextSize(),
                                                        fontFamily: "roboto",
                                                        fontWeight:
                                                            FontWeight.w300,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 2.0,
                                                ),
                                                Text(
                                                  bloc.tripDetail.pickupAddress,
                                                  style:
                                                      Styles.tripDetailAddress,
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
                                          height: responsiveSize(24),
                                          width: responsiveSize(18),
                                        )),
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10.0),
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
                                                          responsiveDefaultTextSize(),
                                                      fontFamily: "roboto",
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    )),
                                                SizedBox(
                                                  height: 2.0,
                                                ),
                                                Text(
                                                  bloc.tripDetail
                                                      .dropoffAddress,
                                                  style:
                                                      Styles.tripDetailAddress,
                                                  softWrap: true,
                                                  maxLines: 2,
                                                  textAlign: TextAlign.start,
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
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    AppTranslations.of(context)
                                        .text("tdp_type_size_lbl"),
                                    style: Styles.tripDetailLabel,
                                    textAlign: TextAlign.start,
                                  ),
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                  Text(
                                    bloc.tripDetail.getTruckTypeWithSize(),
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
                                            AppTranslations.of(context).text(
                                                bloc.tripDetail.paymentType
                                                    .toLowerCase()),
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
                                              AutoSizeText(
                                                setTruckDimension(
                                                    length: bloc
                                                        .tripDetail.truckLength,
                                                    width: bloc
                                                        .tripDetail.truckWidth,
                                                    height: bloc.tripDetail
                                                        .truckHeight),
                                                style: Styles.tripDetailValue,
                                                textAlign: TextAlign.start,
                                                maxLines: 1,
                                              )
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
                                    isNullOrEmpty(
                                            bloc.tripDetail.otherGoodsType)
                                        ? bloc.tripDetail.goodsType
                                        : bloc.tripDetail.otherGoodsType,
                                    style: Styles.tripDetailValue,
                                    textAlign: TextAlign.start,
                                  ),
                                  SizedBox(
                                    height: 20.0,
                                  ),
                                  bloc.isEnterpriseUser()
                                      ? Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            _distributorInfo(),
                                            _optionalInfo()
                                          ],
                                        )
                                      : Container(),
                                  _goodsReceiverInfo(),
                                  Visibility(
                                    visible: !isNullOrEmpty(
                                        bloc.tripDetail.specialInsturctions),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
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
                                          bloc.tripDetail.specialInsturctions ??
                                              '',
                                          style: Styles.tripDetailValue,
                                          textAlign: TextAlign.start,
                                        ),
                                        SizedBox(
                                          height: 20.0,
                                        ),
                                      ],
                                    ),
                                  ),
                                  bloc.tripDetail.image == null
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
                                            Container(
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
                                                    borderRadius:
                                                        new BorderRadius.all(
                                                            const Radius
                                                                .circular(4.0)),
                                                  ),
                                                  child: Stack(
                                                      fit: StackFit.loose,
                                                      children: [
                                                        AspectRatio(
                                                          aspectRatio: 16 / 8,
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(1.0),
                                                            child: getNetworkImage(
                                                                context,
                                                                size: 180.0,
                                                                url: bloc
                                                                    .tripDetail
                                                                    .image),
                                                          ),
                                                        )
                                                      ]),
                                                )),
                                          ],
                                        ),
                                  SizedBox(
                                    height: 20.0,
                                  ),
                                  Visibility(
                                    visible: widget.isCancellable,
                                    child: FilledColorButton(
                                      buttonText: AppTranslations.of(context)
                                          .text("txt_cancel_trip"),
                                      onPressed: () {
                                        _showConfirmationDialog();
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ))
                    ],
                  ),
          ],
        ),
      )
    ];
  }

  _distributorInfo() {
    var isCompanyNameNull =
        isNullOrEmpty(bloc.tripDetail.distributorCompanyName);
    var isDistContactNull =
        isNullOrEmpty(bloc.tripDetail.distributorMobileNumber);
    return (isCompanyNameNull && isDistContactNull)
        ? Container()
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                translate(context, 'lbl_dist_info').toUpperCase(),
                style: TextStyle(
                    fontSize: responsiveTextSize(15.0),
                    color: Color.fromRGBO(0, 50, 80, 1.0),
                    fontFamily: "roboto",
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 10.0,
              ),
              isCompanyNameNull
                  ? Container()
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          localize("lbl_dist_name").toUpperCase(),
                          style: Styles.tripDetailLabel,
                          textAlign: TextAlign.start,
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Text(
                          bloc.tripDetail.distributorCompanyName,
                          style: Styles.tripDetailValue,
                          textAlign: TextAlign.start,
                        ),
                        SizedBox(
                          height: 10.0,
                        )
                      ],
                    ),
              isDistContactNull
                  ? Container()
                  : Column(
                      children: [
                        Text(
                          localize("lbl_dist_ph").toUpperCase(),
                          style: Styles.tripDetailLabel,
                          textAlign: TextAlign.start,
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Text(
                          bloc.tripDetail.distributorMobileNumber,
                          style: Styles.tripDetailValue,
                          textAlign: TextAlign.start,
                        ),
                        SizedBox(
                          height: responsiveSize(15.0),
                        )
                      ],
                    ),
            ],
          );
  }

  _optionalInfo() {
    var isLcNoNull = isNullOrEmpty(bloc.tripDetail.lcNumber);
    var isProdNull = isNullOrEmpty(bloc.tripDetail.productType);
    return (isLcNoNull && isProdNull)
        ? Container()
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                translate(context, 'txt_opt_inf').toUpperCase(),
                style: TextStyle(
                    fontSize: responsiveTextSize(15.0),
                    color: Color.fromRGBO(0, 50, 80, 1.0),
                    fontFamily: "roboto",
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 10.0,
              ),
              isProdNull
                  ? Container()
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          localize("lbl_prd_type").toUpperCase(),
                          style: Styles.tripDetailLabel,
                          textAlign: TextAlign.start,
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Text(
                          bloc.tripDetail.productType,
                          style: Styles.tripDetailValue,
                          textAlign: TextAlign.start,
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                      ],
                    ),
              isLcNoNull
                  ? Container()
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
                          bloc.tripDetail.lcNumber,
                          style: Styles.tripDetailValue,
                          textAlign: TextAlign.start,
                        ),
                        SizedBox(
                          height: 20.0,
                        )
                      ],
                    )
            ],
          );
  }

  _goodsReceiverInfo() {
    var isRecNameNull = isNullOrEmpty(bloc.tripDetail.receiverName);
    var isRecContNull = isNullOrEmpty(bloc.tripDetail.receiverNumber);
    return (isRecNameNull && isRecContNull)
        ? Container()
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                translate(context, 'txt_goods_rec').toUpperCase(),
                style: TextStyle(
                    fontSize: responsiveTextSize(15.0),
                    color: Color.fromRGBO(0, 50, 80, 1.0),
                    fontFamily: "roboto",
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 10.0,
              ),
              isRecNameNull
                  ? Container()
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppTranslations.of(context).text('lbl_name'),
                          style: Styles.tripDetailLabel,
                          textAlign: TextAlign.start,
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Text(
                          bloc.tripDetail.receiverName,
                          style: Styles.tripDetailValue,
                          textAlign: TextAlign.start,
                        ),
                        SizedBox(
                          height: 10.0,
                        )
                      ],
                    ),
              isRecContNull
                  ? Container()
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          translate(context, 'lbl_contact'),
                          style: Styles.tripDetailLabel,
                          textAlign: TextAlign.start,
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Text(
                          bloc.tripDetail.receiverNumber,
                          style: Styles.tripDetailValue,
                          textAlign: TextAlign.start,
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                      ],
                    ),
            ],
          );
  }

  _manipulateResponse(ApiResponse response, Function callback) {
    if (bloc.isApiError(response)) {
      showSnackBar(scaffoldState.currentState,
          response.message ?? translate(context, 'something_went_wrong'));
      return;
    }
    callback == null
        ? (response.message != null && response.message.isNotEmpty)
            ? showSnackBar(scaffoldState.currentState, response.message)
            : print("")
        : callback();
  }

  _getTripDetail() {
    submitDialog(context, dismissible: false);
    bloc.getTripDetail(widget.tripId).then((apiResponse) {
      Navigator.pop(context);
      _manipulateResponse(apiResponse, null);
    });
  }

  _showConfirmationDialog() {
    onAlertWithTitlePress(
        context,
        translate(context, 'cancel_trip_dlg_ttl'),
        null,
        translate(context, 'yes').toUpperCase(),
        translate(context, 'no').toUpperCase(),
        _cancelTrip);
  }

  _alertUser() {
    showAlertWithDefaultAction(context,
        title: translate(context, "can_trip_dlg_ttl"),
        positiveBtnTxt: translate(context, "txt_ok"), callback: () {
      Navigator.pop(context, true);
    });
  }

  _cancelTrip() async {
    submitDialog(context, dismissible: false);
    var apiResponse = await bloc.cancelTrip(widget.tripId);
    Navigator.pop(context);
    _manipulateResponse(apiResponse, _alertUser);
  }
}
