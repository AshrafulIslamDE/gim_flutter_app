
import 'package:customer/core/localization/AppTranslation.dart';
import 'package:customer/data/local/db/district.dart';
import 'package:customer/features/registration/stepper_widget.dart';
import 'package:customer/model/auth/login_response.dart';
import 'package:customer/networking/api_response.dart';
import 'package:customer/ui/home/homepage.dart';
import 'package:customer/ui/widget/app_bar.dart';
import 'package:customer/ui/widget/app_button.dart';
import 'package:customer/ui/widget/editfield.dart';
import 'package:customer/ui/widget/image_picker.dart';
import 'package:customer/ui/widget/mandatory_field_note_widget.dart';
import 'package:customer/ui/widget/navigation_utils.dart';
import 'package:customer/utils/date_time_utils.dart';
import 'package:customer/utils/firebase_notifications.dart';
import 'package:customer/utils/image_utils.dart';
import 'package:customer/utils/screen_dimension_utils.dart';
import 'package:customer/utils/ui_constant.dart';
import 'package:customer/utils/ui_utils.dart';
import 'package:customer/utils/validationUtils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'national_id_bloc.dart';

class NationalIdScreen extends StatelessWidget {
  LoginResponse verificationResponse;
  NationalIdScreen(this.verificationResponse);
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<NationalIdBloc>(
      create: (context) => NationalIdBloc(),
      child: NationalIdInfoWidget(verificationResponse),
    );
  }
}

class NationalIdInfoWidget extends StatefulWidget {
  LoginResponse verificationResponse;
  NationalIdInfoWidget(this.verificationResponse);

  @override
  _NationalIdInfoWidgetState createState() => _NationalIdInfoWidgetState();
}

class _NationalIdInfoWidgetState extends State<NationalIdInfoWidget> {
  final nameEditController = TextEditingController();
  final nationalIdNumberEditController = TextEditingController();
  final dateOfBirthEditController = TextEditingController();
  final districtEditController = TextEditingController();
  var formState = GlobalKey<FormState>();
  var scaffoldState = GlobalKey<ScaffoldState>();
  var paddingValue=const EdgeInsets.fromLTRB(18,5,18,5);
  NationalIdBloc bloc;
  @override
  initState(){
    bloc=Provider.of<NationalIdBloc>(context,listen: false);
    setDistrictInfo();
    WidgetsBinding.instance.addPostFrameCallback((callback){
      setExistingData();

    });
   super.initState();

  }


  setExistingData(){
    nameEditController.text=widget.verificationResponse.name??'';
    var dob=widget.verificationResponse.dob;
    dateOfBirthEditController.text=dob==null?'': convertTimestampToDateTime(timestamp: dob,dateFormat: AppDateFormat,
        shouldUppercase: false,lng: "en");
    bloc.name=nameEditController.text;
    bloc.dob=getInputDate(dateOfBirthEditController.text);

  }

  setDistrictInfo()async{
    await bloc.loadDistrictData();
    DistrictCode district = bloc.findDistrictByName(
          widget.verificationResponse.district);
      if (district != null) {
        districtEditController.text = district.text;
        bloc.districtId = district.id;
      }

  }

