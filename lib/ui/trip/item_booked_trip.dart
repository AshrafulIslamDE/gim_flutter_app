import 'package:customer/core/localization/AppTranslation.dart';
import 'package:customer/ui/trip/widget/trip_adress_info.dart';
import 'package:customer/ui/trip/widget/trip_goods_type.dart';
import 'package:customer/ui/trip/widget/trip_truck_info.dart';
import 'package:customer/ui/widget/app_button.dart';
import 'package:customer/model/trip/trip.dart';
import 'package:customer/ui/widget/base_widget.dart';
import 'package:customer/ui/widget/listview_shape.dart';
import 'package:customer/utils/app_data_ui_utils.dart';
import 'package:customer/utils/date_time_utils.dart';
import 'package:customer/utils/screen_dimension_utils.dart';
import 'package:customer/utils/ui_constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ItemBookedTrip extends BaseItemView<TripItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: (position+1)%2==0? ColorResource.white_gray:ColorResource.colorWhite,
      /* foregroundDecoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: ColorResource.warm_grey
      ),*/
      child: InkWell(
        onTap: () => onItemClick(item),
        child: Stack(
          children: <Widget>[

            Padding(
              padding:  EdgeInsets.only(left:responsiveSize(18.0),right: responsiveSize(18.0),
                  top: responsiveSize(10),bottom: responsiveSize(10)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding:  EdgeInsets.only(left:responsiveSize(28.0+8.0),top: 0),
                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Text(AppTranslations.of(context).text('txt_trip_no').toUpperCase()+localize('number_count',dynamicValue: item.tripNumber.toString()),
                                style: TextStyle(color: ColorResource.warm_grey,
                                    fontSize: responsiveTextSize(12),
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'roboto'),
                              ),
                              setDistributorTagVisibility(item)
                            ],
                          ),
                          SizedBox(width: responsiveSize(10),),
                          Expanded(
                            child: Align(alignment: Alignment.centerRight,
                              child: FittedBox(fit:BoxFit.fitWidth,
                                child: CustomButton(text: getTimeDifferenceInDaysHours(item.pickupDateTimeUtc),
                                  suffixIcon: Icons.arrow_forward_ios,
                                  ),
                              ),
                            ),
                          )
                        ])),
                  SizedBox(
                    height: 0,
                  ),
                  TripAddressInfoWidget(item),
                  TripGoodsTypeWidget(item),
                  SizedBox(
                    height: responsiveSize(5),
                  ),
                  TruckInfoWidget(item)
                ],
              ),
            ),
            getLeftSideShape(),
            getRightSideShape(),
          ],
        ),
      ),
    );
  }
}
