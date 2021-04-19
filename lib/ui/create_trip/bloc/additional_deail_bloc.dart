import 'package:customer/bloc/base_bloc.dart';
import 'package:customer/core/localization/AppTranslation.dart';
import 'package:customer/data/local/db/TruckDimension.dart';
import 'package:customer/data/local/db/database_controller.dart';
import 'package:customer/data/local/db/goods_type.dart';
import 'package:customer/data/local/db/truck_size.dart';
import 'package:customer/data/local/db/truck_types.dart';
import 'package:customer/data/repository/user_repository.dart';
import 'package:customer/features/master/master_repository.dart';
import 'package:customer/model/base.dart';
import 'package:customer/model/profile/invoice_status.dart';
import 'package:customer/model/trip/distributors.dart';
import 'package:customer/model/trip/good_type.dart';
import 'package:customer/model/trip/product_type.dart';
import 'package:customer/networking/api_response.dart';
import 'package:customer/ui/create_trip/model/create_trip_request.dart';
import 'package:customer/ui/create_trip/repo/create_trip_repo.dart';
import 'package:customer/utils/common_utils.dart';
import 'package:customer/utils/prefs.dart';
import 'package:dio/dio.dart';

class AdditionalDetailBloc extends BaseBloc {
  String _image;
  bool isTogOther = false;
  List<TruckType> _truckType;
  TruckType selectedTruckType;
  List<TruckSize> _truckSize;
  TruckSize selectedTruckSize;
  bool invoiceActivated = false;
  List<TruckDimensionWidth> _truckDimenWidth;
  TruckDimensionWidth _selTruckWidth;
  List<TruckDimensionHeight> _truckDimenHeight;
  TruckDimensionHeight _selTruckHeight;
  List<TruckDimensionLength> _truckDimenLength;
  TruckDimensionLength _selTruckLength;
  GoodType selectedGood;
  GoodsType selectedTog;
  String selLcNumber;
  List<GoodType> _typeOfGood;
  List<GoodsType> _typeOfGoods;
  CreateTripRequest _tripRequest;
  List listOfProd;
  List listOfDistributor;
  Product selectedProduct;
  Distributor selectedDistributor;

  set typeOfGoods(List<GoodsType> value) {
    _typeOfGoods = value;
  }

  List<GoodType> get listOfGood => _typeOfGood;

  List<GoodsType> get typeOfGoods => _typeOfGoods;

  List<TruckType> get truckTypes => _truckType;

  List<TruckSize> get truckSizes => _truckSize;

  List<TruckDimensionWidth> get truckDimenWidth => _truckDimenWidth;

  List<TruckDimensionLength> get truckDimenLength => _truckDimenLength;

  List<TruckDimensionHeight> get truckDimenHeight => _truckDimenHeight;

  get showDistributor => !isNullOrEmptyList(listOfDistributor);

  get showProdType => !isNullOrEmptyList(listOfProd);

  AdditionalDetailBloc({this.invoiceActivated}) {
    _tripRequest = CreateTripRequest.instance;
    _tripRequest.init();
  }

  String get truckType => selectedTruckType?.toString() ?? "";

  selTruckType(item) {
    selectedTruckType = item;
    _tripRequest.truckType = selectedTruckType?.id ?? null;
    _tripRequest.truckTypeStr = selectedTruckType?.toString() ?? null;
    notifyListeners();
  }

  String get truckSize =>
      selectedTruckSize == null ? "" : selectedTruckSize.toString();

  selTruckSize(item) {
    selectedTruckSize = item;
    _tripRequest.truckSize = selectedTruckSize?.id ?? null;
    _tripRequest.truckSizeStr = selectedTruckSize?.size.toString() ?? null;
    notifyListeners();
  }

  get truckWidth => _selTruckWidth?.toString() ?? "";

  selTruckWidth(item) {
    _selTruckWidth = item;
    _tripRequest.truckWidth = _selTruckWidth?.value ?? null;
    notifyListeners();
  }

  get truckHeight => _selTruckHeight?.toString() ?? "";

  selTruckHeight(item) {
    _selTruckHeight = item;
    _tripRequest.truckHeight = _selTruckHeight?.value ?? null;
    notifyListeners();
  }

  get truckLength => _selTruckLength?.toString() ?? "";

  selTruckLength(item) {
    _selTruckLength = item;
    _tripRequest.truckLength = _selTruckLength?.value ?? null;
    notifyListeners();
  }

