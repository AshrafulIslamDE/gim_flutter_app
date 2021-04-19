import 'package:cached_network_image/cached_network_image.dart';
import 'package:customer/core/localization/AppTranslation.dart';
import 'package:customer/ui/trip/widget/live_trip_address_info.dart';
import 'package:customer/ui/trip/widget/trip_goods_type.dart';
import 'package:customer/ui/trip/widget/trip_truck_info.dart';
import 'package:customer/model/trip/trip.dart';
import 'package:customer/ui/widget/base_widget.dart';
import 'package:customer/ui/widget/listview_shape.dart';
import 'package:customer/utils/app_data_ui_utils.dart';
import 'package:customer/utils/screen_dimension_utils.dart';
import 'package:customer/utils/ui_constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ItemLiveTrip extends BaseItemView<TripItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: ColorResource.colorWhite,
      /* foregroundDecoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: ColorResource.warm_grey
      ),*/
      child: InkWell(
        onTap: () => onItemClick(item),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Divider(
              color: ColorResource.divider_color,
              height: 1,
            ),
            Stack(fit: StackFit.loose, children: [
              AspectRatio(
                aspectRatio: 16 / 7,
                child: CachedNetworkImage(imageUrl:item.staticMapPhotoTwoEighty??'images/dummy_user_img.png', //placeholder: (context, url) => new CircularProgressIndicator(),
                    placeholder: (context, url) => Image.asset('images/map_place_holder.png', fit: BoxFit.fill),
                    errorWidget: (context, url, error) => Image.asset('images/map_place_holder.png', fit: BoxFit.fill)),
              ),

            ]),
            Stack(
              children: <Widget>[
                getLeftSideShape(),
                getRightSideShape(),
                Padding(
                  padding:  EdgeInsets.only(
                      left: responsiveSize(18.0), right: responsiveSize(18.0), top: responsiveSize(10.0), 
                      bottom: responsiveSize(10.0)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Text(
                                translate(context, 'txt_trip_no').toUpperCase() + localize('number_count',dynamicValue: item.tripNumber.toString()),
                                style: TextStyle(
                                    color: ColorResource.warm_grey,
                                    fontSize: responsiveTextSize(12.0),
                                    fontFamily: 'roboto'),
                              ),
                              setDistributorTagVisibility(item)
                            ],
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Icon(Icons.arrow_forward_ios,color: ColorResource.colorMarineBlue,size: responsiveSize(15.0),)
                          )
                        ],
                      ),
                      SizedBox(
                        height: 0,
                      ),
                      Text(
                        item.fleetOwnerName??" ",
                        style: TextStyle(
                            color: ColorResource.colorMarineBlue, fontSize: responsiveTextSize(15.0)),
                      ),
                      SizedBox(
                        height: responsiveSize(5),
                      ),
                      LiveTripAddressInfoWidget(item),
                      TripGoodsTypeWidget(item),
                      SizedBox(
                        height: responsiveSize(5),
                      ),
                      TruckInfoWidget(item)
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
