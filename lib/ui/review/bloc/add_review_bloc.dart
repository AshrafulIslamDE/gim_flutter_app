import 'dart:io';
import 'package:customer/bloc/base_bloc.dart';
import 'package:customer/model/trip/trip_detail_response.dart';
import 'package:customer/networking/api_response.dart';
import 'package:customer/ui/review/repo/review_repo.dart';
import 'package:dio/dio.dart';

class AddReviewBloc extends BaseBloc {
  File _file;
  String _truckReview = '';
  String _driverReview = '';
  double _truckRating = 5.0;
  double _driverRating = 5.0;
  TripDetailResponse _tripDetail;


  toggleIsLoading(){
    isLoading = !isLoading;
    notifyListeners();
  }

  leaveDriverReview(driveReview) {
    _driverReview = driveReview;
  }

  get driverReview => _driverReview;

  leaveTruckReview(truckReview) {
    _truckReview = truckReview;
  }

  get truckReview => _truckReview;

  rateTruck(truckRate) {
    _truckRating = truckRate;
  }

  get truckRating => _truckRating;

  rateDriver(driverRate) {
    _driverRating = driverRate;
  }

  get driverRating => _driverRating;

  imageFile(File file) {
    _file = file;
  }

  get image => _file;

  TripDetailResponse get bookingDetail => _tripDetail;

  set tripDetail(apiResponse) {
    isLoading = false;
    _tripDetail = TripDetailResponse.fromJson(apiResponse.data);
    notifyListeners();
  }

  getTripDetail(final int tripId) async {
    isLoading = true;
    await ReviewRepo.getCompletedTripDetail(tripId).then((apiResponse) {
      if (apiResponse.status == Status.COMPLETED) {
        tripDetail = apiResponse;
      }
    });
  }

  submitRating(tripId) async {
    toggleIsLoading();

    FormData formData = new FormData.fromMap({
      "image.image": image == null ? null : await MultipartFile.fromFile(image
          .path),
      "image.type": 1,
      "tripId": tripId,
      "driverRating": driverRating,
      "truckRating": truckRating,
      "driverReview": _driverReview,
      "truckReview": _truckReview,
    });
    return await ReviewRepo.submitRating(formData);
  }
}
