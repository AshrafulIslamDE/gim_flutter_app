import 'package:customer/core/localization/AppTranslation.dart';
import 'package:customer/ui/widget/app_bar.dart';
import 'package:customer/ui/widget/cupertino_button.dart';
import 'package:customer/utils/ui_constant.dart';
import 'package:customer/utils/ui_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'bloc/cancel_reason_bloc.dart';

class CancelReasonContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<CancelReasonBloc>(
            create: (_) => CancelReasonBloc()),
      ],
      child: CancelReasonPage(),
    );
  }
}

class CancelReasonPage extends StatefulWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  _CancelReasonIdState createState() => _CancelReasonIdState();
}

class _CancelReasonIdState extends State<CancelReasonPage> {
  CancelReasonBloc _mBloc;

  @override
  Widget build(BuildContext context) {
    _mBloc = Provider.of<CancelReasonBloc>(context);
    return Scaffold(
        key: widget._scaffoldKey,
        backgroundColor: Colors.white,
        appBar: AppBarWidget(
          title: translate(context, 'crp_ttl'),
          shouldShowBackButton: true,
        ),
        body: _mBloc.isLoading
            ? Container(
                child: Center(child: new CircularProgressIndicator()),
              )
            : Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      translate(context, 'crp_ctr'),
                      style: TextStyle(
                        color: ColorResource.colorMarineBlue,
                        fontSize: 24,
                        fontFamily: "roboto",
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Expanded(
                    child: ListView.separated(
                      separatorBuilder: (context, index) => Divider(
                        color: Colors.grey,
                      ),
                      itemCount: _mBloc.cancelReasons.length,
                      itemBuilder: (context, index) => Container(
                        child: ListTile(
                          title: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Expanded(
                                  flex: 1,
                                  child:
                                      Text(_mBloc.cancelReasons[index].toString())),
                              _mBloc.selectedIndex != null &&
                                      _mBloc.selectedIndex == index
                                  ? Icon(
                                      CupertinoIcons.check_mark,
                                      color: Colors.green,
                                      size: 36.0,
                                    )
                                  : SizedBox(
                                      width: 36.0,
                                    )
                            ],
                          ),
                          onTap: () => _mBloc.onSelected(index),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 26.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        IosButtonWidget(
                          text: translate(context, 'crp_ctt'),
                          textColor: ColorResource.marigold_two,
                          bgColor: ColorResource.colorMarineBlue,
                          containerWidth: 140.0,
                          callback: _onCancelTrip,
                        ),
                        IosButtonWidget(
                            text: translate(context, 'crp_ktt'),
                            textColor: ColorResource.colorMarineBlue,
                            bgColor: Colors.white,
                            containerWidth: 140.0,
                            callback: () => Navigator.of(context).pop())
                      ],
                    ),
                  )
                ],
              ));
  }

  _onCancelTrip() {
    if (_mBloc.selectedIndex == null) {
      showSnackBar(
          widget._scaffoldKey.currentState, translate(context, 'crp_ctr'));
      return;
    }
    Navigator.pop(
        context, _mBloc.cancelReason);
  }
}
