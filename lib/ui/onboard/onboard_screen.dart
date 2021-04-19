import 'package:customer/core/localization/AppTranslation.dart';
import 'package:customer/features/registration/mobile_verification_screen.dart';
import 'package:customer/features/registration/model/otp_generation_response.dart';
import 'package:customer/features/registration/national_id_screen.dart';
import 'package:customer/features/registration/otp_verification_screen.dart';
import 'package:customer/features/registration/personal_info_screen.dart';
import 'package:customer/model/auth/login_response.dart';
import 'package:customer/ui/auth/login_screen.dart';
import 'package:customer/ui/widget/app_button.dart';
import 'package:customer/ui/widget/navigation_utils.dart';
import 'package:customer/utils/screen_dimension_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:customer/utils/ui_constant.dart';
import 'package:customer/utils/ui_utils.dart';
import 'onboard_bloc.dart';

class OnboardScreen extends StatefulWidget{

  @override
  _OnboardScreenState createState() => _OnboardScreenState();
}

class _OnboardScreenState extends State<OnboardScreen> {
  @override
  Widget build(BuildContext context) {
     return ChangeNotifierProvider<OnboardBloc>(
      create: (context)=>OnboardBloc(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: GestureDetector(
            onTap: ()=>hideSoftKeyboard(context),
            child: Container(
               color: ColorResource.colorMarineBlue,
               child: Padding(
                 padding:  EdgeInsets.all(responsiveSize(15)),
                 child: Stack(
                   children: <Widget>[
                     Positioned.fill(top:responsiveSize(60),child: Align(child: Image.asset('images/ic_gim_logo_2.webp',
                       width: responsiveSize(140),
                       height: responsiveSize(140),),
                       alignment: Alignment.topCenter,)),
                     Positioned.fill(top:responsiveSize(60),child: Align(child: Text(translate(context, 'intro_screen1_text').toUpperCase(),
                       style: TextStyle(color: ColorResource.colorWhite,fontWeight: FontWeight.bold,fontSize: responsiveTextSize(18.0)),
                     textAlign: TextAlign.center,),alignment: Alignment.center,)),
                     Positioned.fill(top:responsiveSize(15),child: Align(
                       child: Column(
                           mainAxisAlignment: MainAxisAlignment.end,
                           children: [
                             FilledColorButton(buttonText: translate(context, 'create_my_account').toUpperCase(),isFilled: true,textColor: ColorResource.colorMarineBlue,
                               backGroundColor: ColorResource.colorMariGold,onPressed: (){
                                 // showAlertDialog(context,"Do you want to withdraw its bid?","Yes, Cancel",(pressed)=>"");
                                // navigateNextScreen(context, OtpVerificationScreen(otpGenerationResponse: OtpGenerationResponse(),));
                              //   navigateNextScreen(context, NationalIdScreen(LoginResponse()));
                                 navigateNextScreen(context, MobileVerificationScreen());

                               },),
                             FilledColorButton(buttonText: translate(context, 'login'),isFilled: false,textColor:ColorResource.colorWhite,
                               backGroundColor:Colors.transparent,borderColor: ColorResource.colorWhite,onPressed: (){
                               navigateNextScreen(context, LoginScreenContainer());
                               },),

                           ]),alignment: Alignment.bottomCenter,)),
                     //01230000000
                   ],
                 ),
               ),
            ),
          ),
        ),
      ),
    );
  }
}

