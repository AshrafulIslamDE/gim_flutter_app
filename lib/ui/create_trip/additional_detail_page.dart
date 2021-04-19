import 'dart:io';

import 'package:customer/core/localization/AppTranslation.dart';
import 'package:customer/ui/create_trip/bloc/additional_deail_bloc.dart';
import 'package:customer/ui/create_trip/create_trip_summary_page.dart';
import 'package:customer/ui/widget/app_button.dart';
import 'package:customer/ui/widget/auto_float_label_widget.dart';
import 'package:customer/ui/widget/base_widget.dart';
import 'package:customer/ui/widget/create_trip_title_widget.dart';
import 'package:customer/ui/widget/img_picker_widget.dart';
import 'package:customer/ui/widget/mandatory_field_note_widget.dart';
import 'package:customer/ui/widget/navigation_utils.dart';
import 'package:customer/utils/common_utils.dart';
import 'package:customer/utils/screen_dimension_utils.dart';
import 'package:customer/utils/analytics.dart';
import 'package:customer/utils/firebase_analytics_utils.dart';
import 'package:customer/utils/ui_constant.dart';
import 'package:customer/utils/ui_utils.dart';
import 'package:customer/utils/validationUtils.dart';
import 'package:firebase_performance/firebase_performance.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class CreateTripAdditionalDetailScreen extends StatelessWidget {
  final bool invoiceActivated;

  CreateTripAdditionalDetailScreen({this.invoiceActivated});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AdditionalDetailBloc>(
            create: (_) =>
                AdditionalDetailBloc(invoiceActivated: this.invoiceActivated)),
      ],
      child: AdditionalDetailPage(),
    );
  }
}

class AdditionalDetailPage extends StatefulWidget {
  @override
  _AdditionalDetailPageState createState() => _AdditionalDetailPageState();
}

