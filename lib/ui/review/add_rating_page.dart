import 'package:auto_size_text/auto_size_text.dart';
import 'package:customer/core/localization/AppTranslation.dart';
import 'package:customer/networking/api_response.dart';
import 'package:customer/ui/review/bloc/add_review_bloc.dart';
import 'package:customer/ui/widget/app_bar.dart';
import 'package:customer/ui/widget/app_button.dart';
import 'package:customer/ui/widget/auto_float_label_widget.dart';
import 'package:customer/ui/widget/base_widget.dart';
import 'package:customer/ui/widget/caller_layout.dart';
import 'package:customer/ui/widget/review_img_picker.dart';
import 'package:customer/ui/widget/trip_address_widget.dart';
import 'package:customer/utils/analytics.dart';
import 'package:customer/utils/firebase_analytics_utils.dart';
import 'package:customer/utils/image_utils.dart';
import 'package:customer/utils/screen_dimension_utils.dart';
import 'package:customer/utils/ui_constant.dart';
import 'package:customer/utils/ui_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

class AddARatingScreen extends StatelessWidget {
  final int tripId;

  AddARatingScreen(this.tripId);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AddReviewBloc>(create: (_) => AddReviewBloc()),
      ],
      child: AddARatingPage(tripId),
    );
  }
}

class AddARatingPage extends StatefulWidget {
  final int tripId;

  AddARatingPage(this.tripId);

  @override
  _AddARatingState createState() => _AddARatingState();
}

class _AddARatingState
    extends BasePageWidgetState<AddARatingPage, AddReviewBloc> {
  var driverReviewController = TextEditingController();
  var truckReviewController = TextEditingController();

  @override
  onBuildCompleted() {
    if (mounted) bloc.getTripDetail(widget.tripId);
  }

  @override
  PreferredSizeWidget getAppbar() => AppBarWidget(
        title: translate(context, "ttl_ad_rating"),
        shouldShowBackButton: true,
      );

  @override
  getFloatingActionButton() => CallerWidget(autoAlignment: false);

  @override
  List<Widget> getPageWidget() {
    return [
      Consumer<AddReviewBloc>(
        builder: (context, bloc, _) => Stack(
          children: <Widget>[
            bloc.bookingDetail == null
                ? Container()
                : Container(
                    color: Colors.white,
                    child: SingleChildScrollView(
                        child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        AddressWidget(
                          tripItem: bloc.bookingDetail,
                        ),
                        Container(
                          padding: EdgeInsets.all(18.0),
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(bottom: 10.0),
                                child: Text(
                                  translate(context, 'rtg_lbl_drv'),
                                  style: TextStyle(
                                      fontFamily: "roboto", fontSize: responsiveTextSize(16.0)),
                                ),
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  getCircleImage(
                                      radius: 50,
                                      url: bloc.bookingDetail?.driverImageUrl),
                                  Expanded(
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(left: 10.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          AutoSizeText(
                                            bloc.bookingDetail.driverName,
                                            maxLines: 1,
                                            style: TextStyle(
                                                fontSize: responsiveTextSize(22.0),
                                                fontFamily: 'roboto',
                                                fontWeight: FontWeight.w500,
                                                color: ColorResource
                                                    .colorMarineBlue),
                                          ),
                                          RatingBar.builder(
                                            initialRating: 5,
                                            allowHalfRating: false,
                                            itemBuilder: (context, _) => Icon(
                                              Icons.star,
                                              color:
                                                  ColorResource.colorMariGold,
                                            ),
                                            onRatingUpdate: bloc.rateDriver,
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 4.0,
                              ),
                              AutoFloatLabelTextField(
                                driverReviewController,
                                readOnly: false,
                                isDrop: false,
                                labelText: AppTranslations.of(context)
                                    .text("lbl_driver_rev"),
                                maxLines: 5,
                                hintText: AppTranslations.of(context)
                                    .text("hint_driver_rev"),
                                maxLength: 250,
                                callback: bloc.leaveDriverReview,
                                text: bloc.driverReview,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 10.0),
                                child: Text(
                                  translate(context, 'rtg_lbl_truck'),
                                  style: TextStyle(
                                      fontFamily: "roboto", fontSize: responsiveTextSize(16.0)),
                                ),
                              ),
                              Row(
                                children: <Widget>[
                                  getCircleImage(
                                      radius: 50,
                                      placeHolderImage: 'images/truck_placeholder.png',
                                      url: bloc.bookingDetail?.truckImage),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(localize('txt_truck'),
                                            style: TextStyle(
                                                fontSize: responsiveTextSize(22.0),
                                                fontFamily: 'roboto',
                                                fontWeight: FontWeight.w500,
                                                color: ColorResource
                                                    .colorMarineBlue)),
                                        RatingBar.builder(
                                          initialRating: 5,
                                          allowHalfRating: false,
                                          itemBuilder: (context, _) => Icon(
                                            Icons.star,
                                            color: ColorResource.colorMariGold,
                                          ),
                                          onRatingUpdate: bloc.rateTruck,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 4.0,
                              ),
                              AutoFloatLabelTextField(
                                driverReviewController,
                                readOnly: false,
                                isDrop: false,
                                labelText: AppTranslations.of(context)
                                    .text("lbl_truck_rev"),
                                maxLines: 5,
                                hintText: AppTranslations.of(context)
                                    .text("hint_driver_rev"),
                                maxLength: 250,
                                callback: bloc.leaveTruckReview,
                                text: bloc.truckReview,
                              ),
                              ReviewImagePicker(
                                  containerHeight: responsiveSize(180.0),
                                  callback: bloc.imageFile),
                              SizedBox(
                                height: 20.0,
                              ),
                              FilledColorButton(
                                isFilled: true,
                                buttonText: AppTranslations.of(context)
                                    .text("btn_txt_rev"),
                                onPressed: () {
                                  process(bloc);
                                },
                                shouldHaveLeftRightMargin: true,
                              )
                            ],
                          ),
                        )
                      ],
                    ))),
            showLoader<AddReviewBloc>(bloc),
          ],
        ),
      )
    ];
  }

  process(AddReviewBloc bloc) async {
    ApiResponse response = await bloc.submitRating(widget.tripId);
    if (bloc.isApiError(response)) {
      showToast(response.message ?? translate(context, 'something_went_wrong'));
      return;
    }
    FireBaseAnalytics().logEvent(AnalyticsEvents.EVENT_RATING_BY_CUSTOMER,null);
    Navigator.pop(context,bloc.driverRating);
  }
}