  @override
  Widget build(BuildContext context) {
     return GestureDetector(
       onTap: ()=>hideSoftKeyboard(context),
       child: Scaffold(
        key: scaffoldState,
        resizeToAvoidBottomInset: false,
          appBar: AppBarWidget(title: translate(context, 'create_my_account'),shouldShowDivider: false,),
          body: Container(
            color: ColorResource.colorWhite,
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: paddingValue,
                child: Text(translate(context, "step_3_national_id_information").toUpperCase(),
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color: ColorResource.colorMarineBlue,
                      fontWeight: FontWeight.bold,
                      fontSize: responsiveTextSize(18)),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Form(
                    key: formState,
                    child: Padding(
                      padding: paddingValue,
                      child: Column(
                        children: <Widget>[
                          TextEditText(
                            formkey: formState,
                            labelText: translate(context, 'lbl_name').toUpperCase()+"*",
                            textEditingController: nameEditController,
                            validationMessageRegexPair: {
                              NOT_EMPTY_REGEX: translate(context, 'msg_name_is_required')
                            },
                            hintText: translate(context, 'hint_name'),
                            onChanged: (text)=>bloc.name=text,
                          ),
                          TextEditText(
                            formkey: formState,
                            labelText: translate(context, 'txt_dob').toUpperCase()+"*",
                            hintText: translate(context, 'hint_please_select'),
                            textEditingController: dateOfBirthEditController,
                            readOnly: true,
                            validationMessageRegexPair: {NOT_EMPTY_REGEX:translate(context,'msg_fill_date_of_birth' )},
                            suffixIcon: Image.asset(
                              "images/calendar.png",
                              height: 18,
                              width: 18,
                            ),
                            onTap: (){
                              print("onTop");
                              showAppDatePicker(context,minYear: -18,targetDateFormat: AppDateFormat,
                                  onSelected: (selectedDate){
                                bloc.dob=getInputDate(selectedDate);
                                dateOfBirthEditController.text=selectedDate;
                                formState.currentState.validate();
                                // bloc.notifyListeners();
                              });
                            },

                          ),
                          Consumer<NationalIdBloc>(
                              builder: (context,model,child)=>
                                  TextEditText<DistrictCode>(
                                    formkey: formState,
                                    labelText: translate(context, 'txt_dst')+'*',
                                    isSearchableItemWidget: true,
                                    suggestionDropDownItemList: model.districts,
                                    hintText: translate(context, 'hint_please_select'),
                                    validationMessageRegexPair: {NOT_EMPTY_REGEX:localize('select_district')},
                                    searchDrodownCallback: (item) {
                                      bloc.districtId=item.id;
                                      districtEditController.text=item.toString();
                                    },
                                    textEditingController: districtEditController,
                                  )
                          ),
                          TextEditText(
                            formkey: formState,
                            labelText: translate(context, 'txt_nid_no'),
                            textEditingController: nationalIdNumberEditController,
                            keyboardType: TextInputType.number,
                            maxlength: 17,
                            validationMessageRegexPair: {
                              NID_REGEX: translate(context, 'nation_id_error')
                            },
                            hintText: translate(context, 'hnt_enter_nid'),
                            onChanged: (text)=>bloc.nidNumber=text,
                          ),
                          ImagePickerWidget(
                            withImageText1: translate(context, 'txt_nid_pic'),
                            withImageText2: translate(context, 'txt_front'),
                            placeHolderImage: 'images/id_front.webp',
                            withoutImageText1: translate(context, 'txt_nid_pic_'),
                            withoutImageText2: translate(context, 'txt_front'),
                            onImageCallback: (file) {
                              convertImageToBase64(file).then((onValue) {
                                bloc.nidFrontSide = onValue;
                              });
                            },),
                          ImagePickerWidget(
                            withImageText1: translate
                              (context, 'txt_nid_pic_'),
                            withImageText2: translate
                              (context, 'txt_back'),
                            placeHolderImage: 'images/id_back.webp',
                            withoutImageText1: translate
                              (context, 'txt_nid_pic_'),
                            withoutImageText2: translate(context, 'txt_back'),
                            onImageCallback: (file) {
                              convertImageToBase64(file).then((onValue) {
                                bloc.nidBackSide = onValue;
                              });
                            },),

                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 5,),
              MandatoryFieldNote(),
              Padding(
                padding: paddingValue,
                child: FilledColorButton(
                  buttonText: translate(context, 'finish_and_create_my_account'),
                  fontWeight: FontWeight.normal,
                  onPressed: onCreateAccountPressed,
                ),
              ),
              getStepperWidget(3),
            ],
          )
          )),
     );
  }

  onCreateAccountPressed() async{
    if (formState.currentState.validate()) {
      if(bloc.validateForm((errorMsg){
        showSnackBar(scaffoldState.currentState,errorMsg);
      })) {
        submitDialog(context,dismissible: false);
        ApiResponse response = await bloc.signUp();
        Navigator.pop(context);
        if(!bloc.isApiError(response)){
          showSuccessDialog();
          FireBaseNotifications().setUpFireBase();
        }else
          showSnackBar(scaffoldState.currentState, response.message);
      }

    } else {
      //formState.currentState.reset();
    }
  }
  showSuccessDialog(){
    showThreeLabelSpannableDialog(context, 'sign_up_msg',callback:()=>  navigateNextScreen(context, Home(),shouldFinishPreviousPages: true));
  }
}
