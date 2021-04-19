import 'package:customer/core/localization/AppTranslation.dart';
import 'package:customer/model/bid/bid_detail_response.dart';
import 'package:customer/networking/api_response.dart';
import 'package:customer/styles.dart';
import 'package:customer/ui/bid/bid_detail_bloc.dart';
import 'package:customer/ui/home/homepage.dart';
import 'package:customer/ui/review/driver_reviews_page.dart';
import 'package:customer/ui/review/truck_reviews_page.dart';
import 'package:customer/ui/widget/app_bar.dart';
import 'package:customer/ui/widget/app_button.dart';
import 'package:customer/ui/widget/caller_layout.dart';
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
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

class ViewBidDetailScreen extends StatelessWidget {
  int bidId;

  ViewBidDetailScreen({this.bidId});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<BidDetailBloc>(
      create: (context) => BidDetailBloc(),
      child: ViewBidDetailPage(
        bidId: bidId,
      ),
    );
  }
}

class ViewBidDetailPage extends StatefulWidget {
  int bidId;

  ViewBidDetailPage({this.bidId});

  @override
  _ViewBidDetailPageState createState() => _ViewBidDetailPageState();
}

class _ViewBidDetailPageState extends State<ViewBidDetailPage> {
  BidDetailBloc bloc;
  final scaffoldState = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    bloc = Provider.of<BidDetailBloc>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((callback) {
      bloc.bidId = widget.bidId;
      bloc.getBidDetail();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final truckImageSize =
        responsiveSize((MediaQuery.of(context).size.width - 44) / 4);
    //print(truckImageSize);
    return SafeArea(
      //top: true,
      child: Scaffold(
        key: scaffoldState,
        appBar: AppBarWidget(
          title: translate(context, 'bid_details'),
        ),
        floatingActionButton: CallerWidget(),
        body: Stack(
          children: <Widget>[
            Provider.of<BidDetailBloc>(context).bidDetailResponse == null
                ? Container()
                : Container(
                    color: Colors.white,
                    child: Consumer<BidDetailBloc>(
                      builder: (context, blocModel, _) => Column(
                        children: <Widget>[
                          Divider(
                            thickness: 2,
                            color: ColorResource.divider_color,
                            height: 1,
                          ),
                          Container(
                            width: double.infinity,
                            color: ColorResource.grey_white,
                            child: Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  FittedBox(
                                      child: Text(
                                    blocModel.bidDetailResponse.bidBaseModel
                                        .fleetOwnerName,
                                    style: TextStyle(
                                        fontFamily: 'roboto',
                                        color: ColorResource.colorMarineBlue,
                                        fontSize: responsiveTextSize(22)),
                                  )),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  _buildAmountWidget(context,
                                      blocModel.bidDetailResponse.bidBaseModel)
                                ],
                              ),
                            ),
                          ),
                          Divider(
                            thickness: 2,
                            height: 0,
                            color: ColorResource.divider_color,
                          ),
                          Expanded(
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  _buildDriverSection(
                                      context, blocModel.bidDetailResponse),
                                  Divider(
                                    thickness: 2,
                                    height: 0,
                                    color: ColorResource.divider_color,
                                  ),
                                  _buildTruckSection(
                                      context, blocModel.bidDetailResponse),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 18.0, right: 18.0),
                                    child: FittedBox(
                                      child: Row(
                                        children: <Widget>[
                                          getNetworkImage(context,
                                              size: truckImageSize,
                                              url: blocModel.bidDetailResponse
                                                  .truckImage),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          getNetworkImage(context,
                                              size: truckImageSize,
                                              url: blocModel.bidDetailResponse
                                                  .truckFront),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          getNetworkImage(context,
                                              size: truckImageSize,
                                              url: blocModel.bidDetailResponse
                                                  .truckInner),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          getNetworkImage(context,
                                              size: truckImageSize,
                                              url: blocModel
                                                  .bidDetailResponse.truckBack),
                                        ],
                                      ),
                                    ),
                                  ),
                                  FilledColorButton(
                                      buttonText:
                                          translate(context, 'accept_bid'),
                                      horizonatalMargin: 18,
                                      verticalMargin: 10,
                                      onPressed: () =>
                                          onAcceptBidButtonPressed(blocModel)),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    )),
            showLoader<BidDetailBloc>(bloc)
          ],
        ),
      ),
    );
  }

  onAcceptBidButtonPressed(BidDetailBloc blocModel) async {
    showAlertWithDefaultAction(context,
        title: translate(context, 'accept_bid_dialog_title'),
        positiveBtnTxt: translate(context, 'yes'),
        negativeButtonText: translate(context, 'no'),
        callback: () => callAcceptBidApi(blocModel));
  }

  callAcceptBidApi(BidDetailBloc blocModel) async {
    submitDialog(context, dismissible: true);
    ApiResponse response = await blocModel.placeBid();
    Navigator.pop(context);
    if (!bloc.isApiError(response)) {
      FireBaseAnalytics()
          .logEvent(AnalyticsEvents.EVENT_BID_ACCEPTED,{AnalyticsParams.FLEET_OWNER_NAME: blocModel.bidDetailResponse.fleetOwnerName});
      onSuccessfulBid();
    } else {
      showSnackBar(scaffoldState.currentState, response.message);
    }
  }

  onSuccessfulBid() {
    showAlertWithDefaultAction(context,
        title: translate(context, 'success'),
        content: translate(context, 'accept_bid_success_msg'),
        positiveBtnTxt: translate(context, 'txt_ok'), callback: () {
      navigateNextScreen(context, Home(), shouldFinishPreviousPages: true);
    });
  }
}

