import 'package:customer/core/localization/AppTranslation.dart';
import 'package:customer/model/bid/bid_item.dart';
import 'package:customer/ui/bid/bid_detail_item.dart';
import 'package:customer/ui/widget/base_widget.dart';
import 'package:customer/ui/widget/expanded_tile.dart';
import 'package:customer/utils/common_utils.dart';
import 'package:customer/utils/screen_dimension_utils.dart';
import 'package:customer/utils/ui_constant.dart';
import 'package:flutter/material.dart';

class BidListItem extends BaseItemView<BidItem> {
  @override
  Widget build(BuildContext context) {
    return BiddingItem(item: item, position: position);
  }
}

class BiddingItem extends StatefulWidget {
  final int position;
  final BidItem item;

  BiddingItem({Key key, this.item, this.position}) : super(key: key);

  @override
  _BiddingItemState createState() => _BiddingItemState();
}

class _BiddingItemState extends State<BiddingItem> {
  //static GlobalKey<ExpandedTileState> selExpansionTile;
  //final GlobalKey<ExpandedTileState> expansionTileState = new GlobalKey();

  @override
  Widget build(BuildContext context) {
    return ExpandedTile(
      //key: expansionTileState,
      position: widget.position,
      initiallyExpanded: widget.item.isExpanded ?? false,
      backgroundColor:  ColorResource.off_white,
      title: Container(
        color: widget.item.isExpanded ? ColorResource.off_white : (widget.position+1)%2==0? ColorResource.white_gray:ColorResource.colorWhite,
        padding: EdgeInsets.all(responsiveSize(14.0)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FittedBox(
              child: Text(
                widget.item.fleetOwnerName,
                style: TextStyle(
                    fontSize: responsiveTextSize(18),
                    fontFamily: 'roboto',
                    fontWeight: FontWeight.w500,
                    color: ColorResource.colorMarineBlue),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 5.0, bottom: 5.0),
              child: Text(
                translate(context,'trip_completed').toUpperCase(),
                style: TextStyle(
                    fontSize: responsiveTextSize(9),
                    fontFamily: 'roboto',
                    fontWeight: FontWeight.w900,
                    color: ColorResource.colorMarineBlue),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  formatTripDigits(widget.item.completedTripsCount).toUpperCase(),
                  style: TextStyle(
                      fontSize: responsiveTextSize(18),
                      fontFamily: 'roboto',
                      fontWeight: FontWeight.w700,
                      color: ColorResource.lightBlu),
                ),
                RichText(
                  text: TextSpan(
                      text: translate(context, "bid").toUpperCase() + " ",
                      style: TextStyle(
                          fontSize: responsiveTextSize(20),
                          fontFamily: 'roboto',
                          fontWeight: FontWeight.w700,
                          color: ColorResource.colorMariGold),
                      children: <TextSpan>[
                        TextSpan(
                            text: '${amountWithCurrencySign(widget.item.totalAmount)}',
                            style: TextStyle(
                                fontSize: responsiveTextSize(20),
                                fontFamily: 'roboto',
                                fontWeight: FontWeight.w700,
                                color: ColorResource.colorMarineBlue))
                      ]),
                )
              ],
            )
          ],
        ),
      ),
      children: [ViewBidDetailItem(item: widget.item)],
      onExpansionChanged: (isExpanded) {
        /*if(selExpansionTile != null){
          selExpansionTile.currentState.collapse();
        }
        selExpansionTile = isExpanded ? expansionTileState : null;*/
        widget.item.isExpanded = isExpanded;
        setState(() {});
      },
    );
  }
}
