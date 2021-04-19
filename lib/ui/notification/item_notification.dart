 import 'package:customer/bloc/home/homebloc.dart';
import 'package:customer/core/localization/AppTranslation.dart';
import 'package:customer/data/constants.dart';
import 'package:customer/data/repository/notification_repository.dart';
import 'package:customer/model/notifications/notification_content.dart';
import 'package:customer/model/notifications/notification_read_list_request.dart';
import 'package:customer/networking/api_response.dart';
import 'package:customer/ui/widget/base_widget.dart';
import 'package:customer/utils/common_utils.dart';
import 'package:customer/utils/date_time_utils.dart';
import 'package:customer/utils/screen_dimension_utils.dart';
import 'package:customer/utils/ui_constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ItemNotification extends BaseItemView<NotificationContent>{

  /*updateReadCount(context)async{
    var response =await NotificationRepository.markRead(NotificationReadListRequest([item.notificationId]));
    if(response!=null && response.status==Status.COMPLETED){
      item.read=true;
      HomeBloc bloc=Provider.of<HomeBloc>(context, listen: false);
      bloc.notificationCount=bloc.notificationCount-1;
    }

  }*/

  @override
  Widget build(BuildContext context) {
    return /*VisibilityDetector(
      key: Key(position.toString()),
      onVisibilityChanged: (VisibilityInfo value){
       // print("index number:"+position.toString());
        if(!item.read)
          updateReadCount(context);
      },
      child: */InkWell(
        onTap: () => onItemClick(item,position),
        child: Container(
          padding: EdgeInsets.only(left: 18,right: 18,top: 10,bottom: 10),
          color: Colors.white,//item.read?Colors.white:ColorResource.not_read_notification,
          child: Column(
            children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: Text(item.message,maxLines: 2,overflow: TextOverflow.ellipsis,style: TextStyle(
                    color: ColorResource.colorMarineBlue,fontFamily: 'roboto',fontWeight: FontWeight.bold,
                    fontSize: responsiveTextSize(14.0),
                  ),),
                ),
                SizedBox(width: 10,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Text(convertTimestampToDateTime(timestamp: item.createdAt,dateFormat: AppTimeFormat),
                      style: TextStyle(color: ColorResource.warm_grey,fontWeight: FontWeight.bold,fontSize: responsiveTextSize(14)),),
                    Text(getDayDifferenceInText(item.createdAt),style: TextStyle(color: ColorResource.warm_grey,fontWeight: FontWeight.bold,
                    fontSize: responsiveTextSize(14.0)),)
                  ],
                )

              ],
            ),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: Text(_getDescriptionContent(context, item),maxLines: 1,overflow: TextOverflow.ellipsis,style: TextStyle(
                        color: ColorResource.greyish_brown,fontFamily: 'roboto',fontWeight: FontWeight.bold
                        ,fontSize: responsiveTextSize(16)
                    ),
                    ),
                  ),
                  SizedBox(width: 10,),
                  Visibility(visible:!item.isWelcomeNotification,child: Icon(Icons.arrow_forward_ios,color: ColorResource.colorMarineBlue,))

                ],
              )
            ],
          ) ,
        ),
      );
    /*);*/
  }
}
_getDescriptionContent(context,NotificationContent item){
  if(item.isWelcomeNotification) return item.description??" ";
  if(item.notificationType==Constants.NEW_BID_RECEIVED && !item.isReferralNotifiction())
   return translate(context, 'bid')+" "+amountWithCurrencySign(item.data.bidAmount);
  else
    return item.userName??' ';

}