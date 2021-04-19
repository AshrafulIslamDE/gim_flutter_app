import 'package:customer/bloc/base_pagination_bloc.dart';
import 'package:customer/data/repository/referral_repository.dart';
import 'package:customer/model/referral/referral_response.dart';
import 'package:customer/networking/api_response.dart';

class ReferralDashboardBloc extends BasePaginationBloc<Referral>{
  static  const  REGISTERED_USER_WITH_REFERRAL = "RegisteredUserWithReferral";
  static const  UNREGISTERED_USER_WITH_REFERRAL = "UnregisteredUserWithReferral";
  String _referralFilter=REGISTERED_USER_WITH_REFERRAL;

  String get referralFilter => _referralFilter;

  set referralFilter(String value) {
    if(referralFilter!=value) {
      _referralFilter = value;
     // notifyListeners();
      reloadList();
    }
  }

  int _registeredUserCount=0;
  int get registeredUserCount => _registeredUserCount;

  set registeredUserCount(int value) {
    _registeredUserCount = value;
  }

  int _pendingUserCount=0;

  int get pendingUserCount => _pendingUserCount;

  set pendingUserCount(int value) {
    _pendingUserCount = value;
  }

  @override
  getListFromApi({callback})async {
    isLoading=true;
    queryParam['referralFilter']=referralFilter;
     ApiResponse response=await ReferralRepository.getMyreferral(getBaseQueryParam());
     checkResponse(response,successCallback: (){
       ReferralResponse referralResponse= ReferralResponse.fromJson(response.data);
       registeredUserCount=referralResponse.totalRegisteredUserWithReferral;
       pendingUserCount=referralResponse.totalUnregisteredUserWithReferral;
       setPaginationItem(referralResponse.filteredReferrals);
     });
  }

}