_buildTruckSection(context, BidDetailResponse item) {
  return Padding(
    padding: const EdgeInsets.all(18.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 6.0),
                  child: Text(
                    translate(context, 'txt_truck'),
                    style: bidInfoHeaderStyle,
                  ),
                ),
                SizedBox(
                  width: 2,
                ),
                setTrackerImageVisibility(item.bidBaseModel)
              ],
            ),
            Visibility(
              visible: item.truckReviewCount > 0,
              child: GestureDetector(
                onTap: () => navigateNextScreen(
                    context, TruckReviewsScreen(item.truckId)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      translate(context, 'txt_review').toUpperCase(),
                      style: bidInfoHeaderStyle,
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: ColorResource.colorMarineBlue,
                    )
                  ],
                ),
              ),
            )
          ],
        ),
        SizedBox(
          height: 15,
        ),
        isNullOrEmpty(item.truckRegNo)
            ? buildNotProvided(context)
            : FittedBox(
                child: Text(
                item.truckRegNo,
                style: bidTruckInfoStyle,
              )),
        _buildRating(item.bidBaseModel.truckRating, item.truckReviewCount),
        SizedBox(
          height: 15,
        ),
        Text(
          translate(context, 'tdp_type_size_lbl').toUpperCase(),
          style: bidInfoHeaderStyle,
        ),
        FittedBox(
            child:
                isNullOrEmpty(item.truckType) || isNullOrBlank(item.truckSize)
                    ? buildNotProvided(context)
                    : Text(
                        item.getTruckTypeWithSize(),
                        style: bidTruckInfoStyle,
                      )),
        SizedBox(
          height: 15,
        ),
        Text(
          translate(context, 'tdp_truck_dimen').toUpperCase(),
          style: bidInfoHeaderStyle,
        ),
        FittedBox(
            child: setTruckDimension(
                        length: item.truckLength,
                        height: item.truckHeight,
                        width: item.truckWidth) ==
                    translate(context, 'tdp_np_lbl')
                ? buildNotProvided(context)
                : Text(
                    setTruckDimension(
                        length: item.truckLength,
                        height: item.truckHeight,
                        width: item.truckWidth),
                    style: bidTruckInfoStyle,
                  )),
        SizedBox(
          height: 15,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Expanded(
              child: Text(
                translate(context, 'model_year').toUpperCase(),
                style: bidInfoHeaderStyle,
              ),
            ),
            Expanded(
              child: Text(
                translate(context, 'brand').toUpperCase(),
                style: bidInfoHeaderStyle,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Expanded(
              child: isNullOrBlank(item.truckId)
                  ? buildNotProvided(context)
                  : Text(
                      isNullOrEmpty(item.truckYear)
                          ? " "
                          : localize("number_count",
                              dynamicValue: item.truckYear.toString()),
                      style: bidTruckInfoStyle,
                    ),
            ),
            Expanded(
              child: isNullOrBlank(item.truckId)
                  ? buildNotProvided(context)
                  : Text(
                      item.truckBrand,
                      style: bidTruckInfoStyle,
                    ),
            ),
          ],
        )
        /*

        */
      ],
    ),
  );
}