class _AdditionalDetailPageState
    extends BasePageWidgetState<AdditionalDetailPage, AdditionalDetailBloc> {
  final Trace trace =
      FirebasePerformance.instance.newTrace('create_trip_details');
  var truckTypeController = TextEditingController();
  var instructionController = TextEditingController();
  var truckSizeController = TextEditingController();
  var distributorController = TextEditingController();
  var prodTypeController = TextEditingController();
  var truckLengthController = TextEditingController();
  var truckWidthController = TextEditingController();
  var truckHeightController = TextEditingController();
  var goodsTypeController = TextEditingController();
  var lcNumberController = TextEditingController();
  var otherTogController = TextEditingController();
  var nameController = TextEditingController();
  var mobileController = TextEditingController();
  var paymentController = TextEditingController();
  File _imageFile;

  @override
  void initState() {
    trace.start();
    super.initState();
  }

  @override
  onBuildCompleted() {
    if (mounted) _setUpDataHolder();
  }

  @override
  PreferredSizeWidget getAppbar() {
    return CreateTripHeader(
      currentStep: 3,
      isShowBackButton: true,
    );
  }

  @override
  List<Widget> getPageWidget() {
    return [
      Consumer<AdditionalDetailBloc>(
          builder: (context, bloc, _) => Stack(
                children: <Widget>[
                  Container(
                    color: Colors.white,
                    child: LayoutBuilder(builder: (BuildContext context,
                        BoxConstraints viewportConstraints) {
                      return SingleChildScrollView(
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                              minHeight: viewportConstraints.maxHeight),
                          child: Container(
                            margin: EdgeInsets.only(
                                left: 20.0,
                                top: 20.0,
                                right: 20.0,
                                bottom: 100.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Align(
                                  alignment: Alignment.bottomLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10.0, bottom: 10.0),
                                    child: Text(
                                      localize("txt_add_dtl"),
                                      style: TextStyle(
                                          fontFamily: "roboto",
                                          fontWeight: FontWeight.w700,
                                          fontSize: responsiveTextSize(20.0),
                                          color: ColorResource.colorMarineBlue),
                                    ),
                                  ),
                                ),
                                AutoFloatLabelTextField(
                                  truckTypeController..text = bloc.truckType,
                                  readOnly: true,
                                  isDrop: true,
                                  withImg: true,
                                  labelText: localize("lbl_truck_type"),
                                  hintText: localize("hint_please_select"),
                                  items: bloc.truckTypes,
                                  callback: bloc.selTruckType,
                                  text: bloc.truckType,
                                  prefImgUrl: bloc.selectedTruckType?.image,
                                ),
                                AutoFloatLabelTextField(
                                  truckSizeController..text = bloc.truckSize,
                                  readOnly: true,
                                  isDrop: true,
                                  labelText: localize("lbl_truck_size"),
                                  hintText: localize("hint_please_select"),
                                  items: bloc.truckSizes,
                                  callback: bloc.selTruckSize,
                                  text: bloc.truckSize,
                                ),
                                Align(
                                  alignment: Alignment.bottomLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10.0, top: 10.0, bottom: 10.0),
                                    child: Text(
                                      localize("txt_truck_dimen"),
                                      style: TextStyle(
                                          fontFamily: "roboto",
                                          fontWeight: FontWeight.w500,
                                          fontSize: responsiveTextSize(14.0),
                                          color: ColorResource.colorMarineBlue),
                                    ),
                                  ),
                                ),
                                Container(
                                  decoration: new BoxDecoration(
                                    borderRadius: new BorderRadius.circular(
                                        responsiveSize(4.0)),
                                    border: new Border.all(
                                      width: 1.0,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(
                                          child: AutoFloatLabelTextField(
                                        truckLengthController
                                          ..text = bloc.truckLength,
                                        readOnly: true,
                                        isDrop: true,
                                        hintText: localize("txt_length"),
                                        items: bloc.truckDimenLength,
                                        borderLess: true,
                                        onlyRightBorder: true,
                                        callback: bloc.selTruckLength,
                                        text: bloc.truckLength,
                                        maxLines: 1,
                                      )),
                                      Expanded(
                                          child: AutoFloatLabelTextField(
                                        truckWidthController
                                          ..text = bloc.truckWidth,
                                        readOnly: true,
                                        isDrop: true,
                                        hintText: localize("txt_width"),
                                        items: bloc.truckDimenWidth,
                                        borderLess: true,
                                        onlyRightBorder: true,
                                        callback: bloc.selTruckWidth,
                                        text: bloc.truckWidth,
                                        maxLines: 1,
                                      )),
                                      Expanded(
                                          child: AutoFloatLabelTextField(
                                        truckHeightController
                                          ..text = bloc.truckHeight,
                                        readOnly: true,
                                        isDrop: true,
                                        hintText: localize("txt_height"),
                                        items: bloc.truckDimenHeight,
                                        borderLess: true,
                                        callback: bloc.selTruckHeight,
                                        text: bloc.truckHeight,
                                        onlyRightBorder: true,
                                        maxLines: 1,
                                      )),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: responsiveSize(10.0),
                                ),
                                bloc.listOfGood == null ? AutoFloatLabelTextField(
                                  goodsTypeController..text = bloc.typeOfGood,
                                  readOnly: true,
                                  labelText: localize("lbl_goods_type"),
                                  hintText: localize("hint_please_select"),
                                  callback: bloc.selTog,
                                  startForResult: true,
                                  text: bloc.typeOfGood,
                                  items: bloc.typeOfGoods,
                                ):AutoFloatLabelTextField(
                                  goodsTypeController..text = bloc.goodType,
                                  readOnly: true,
                                  labelText: localize("lbl_goods_type"),
                                  hintText: localize("hint_please_select"),
                                  callback: bloc.selGood,
                                  startForResult: true,
                                  text: bloc.goodType,
                                  items: bloc.listOfGood,
                                ),
                                Visibility(
                                  visible: bloc.isTogOther,
                                  child: AutoFloatLabelTextField(
                                    otherTogController..text = bloc.otherTog,
                                    hintText: localize("tog_hint"),
                                    callback: bloc.selOtherTog,
                                    text: bloc.otherTog,
                                  ),
                                ),
                                Visibility(
                                    visible: bloc.isEnterpriseUser(),
                                    child: Column(
                                      children: <Widget>[
                                        Align(
                                          alignment: Alignment.bottomLeft,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10.0,
                                                top: 10.0,
                                                bottom: 10.0),
                                            child: Text(
                                              localize('txt_opt_inf')
                                                  .toUpperCase(),
                                              style: TextStyle(
                                                  fontFamily: "roboto",
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 20.0,
                                                  color: ColorResource
                                                      .colorMarineBlue),
                                            ),
                                          ),
                                        ),
                                        Visibility(
                                          visible: bloc.showDistributor,
                                          child: AutoFloatLabelTextField(
                                            distributorController
                                              ..text = bloc.distValue,
                                            readOnly: true,
                                            isDrop: true,
                                            labelText:
                                                AppTranslations.of(context)
                                                    .text("lbl_distributor")
                                                    .toUpperCase(),
                                            hintText:
                                                AppTranslations.of(context)
                                                    .text("hint_please_select"),
                                            items: bloc.listOfDistributor,
                                            callback: bloc.selDistributor,
                                            text: bloc.distValue,
                                            maxLines: 1,
                                          ),
                                        ),
                                        Visibility(
                                          visible: bloc.showProdType,
                                          child: AutoFloatLabelTextField(
                                            prodTypeController
                                              ..text = bloc.prodValue,
                                            readOnly: true,
                                            isDrop: true,
                                            withImg: true,
                                            labelText: localize('lbl_prd_type')
                                                .toUpperCase(),
                                            hintText: translate(
                                                context, 'hint_sel_prd'),
                                            items: bloc.listOfProd,
                                            callback: bloc.selProduct,
                                            text: bloc.prodValue,
                                            prefImgUrl:
                                                bloc.selectedProduct?.image,
                                          ),
                                        ),
                                        AutoFloatLabelTextField(
                                          lcNumberController
                                            ..text = bloc.lcNumber,
                                          readOnly: true,
                                          labelText: localize("lbl_lc_no"),
                                          hintText: localize("hint_lc_no"),
                                          callback: bloc.selLcNo,
                                          startForResult: true,
                                          searchFromApi: true,
                                          text: bloc.lcNumber,
                                        ),
                                      ],
                                    )),
                                Align(
                                  alignment: Alignment.bottomLeft,
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        left: responsiveSize(10.0),
                                        top: responsiveSize(10.0),
                                        bottom: responsiveSize(10.0)),
                                    child: Text(
                                      localize("txt_goods_rec"),
                                      style: TextStyle(
                                          fontFamily: "roboto",
                                          fontWeight: FontWeight.w700,
                                          fontSize: responsiveTextSize(20.0),
                                          color: ColorResource.colorMarineBlue),
                                    ),
                                  ),
                                ),
                                AutoFloatLabelTextField(
                                  nameController..text = bloc.name,
                                  labelText: localize("lbl_name"),
                                  hintText: localize("hint_name"),
                                  callback: bloc.selName,
                                  text: bloc.name,
                                  textCapitalization: TextCapitalization.words,
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                AutoFloatLabelTextField(
                                  mobileController..text = bloc.mobile,
                                  labelText: localize("lbl_contact"),
                                  hintText: localize("hint_contact"),
                                  callback: bloc.selMobile,
                                  text: bloc.mobile,
                                  inputFormatter: [
                                    LengthLimitingTextInputFormatter(11),
                                  ],
                                  textInputType: TextInputType.number,
                                  isValidate: true,
                                ),
                                Align(
                                  alignment: Alignment.bottomLeft,
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        left: responsiveSize(10.0),
                                        top: responsiveSize(10.0),
                                        bottom: responsiveSize(10.0)),
                                    child: Text(localize("txt_pay_type"),
                                        style: TextStyle(
                                            fontFamily: "roboto",
                                            fontWeight: FontWeight.w300,
                                            color: ColorResource.labelColor,
                                            fontSize:
                                                responsiveTextSize(16.0))),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: responsiveSize(10.0)),
                                  child: Row(
                                    children: <Widget>[
                                      Container(
                                        child: Icon(
                                          Icons.check_circle,
                                          size: responsiveSize(20),
                                          color: ColorResource.colorMarineBlue,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: responsiveSize(8.0)),
                                        child: Text(
                                            paymentController.text = bloc.invoiceActivated ? TextConst.PAY_TYPE_INV : bloc.isEnterpriseUser() ? TextConst.PAY_TYPE_B_CASH : TextConst.PAY_TYPE_CASH,
                                            style: TextStyle(
                                                fontFamily: "roboto",
                                                fontWeight: FontWeight.w500,
                                                fontSize:
                                                    responsiveTextSize(18.0),
                                                color: ColorResource
                                                    .colorMarineBlue)),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 20.0,
                                ),
                                AutoFloatLabelTextField(
                                  instructionController
                                    ..text = bloc.instruction,
                                  textInputType: TextInputType.multiline,
                                  labelText: localize("txt_instruction"),
                                  maxLines: 5,
                                  hintText: localize("hint_instruction"),
                                  maxLength: 250,
                                  callback: bloc.selInstructions,
                                  text: bloc.instruction,
                                  textCapitalization:
                                      TextCapitalization.sentences,
                                ),
                                ImagePickerWidget(
                                  imgWidth: responsiveSize(80.0),
                                  imgHeight: responsiveSize(120.0),
                                  imageFile: selImageFile,
                                  containerHeight: responsiveSize(100.0),
                                ),
                                SizedBox(
                                  height: 20.0,
                                ),
                                MandatoryFieldNote(),
                                FilledColorButton(
                                    buttonText: localize("txt_next"),
                                    backGroundColor: validate(bloc)
                                        ? HexColor("#96003250")
                                        : HexColor("#003250"),
                                    onPressed: () =>
                                        validate(bloc) ? null : navigate()),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ],
              ))
    ];
  }

  selImageFile(File imageFile) {
    _imageFile = imageFile;
  }

  _setUpDataHolder() async {
    try {
      submitDialog(context, dismissible: false);
      await bloc.inItDataSet();
    } catch (exception, log) {
      print(log);
      print(exception.toString());
    }
    _stopProgress();
  }

  void _stopProgress() {
    Navigator.pop(context);
  }

  validate(AdditionalDetailBloc bloc) {
    return isNullOrEmpty(bloc.truckType) ||
        isNullOrEmpty(bloc.truckSize) ||
        (isNullOrEmpty(bloc.typeOfGood) && isNullOrEmpty(bloc.goodType)) ||
        (bloc.isTogOther && bloc.otherTog.isEmpty) ||
        (bloc.mobile.isNotEmpty && validateMobile(bloc.mobile) != null);
  }

  navigate() {
    trace.stop();
    FireBaseAnalytics().logEvent(
        AnalyticsEvents.EVENT_CREATE_TRIP_ADDITIONAL_DETAILS, null);
    navigateNextScreen(
        context,
        CreateTripDetailScreen(
          imageFile: _imageFile,
          showProdType: bloc.showProdType,
          paymentMethod: paymentController.text,
          showDistributor: bloc.showDistributor,
        ));
  }
}
