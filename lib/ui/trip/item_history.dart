import 'package:cached_network_image/cached_network_image.dart';
import 'package:customer/core/localization/AppTranslation.dart';
import 'package:customer/ui/receipt/view_receipt_page.dart';
import 'package:customer/ui/review/add_rating_page.dart';
import 'package:customer/ui/trip/widget/trip_adress_info.dart';
import 'package:customer/ui/trip/widget/trip_goods_type.dart';
import 'package:customer/ui/trip/widget/trip_truck_info.dart';
import 'package:customer/ui/widget/app_button.dart';
import 'package:customer/model/trip/trip.dart';
import 'package:customer/ui/widget/base_widget.dart';
import 'package:customer/ui/widget/listview_shape.dart';
import 'package:customer/ui/widget/navigation_utils.dart';
import 'package:customer/utils/app_data_ui_utils.dart';
import 'package:customer/utils/common_utils.dart';
import 'package:customer/utils/screen_dimension_utils.dart';
import 'package:customer/utils/ui_constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ItemHistoryTrip extends BaseItemView<TripItem> {

  navigateRatingScreen(BuildContext context)async{
   var result= await navigateNextScreen(context, AddARatingScreen(item.id));
   item.tripDriverRating=result;
   print(result);
 //  if()
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: ColorResource.colorWhite,
      child: InkWell(
        onTap: () => onItemClick(item),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Divider(
              color: ColorResource.divider_color,
              height: 1,
            ),
            Stack( children: [
              Visibility(
                visible: true,
                child: AspectRatio(
                  aspectRatio: 16 / 7,
                  child: CachedNetworkImage(imageUrl:item.staticMapPhotoTwoEighty??'images/dummy_user_img.png',
                    placeholder: (context, url) => Image.asset('images/map_place_holder.png', fit: BoxFit.fill),
                    errorWidget: (context, url, error) => Image.asset('images/map_place_holder.png', fit: BoxFit.fill),
                    fit: BoxFit.fitWidth,
                  ),

                ),
              ),
              Positioned(
                bottom: responsiveSize(10),
                left: responsiveSize(10),
                right: responsiveSize(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    CustomButton(
                      onPressed:item.tripDriverRating==null? () {navigateRatingScreen(context);}:null,
                      text: item.tripDriverRating==null?translate(context,'rating_required'):localize('number_decimal_count',dynamicValue: item.tripDriverRating.toString(),symbol: "%f"),
                      prefixIcon: item.tripDriverRating==null?null:SvgPicture.asset('svg_img/ic_star_on.svg',
                        width: responsiveSize(12.0),),
                      padding: EdgeInsets.only(top: responsiveSize(5.0),bottom: responsiveSize(5.0)),
                    ),
                    CustomButton(
                      onPressed: () {navigateNextScreen(context, ViewReceiptScreen(item.id));},
                      text: translate(context, 'receipt'),
                      bgColor: ColorResource.colorMarineBlue,
                      textColor: Colors.white,
                      padding: EdgeInsets.only(top: responsiveSize(5.0),bottom:responsiveSize(5.0)),
                      prefixIcon: SvgPicture.asset('svg_img/ic_invoice_icon.svg',color: Colors.white,
                        width: responsiveSize(12.0),),
                    ),


                  ],
                ),
              ),

            ]),

            Stack(
              children: <Widget>[
                getLeftSideShape(),
                getRightSideShape(),
                Padding(
                  padding:  EdgeInsets.only(
                      left:responsiveSize(18.0), right: responsiveSize(18.0), 
                      top: responsiveSize(10.0), bottom: responsiveSize(10.0)),
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
                            child: Row(
                              children: <Widget>[
                                Text(amountWithCurrencySign(item.bidAmount),
                                    style: TextStyle(
                                        color: ColorResource.colorMarineBlue,
                                        fontSize: responsiveTextSize(14.0),
                                        fontWeight: FontWeight.bold)),
                                Icon(Icons.arrow_forward_ios,color: ColorResource.colorMarineBlue,size: responsiveSize(18.0),)
                              ],
                            ),
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
                        height: responsiveSize(5.0),
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
              ],
            ),
          ],
        ),
      ),
    );
  }
}
