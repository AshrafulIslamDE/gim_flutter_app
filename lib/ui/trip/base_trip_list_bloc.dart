import 'package:customer/bloc/base_bloc.dart';
import 'package:customer/bloc/base_pagination_bloc.dart';
import 'package:customer/data/local/db/database_controller.dart';
import 'package:customer/model/base.dart';
import 'package:customer/networking/api_response.dart';
import 'package:customer/model/trip/trip.dart';
import 'package:floor/floor.dart';
import 'package:flutter/foundation.dart';

class BaseTripListBloc extends BasePaginationBloc<TripItem> {
  BaseTrip trip;

  onTripListResponse(ApiResponse response, {callback}) {
    checkResponse(response, successCallback: () async {
      trip = BaseTrip.fromJson(response.data);
      setPaginationItem(trip.paginatedTrips);
      if (callback != null) callback();
      await filterInBanglaTruckType(trip.paginatedTrips.contentList);
      await filterInBanglaGoodsType(trip.paginatedTrips.contentList,
          bloc: this);
    });
  }
}
