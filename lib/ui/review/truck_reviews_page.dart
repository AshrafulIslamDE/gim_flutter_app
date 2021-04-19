import 'package:customer/core/localization/AppTranslation.dart';
import 'package:customer/model/review/truck_review_response.dart';
import 'package:customer/ui/review/bloc/truck_reviews_bloc.dart';
import 'package:customer/ui/review/item_truck_review.dart';
import 'package:customer/ui/widget/adapter.dart';
import 'package:customer/ui/widget/app_bar.dart';
import 'package:customer/ui/widget/refresh_config_widget.dart';
import 'package:customer/utils/ui_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TruckReviewsScreen extends StatelessWidget {
  final int truckId;

  TruckReviewsScreen(this.truckId);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider<TruckReviewsBloc>(
          create: (context) => TruckReviewsBloc()),
    ], child: ReviewScreen(truckId));
  }
}

class ReviewScreen extends StatefulWidget {
  final int truckId;

  ReviewScreen(this.truckId);

  @override
  _ReviewScreenState createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  TruckReviewsBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = Provider.of<TruckReviewsBloc>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((callback) async {
      bloc.truckId = widget.truckId;
      bloc.getListFromApi(callback: () {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: AppRefreshConfiguration(
          child: Scaffold(
              appBar: AppBarWidget(title: localize('truck_review')),
              body: Stack(children: <Widget>[
                Container(
                  width: double.infinity,
                  //color: Colors.white,
                  child: Column(
                    children: [
                      getList<TruckReviewsBloc>(
                        bloc,
                        () => ReviewTruckItem(),
                      ),
                    ],
                  ),
                ),
                showLoader<TruckReviewsBloc>(bloc),
              ])),
        ));
  }
}
