import 'package:customer/core/localization/AppTranslation.dart';
import 'package:customer/data/local/db/goods_type.dart';
import 'package:customer/ui/dashboard/dashboard_filter_bloc.dart';
import 'package:customer/ui/widget/app_bar.dart';
import 'package:customer/ui/widget/app_button.dart';
import 'package:customer/ui/widget/editfield.dart';
import 'package:customer/utils/date_time_utils.dart';
import 'package:customer/utils/screen_dimension_utils.dart';
import 'package:customer/utils/ui_constant.dart';
import 'package:customer/utils/ui_utils.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class DashboardFilterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<DashboardFilterBloc>(
          create: (context) => DashboardFilterBloc(),
        )
      ],
      child: DashboardFilterPage(),
    );
  }
}

class DashboardFilterPage extends StatefulWidget {
  @override
  _DashboardFilterPageState createState() => _DashboardFilterPageState();
}

class _DashboardFilterPageState extends State<DashboardFilterPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  DashboardFilterBloc bloc;
  final fromDateEditController = TextEditingController(text: ' ');
  final toDateEditController = TextEditingController(text: ' ');
  final goodsTypeEditController = TextEditingController(text: ' ');

  @override
  void initState() {
    bloc = Provider.of<DashboardFilterBloc>(context, listen: false);
    bloc.getGoodsTypeList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (bloc == null)
      bloc = Provider.of<DashboardFilterBloc>(context, listen: false);

    return SafeArea(
      child: Scaffold(
          key: scaffoldKey,
          backgroundColor: ColorResource
              .semi_transparent_color_light, // this is the main reason of transparency at next screen. I am ignoring rest implementation but what i have achieved is you can see.
          appBar: AppBarWidget(
            title: translate(context, 'set_filter'),
            shouldShowBackButton: false,
            automaticallyImplyLeading: false,
            action: <Widget>[
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Padding(
                  padding:  EdgeInsets.only(right: responsiveSize(10.0)),
                  child: SvgPicture.asset(
                    'svg_img/ic_cancel.svg',
                    color: ColorResource.colorMarineBlue,
                    width: responsiveSize(20.0),
                  ),
                ),
              )
            ],
          ),
          body: Padding(
            padding: EdgeInsets.only(left: 25, right: 25, top: 10, bottom: 10),
            child: Wrap(
              children: <Widget>[
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    shape: BoxShape.rectangle,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        translate(context, 'filter_dashboard'),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: ColorResource.colorMarineBlue, fontSize: responsiveTextSize(16)),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(translate(context, 'date_range'),
                          style: TextStyle(
                              color: ColorResource.dark_gray, fontSize: responsiveTextSize(12))),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Expanded(
                            child: TextEditText(
                              labelText: translate(context, 'from').toUpperCase(),
                              textEditingController: fromDateEditController,
                              readOnly: true,
                              isFilterWidget: true,
                              fontSize: 12,
                              suffixIcon: Image.asset(
                                "images/calendar.png",
                                height: responsiveSize(10),
                                width: responsiveSize(10),

                              ),
                              onTap: () {
                                print("onTop");
                                showAppDatePicker(context,targetDateFormat: AppDateFormat,
                                    onSelected: (selectedDate) {
                                  fromDateEditController.text = getLocalizedFormattedDate(selectedDate,format: AppDateFormat);
                                  bloc.fromDate=selectedDate;
                                });
                              },
                              onChanged: (text)=>bloc.fromDate = text,
                            ),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Expanded(
                            child: TextEditText(
                              labelText: translate(context, 'to').toUpperCase(),
                              textEditingController: toDateEditController,
                              isFilterWidget: true,
                              readOnly: true,
                              fontSize: 12.0,
                              suffixIcon: Image.asset(
                                "images/calendar.png",
                                height: responsiveSize(10),
                                width: responsiveSize(10),
                              ),
                              onTap: () {
                                showAppDatePicker(context,targetDateFormat: AppDateFormat,
                                    onSelected: (selectedDate) {
                                  toDateEditController.text = getLocalizedFormattedDate(selectedDate,format: AppDateFormat);
                                  bloc.toDate = selectedDate;
                                });
                              },
                              onChanged: (text){
                                bloc.toDate = text;
                                },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Consumer<DashboardFilterBloc>(
                        builder: (context, bloc, _) => TextEditText<GoodsType>(
                          labelText: translate(context, 'lbl_goods_type'),
                          isFilterWidget: true,
                          isSearchableItemWidget: true,
                          suggestionDropDownItemList: bloc.goodsList,
                          searchDrodownCallback: (item) {
                            bloc.goodsTypeId=item.id;
                            bloc.goodsTypeText=item.text;
                            goodsTypeEditController.text = item.text;
                          },
                          textEditingController: goodsTypeEditController,
                        ),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      FilledColorButton(
                        buttonText: translate(context, 'clear_filter'),
                        innerPadding: 18,
                        fontWeight: FontWeight.normal,
                        verticalMargin: 7.0,
                        isFilled: false,
                        onPressed: () {
                          goodsTypeEditController.text=' ';
                          fromDateEditController.text=' ';
                          toDateEditController.text=' ';
                        },
                      ),
                      FilledColorButton(
                          buttonText: translate(context, 'filter'),
                          onPressed: () {
                            print(bloc.getQueryParamater());
                            Navigator.pop(context,bloc.getQueryParamater());
                          },
                          innerPadding: 18,
                          fontWeight: FontWeight.normal,
                          verticalMargin: 0.0),
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