  inItDataSet() async {
    List<Future> futures = [];
    futures.add(MasterRepository.getTruckTypes().then((val) {
      _truckType = val;
    }));
    futures.add(MasterRepository.getTruckSizes().then((val) {
      _truckSize = val;
    }));
    futures.add(MasterRepository.getTruckWidth().then((val) {
      _truckDimenWidth = val;
    }));
    futures.add(MasterRepository.getTruckLength().then((val) {
      _truckDimenLength = val;
    }));
    futures.add(MasterRepository.getTruckHeight().then((val) {
      _truckDimenHeight = val;
    }));
    futures.add(MasterRepository.getGoodsType().then((val) {
      _typeOfGoods = val;
    }));
    if (invoiceActivated == null)
      futures.add(UserRepository.invoiceActivated().then((apiRes) {
        if (apiRes.status == Status.COMPLETED) {
          invoiceActivated =
              InvoiceStatus.fromJson(apiRes.data).status ?? false;
        }
      }));
    if (isEnterpriseUser()) {
      futures.add(CreateTripRepo.goodsType().then((apiRes) {
        checkResponse(apiRes, successCallback: () {
          if (apiRes.data != null && apiRes.data.length > 0) {
            _typeOfGood = convertDynamicListToStaticList<GoodType>(apiRes.data);
          }
        });
      }));
      futures.add(CreateTripRepo.prodType().then((apiRes) {
        checkResponse(apiRes, successCallback: () {
          listOfProd =
              apiRes.data.map((product) => Product.fromJson(product)).toList();
        });
      }));
      futures.add(CreateTripRepo.distributors().then((apiRes) {
        checkResponse(apiRes, successCallback: () {
          listOfDistributor = apiRes.data
              .map((distributor) => Distributor.fromJson(distributor))
              .toList();
        });
      }));
    }
    await Future.wait(futures);
    notifyListeners();
  }

  get name => _tripRequest.receiverName ?? "";

  selName(String name) {
    _tripRequest.receiverName = name?.trim();
  }

  get mobile => _tripRequest.receiverNumber ?? "";

  selMobile(String mobile) {
    _tripRequest.receiverNumber = mobile;
  }

  get instruction => _tripRequest.specialInsturctions ?? "";

  selInstructions(String instruction) {
    _tripRequest.specialInsturctions = instruction?.trim();
  }

  get image => _image;

  selImage(String image) {
    _image = image;
  }

  String get lcNumber => selLcNumber ?? "";

  String get goodType => selectedGood?.toString() ?? "";

  String get typeOfGood => selectedTog?.toString() ?? "";

  String get otherTog => _tripRequest.otherGoodType ?? "";

  selTog(item) {
    selectedTog = item;
    _tripRequest.goodsType = selectedTog.id;
    _tripRequest.goodsTypeStr = selectedTog.toString();
    isTogOther =
        selectedTog.text.toUpperCase().compareTo("Other".toUpperCase()) == 0 ||
            selectedTog.text.toUpperCase().compareTo("Others".toUpperCase()) ==
                0;
    _tripRequest.otherGoodType = '';
    notifyListeners();
  }

  selGood(item) {
    selectedGood = item;
    _tripRequest.goodsType = selectedGood.masterGoodsTypeId;
    _tripRequest.goodsTypeStr = selectedGood.toString();
    notifyListeners();
  }

  selOtherTog(String tog) {
    _tripRequest.otherGoodType = tog;
    if (tog.length == 0 || tog.length == 1) notifyListeners();
  }

  selLcNo(String lcNo) {
    selLcNumber = lcNo;
    _tripRequest.lcNumber = selLcNumber?.trim();
    notifyListeners();
  }

  String get prodValue =>
      selectedProduct == null ? "" : selectedProduct.toString();

  selProduct(item) {
    selectedProduct = item;
    _tripRequest.productId = selectedProduct?.productId ?? null;
    _tripRequest.prodType = selectedProduct?.toString()?.trim() ?? null;
    notifyListeners();
  }

  String get distValue => selectedDistributor == null
      ? ""
      : selectedDistributor.toString().replaceAll('\n', ', ');

  selDistributor(item) {
    selectedDistributor = item;
    _tripRequest.distributorUserId = selectedDistributor?.userId ?? null;
    _tripRequest.distributorStr =
        selectedDistributor?.toString()?.trim() ?? null;
    invoiceActivated = item == null ? true : false;
    notifyListeners();
  }

  bool isEnterpriseUser() => Prefs.getBoolean(Prefs.PREF_IS_ENTERPRISE_USER);

  @override
  void dispose() {
    super.dispose();
    // print('disposed bloc');
    closeDatabase();
  }
}
