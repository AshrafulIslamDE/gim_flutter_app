import 'package:customer/bloc/base_pagination_bloc.dart';
import 'package:customer/data/repository/referral_repository.dart';
import 'package:customer/model/referral/referral_history_response.dart';
import 'package:customer/networking/api_response.dart';

class ReferralHistoryBloc extends BasePaginationBloc<ReferralHistoryItem>{
  static const paid_amount="PaidAmount";
  static const reward_earned="RewardEarned";

  String _userEarningFilter=reward_earned;
  String get userEarningFilter => _userEarningFilter;
  double _totalPaidAmount=0.0;

  double get totalPaidAmount => _totalPaidAmount;

  set totalPaidAmount(double value) {
    _totalPaidAmount = value;
  }

  double _totalOutstandingAmount=0.0;
  double _totalEarnedAmount=0.0;

  set userEarningFilter(String value) {
    if(userEarningFilter!=value) {
      _userEarningFilter = value;
      reloadList();
    }
  }

  double get totalOutstandingAmount => _totalOutstandingAmount;

  set totalOutstandingAmount(double value) {
    _totalOutstandingAmount = value;
  }

  double get totalEarnedAmount => _totalEarnedAmount;

  set totalEarnedAmount(double value) {
    _totalEarnedAmount = value;
  }

  @override
  getListFromApi({callback})async {
    isLoading=true;
    queryParam['userEarningFilter']=_userEarningFilter;
    ApiResponse response=await ReferralRepository.getMyEarning(getBaseQueryParam());
    checkResponse(response,successCallback: (){
      ReferralHistoryResponse referralResponse= ReferralHistoryResponse.fromJson(response.data);
      totalPaidAmount=referralResponse.totalPaidAmount;
      totalEarnedAmount=referralResponse.totalEarnedAmount;
      totalOutstandingAmount=referralResponse.totalOutstandingAmount;
      setPaginationItem(referralResponse.filteredUserEarnings);
    });
  }
}