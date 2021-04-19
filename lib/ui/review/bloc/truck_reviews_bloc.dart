import 'package:customer/bloc/base_pagination_bloc.dart';
import 'package:customer/model/base.dart';
import 'package:customer/model/review/truck_review_response.dart';
import 'package:customer/networking/api_response.dart';
import 'package:customer/ui/review/repo/review_repo.dart';

class TruckReviewsBloc extends BasePaginationBloc<TruckReviewItem> {
  var truckId;

  @override
  getListFromApi({callback}) async {
    queryParam = {
      'size': size.toString(),
      'page': currentPage.toString(),
      'truckId': truckId.toString()
    };
    isLoading = true;
    ApiResponse response =
        await ReviewRepo.getTruckReviews(queryParam: queryParam);
    checkResponse(response, successCallback: () {
      var pagination = BasePagination<TruckReviewItem>.fromJson(response.data);
      if (pagination.contentList.isNotEmpty) {
        setPaginationItem(pagination);
      }
    });
    return response;
  }
}