_buildDriverSection(context, BidDetailResponse item) {
  return Padding(
    padding: const EdgeInsets.all(18.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              translate(context, 'txt_driver').toUpperCase(),
              style: bidInfoHeaderStyle,
            ),
            Visibility(
              visible: item.driverReviewCount > 0,
              child: GestureDetector(
                onTap: () => navigateNextScreen(
                    context,
                    DriverReviewsScreen(
                        item.bidBaseModel.driverId,
                        item.bidBaseModel.driverName,
                        item.bidBaseModel.driverRating,
                        item.driverReviewCount)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      translate(context, 'txt_review').toUpperCase(),
                      style: bidInfoHeaderStyle,
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: ColorResource.colorMarineBlue,
                    )
                  ],
                ),
              ),
            )
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          children: <Widget>[
            getCircleImage(
                radius: responsiveSize(40), url: item.bidBaseModel.driverImage),
            Expanded(
              child: Container(
                height: responsiveSize(50),
                margin: EdgeInsets.only(left: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    FittedBox(
                      child: Text(
                          isNullOrEmpty(item.bidBaseModel.driverName)
                              ? translate(context, 'tdp_np_lbl')
                              : item.bidBaseModel.driverName,
                          textAlign: TextAlign.left,
                          maxLines: 1,
                          style: TextStyle(
                              color: ColorResource.colorMarineBlue,
                              fontSize: responsiveTextSize(20),
                              fontFamily: 'roboto')),
                    ),
                    _buildRating(
                        item.bidBaseModel.driverRating, item.driverReviewCount),
                  ],
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 15,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              translate(context, 'license_number').toUpperCase(),
              style: bidInfoHeaderStyle,
            ),
            Text(
              translate(context, 'expiry_date').toUpperCase(),
              style: bidInfoHeaderStyle,
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            isNullOrEmpty(item.bidBaseModel.driverName)
                ? buildNotProvided(context)
                : Text(
                    item.driverLicenceNo,
                    style: bidInfoStyle,
                  ),
            isNullOrEmpty(item.bidBaseModel.driverName)
                ? buildNotProvided(context)
                : Text(
                    getFormattedDate(item.driverLicenceNoExpiryDate,
                        originalFormat: 'yyyy-MM-dd',
                        localization: languageCode()),
                    style: bidInfoStyle,
                  )
          ],
        )
      ],
    ),
  );
}

_buildAmountWidget(context, BidDetail item) {
  var bidAmount = RichText(
    textAlign: TextAlign.center,
    text: TextSpan(
      style: DefaultTextStyle.of(context).style,
      children: <TextSpan>[
        TextSpan(
            text: translate(context, "bid").toUpperCase() + " ",
            style: Styles.totalTextStyle),
        TextSpan(
            text: '${amountWithCurrencySign(item.totalAmount)}',
            style: Styles.amountTextStyle)
      ],
    ),
  );
  var advanceAmount = RichText(
    textAlign: TextAlign.center,
    text: TextSpan(
      text: "",
      style: DefaultTextStyle.of(context).style,
      children: <TextSpan>[
        TextSpan(
            text: translate(context, "txt_adv") + " ",
            style: Styles.bookingDetailLabel),
        TextSpan(
            text: '${amountWithCurrencySign(item.advanceAmount)}',
            style: Styles.blueBigTextBold),
      ],
    ),
  );
  return Column(
    children: <Widget>[
      bidAmount,
      SizedBox(
        height: 5,
      ),
      advanceAmount
    ],
  );
}

_buildRating(rating, ratingCount) {
  return isNullOrEmpty(rating) ? Container():
  Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: <Widget>[
      RatingBarIndicator(
        itemCount: 5,
        rating: double.parse(rating ?? '5'),
        itemBuilder: (context, index) => Icon(
          Icons.star,
          color: isNullOrEmpty(rating)
              ? ColorResource.marigoldAlpha
              : ColorResource.colorMariGold,
        ),
        itemSize: responsiveSize(18),
      ),
      SizedBox(
        width: 5,
      ),
      Text(
        localize(
                isNullOrEmpty(rating) ? 'number_count' : 'number_decimal_count',
                dynamicValue: (rating ?? '0').toString(),
                symbol: isNullOrEmpty(rating) ? "%d" : "%f") +
            localize('number_count_bracket',
                dynamicValue: ratingCount.toString()),
        style: TextStyle(
            fontSize: responsiveTextSize(14),
            fontFamily: 'roboto',
            fontWeight: FontWeight.w500,
            color: ColorResource.colorMarineBlue),
      )
    ],
  );
}

TextStyle bidInfoHeaderStyle = TextStyle(
  color: ColorResource.colorMarineBlue,
  fontSize: responsiveTextSize(15),
  fontFamily: "roboto",
  fontWeight: FontWeight.w700,
);

TextStyle bidInfoStyle = TextStyle(
  color: ColorResource.colorMarineBlue,
  fontSize: responsiveTextSize(15),
  fontFamily: "roboto",
  fontWeight: FontWeight.w400,
);

TextStyle bidTruckInfoStyle = TextStyle(
  color: ColorResource.colorMarineBlue,
  fontSize: responsiveTextSize(20),
  fontFamily: "roboto",
  fontWeight: FontWeight.w400,
);

buildNotProvided(context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: <Widget>[
      Text(
        translate(context, 'tdp_np_lbl'),
        style: TextStyle(
            fontSize: responsiveTextSize(16),
            fontFamily: 'roboto',
            fontWeight: FontWeight.w300,
            color: ColorResource.colorBlack),
      )
    ],
  );
}
