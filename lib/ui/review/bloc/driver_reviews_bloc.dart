import 'package:customer/bloc/base_pagination_bloc.dart';
import 'package:customer/model/base.dart';
import 'package:customer/model/review/driver_review_response.dart';
import 'package:customer/networking/api_response.dart';
import 'package:customer/ui/review/repo/review_repo.dart';

class DriverReviewsBloc extends BasePaginationBloc<DriverReviewItem> {
  var driverId;
  @override
  getListFromApi({callback}) async {
    queryParam = {
      'size': size.toString(),
      'page': currentPage.toString(),
      'driverId': driverId.toString()
    };
    isLoading = true;
    ApiResponse response =
        await ReviewRepo.getDriverReviews(queryParam: queryParam);
    checkResponse(response, successCallback: () {
      var pagination = BasePagination<DriverReviewItem>.fromJson(response.data);
      if (pagination.contentList.isNotEmpty) {
        setPaginationItem(pagination);
      }
    });
    return response;
  }
}
