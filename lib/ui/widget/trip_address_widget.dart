import 'package:customer/core/localization/AppTranslation.dart';
import 'package:customer/model/trip/trip.dart';
import 'package:customer/styles.dart';
import 'package:customer/ui/trip/trip_detail/trip_detail_page.dart';
import 'package:customer/ui/widget/app_button.dart';
import 'package:customer/ui/widget/navigation_utils.dart';
import 'package:customer/utils/app_data_ui_utils.dart';
import 'package:customer/utils/date_time_utils.dart';
import 'package:customer/utils/screen_dimension_utils.dart';
import 'package:customer/utils/ui_constant.dart';
import 'package:flutter/material.dart';


class AddressWidget extends StatelessWidget {
  final TripItem tripItem;

  AddressWidget({this.tripItem});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: ColorResource.lightBlue,
          border: Border(
              top: BorderSide(width: 1.0, color: Colors.grey),
              bottom: BorderSide(width: 1.0, color: Colors.grey))),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Text(localize('txt_trip_no').toUpperCase()+localize('number_count',dynamicValue: tripItem.tripNumber.toString()),
                  style: Styles.tripNoStyle,
                ),
                setDistributorTagVisibility(tripItem,iconSize: 20.0)
              ],
            ),
            Column(
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
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Text(
                                  AppTranslations.of(context)
                                      .text("tdp_pick_lbl"),
                                  style: TextStyle(
                                    color: Color.fromRGBO(0, 50, 80, 1.0),
                                    fontSize: responsiveDefaultTextSize(),
                                    fontFamily: "roboto",
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                SizedBox(
                                  width: 4.0,
                                ),
                                Text(
                                  convertTimestampToDateTime(
                                      timestamp: tripItem.pickupDateTimeUtc),
                                  style: TextStyle(
                                    color: Color.fromRGBO(0, 50, 80, 1),
                                    fontSize: responsiveDefaultTextSize(),
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
                              tripItem.pickupAddress,
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
                            height: responsiveSize(24),
                            width: responsiveSize(18)
                    )),
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(AppTranslations.of(context).text("tdp_drop_lbl"),
                                style: TextStyle(
                                  color: Color.fromRGBO(96, 154, 186, 1.0),
                                  fontSize: responsiveDefaultTextSize(),
                                  fontFamily: "roboto",
                                  fontWeight: FontWeight.w700,
                                )),
                            SizedBox(
                              height: 2.0,
                            ),
                            Text(
                              tripItem.dropoffAddress,
                              style: Styles.tripDetailAddress,
                              softWrap: true,
                              maxLines: 2,
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
            SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                CustomButton(
                  padding:EdgeInsets.only(left: 5,right: 5,top: 5,bottom: 5),
                  text:AppTranslations.of(context).text("txt_detail") ,
                  borderColor:ColorResource.colorMarineBlue ,
                  textColor:ColorResource.colorMarineBlue,
                  bgColor: ColorResource.lightBlue,
                  onPressed: (){navigateNextScreen(context, TripDetailPageContainer(tripId: tripItem.id));},
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
