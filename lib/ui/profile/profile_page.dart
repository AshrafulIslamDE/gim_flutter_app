import 'package:auto_size_text/auto_size_text.dart';
import 'package:customer/bloc/home/homebloc.dart';
import 'package:customer/core/localization/AppTranslation.dart';
import 'package:customer/networking/api_response.dart';
import 'package:customer/styles.dart';
import 'package:customer/ui/home/home_drawer_icon.dart';
import 'package:customer/ui/password/change_password_page.dart';
import 'package:customer/ui/profile/edit_my_details.dart';
import 'package:customer/ui/widget/app_bar.dart';
import 'package:customer/ui/widget/base_widget.dart';
import 'package:customer/ui/widget/navigation_utils.dart';
import 'package:customer/utils/common_utils.dart';
import 'package:customer/utils/date_time_utils.dart';
import 'package:customer/utils/image_utils.dart';
import 'package:customer/utils/prefs.dart';
import 'package:customer/utils/screen_dimension_utils.dart';
import 'package:customer/utils/ui_constant.dart';
import 'package:customer/utils/ui_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'bloc/profile_bloc.dart';

class ProfilePageContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ProfileBloc>(create: (_) => ProfileBloc()),
      ],
      child: ProfilePage(),
    );
  }
}

class ProfilePage extends StatefulWidget {
  ProfilePage({Key key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends BasePageWidgetState<ProfilePage, ProfileBloc> {
  bool isProfileUpdated = false;

  @override
  onBuildCompleted() => _getProfile();

  _onEditPressed() async {
    var result = await navigateNextScreen(
        context, EditMyDetailsScreen(userProfile: bloc.userProfile));
    if (result != null && result is String) {
      showSnackBar(scaffoldState.currentState, result);
      isProfileUpdated = true;
      _getProfile();
    }
  }

  @override
  PreferredSizeWidget getAppbar() {
    var editActionWidget = Center(
      child: InkWell(
          child: Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: Text(
              translate(context, 'edit').toUpperCase(),
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: ColorResource.colorMarineBlue,
                  fontFamily: "roboto",
                  fontWeight: FontWeight.w500,
                  fontSize: responsiveTextSize(16.0)),
            ),
          ),
          onTap: () => _onEditPressed()),
    );
    return AppBarWidget(
      title: "",
      shouldShowBackButton: false,
      shouldShowDivider: false,
      leadingWidget: getDrawerIcon(Scaffold.of(context)),
      action: <Widget>[
        Visibility(
          visible: bloc.isNormalUser(),
          child: editActionWidget,
        )
      ],
    );
  }

  @override
  onRetryClick() {
    super.onRetryClick();
    _getProfile();
  }

  @override
  List<Widget> getPageWidget() {
    return [
      Consumer<ProfileBloc>(
        builder: (context, bloc, _) => Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: getCircleImage(
                      radius: responsiveTextSize(30),
                      url: bloc.userProfile.pic,
                      placeHolderImage: 'images/user.png')),
              Padding(
                padding: const EdgeInsets.only(left: 18.0, right: 18.0),
                child: AutoSizeText(
                  bloc.isDistributor()
                      ? bloc.userProfile?.distributorCompanyName ?? ''
                      : bloc.userProfile.name ?? '',
                  maxLines: 1,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: responsiveTextSize(19.0),
                      color: ColorResource.colorMarineBlue,
                      fontFamily: 'roboto',
                      fontWeight: FontWeight.w500),
                ),
              ),
              Text(
                "${bloc.isDistributor() ? 'DISTRIBUTOR' : bloc.userProfile.logInAs ?? " "} (${bloc.userProfile?.getUserStatus() ?? " "})",
                style: TextStyle(
                    fontSize: responsiveDefaultTextSize(),
                    color: ColorResource.colorMarineBlue,
                    fontFamily: 'roboto',
                    fontWeight: FontWeight.w300),
              ),
              SizedBox(
                height: 10.0,
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Visibility(
                      visible: bloc.isNormalUser(),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  translate(context, "txt_dob"),
                                  style: Styles.hintLabelBrownish,
                                ),
                                SizedBox(height: 5.0),
                                Text(
                                  bloc.userProfile?.dob == null
                                      ? translate(context, "txt_not_enter")
                                      : convertTimestampToDateTime(
                                          dateFormat: AppDateFormat,
                                          timestamp: bloc.userProfile.dob),
                                  style: Styles.brownishValueBlack,
                                )
                              ],
                            ),
                          ),
                          Visibility(
                            visible: bloc.isNormalUser(),
                            child: Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    bloc.userProfile?.nationalId == null
                                        ? translate(context, "passport_no")
                                        : translate(context, "txt_nid"),
                                    style: Styles.hintLabelBrownish,
                                  ),
                                  SizedBox(height: 5.0),
                                  Text(
                                    bloc.userProfile?.nationalId == null &&
                                            bloc.userProfile?.passportNumber ==
                                                null
                                        ? translate(context, "txt_not_enter")
                                        : bloc.userProfile?.nationalId ??
                                            bloc.userProfile?.passportNumber,
                                    style: Styles.brownishValueBlack,
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Visibility(
                        visible: bloc.isNormalUser(),
                        child: SizedBox(
                          height: 20,
                        )),
                    Row(
                      children: <Widget>[
                        Visibility(
                          visible: bloc.isNormalUser(),
                          child: Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  translate(context, "txt_dst"),
                                  style: Styles.hintLabelBrownish,
                                ),
                                SizedBox(height: 5.0),
                                Text(
                                  bloc.userProfile?.district ??
                                      translate(context, "txt_not_enter"),
                                  style: Styles.brownishValueBlack,
                                )
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                translate(context, "txt_mob"),
                                style: Styles.hintLabelBrownish,
                              ),
                              SizedBox(height: 5.0),
                              Text(
                                bloc.userProfile?.mobileNumber ??
                                    translate(context, "txt_not_enter"),
                                style: Styles.brownishValueBlack,
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      translate(context, "txt_email"),
                      style: Styles.hintLabelBrownish,
                    ),
                    SizedBox(height: 5.0),
                    Text(
                      bloc.userProfile?.email ??
                          translate(context, "txt_not_enter"),
                      style: Styles.brownishValueBlack,
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Visibility(
                            visible: bloc.isNormalUser(),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(
                                  height: 20.0,
                                ),
                                Text(
                                  translate(context, "txt_ref"),
                                  style: Styles.hintLabelBrownish,
                                ),
                                SizedBox(height: 5.0),
                                Text(
                                  isNullOrEmpty(bloc.userProfile?.referrelCode)
                                      ? translate(context, "txt_not_enter")
                                      : bloc.userProfile?.referrelCode,
                                  style: Styles.brownishValueBlack,
                                )
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Visibility(
                            visible: bloc.userProfile?.tradeLicenseExpiryDate !=
                                null,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(
                                  height: 20.0,
                                ),
                                Text(
                                  translate(context, "lic_exp_date"),
                                  style: Styles.hintLabelBrownish,
                                ),
                                SizedBox(height: 5.0),
                                Text(
                                  bloc.userProfile?.tradeLicenseExpiryDate ==
                                          null
                                      ? translate(context, "txt_not_enter")
                                      : convertTimestampToDateTime(
                                          dateFormat: AppDateFormat,
                                          timestamp: bloc.userProfile
                                              .tradeLicenseExpiryDate),
                                  style: Styles.brownishValueBlack,
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Divider(
                color: Colors.grey,
              ),
              InkWell(
                onTap: () {
                  navigateNextScreen(context, ChangePasswordScreen())
                      .then((value) {
                    if (value != null && value is ApiResponse) {
                      showSnackBar(scaffoldState.currentState, value.message);
                      _getProfile();
                    }
                  });
                },
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 20.0, top: 10.0, right: 20.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.lock_outline,
                        color: Colors.grey,
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Expanded(
                          child: Text(
                        translate(context, "txt_change_pwd"),
                        style: TextStyle(
                          fontSize: responsiveTextSize(18.0),
                          fontFamily: "roboto",
                          fontWeight: FontWeight.w300,
                        ),
                      )),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.grey,
                      )
                    ],
                  ),
                ),
              )
            ]),
      ),
      showLoader<ProfileBloc>(bloc),
    ];
  }

  _getProfile() {
    Prefs.getInt(Prefs.ROLE_ID).then((roleId) async {
      ApiResponse response = await bloc.getProfile(roleId);
      if ( !bloc.isApiError(response)) {
        isProfileUpdated = false;
        Provider.of<HomeBloc>(context, listen: false).profileInfo =
            bloc.userProfile;
      }
    });
  }
}
