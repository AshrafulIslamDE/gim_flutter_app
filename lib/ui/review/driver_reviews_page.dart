import 'package:customer/core/localization/AppTranslation.dart';
import 'package:customer/ui/review/item_driver_review.dart';
import 'package:customer/ui/widget/adapter.dart';
import 'package:customer/ui/widget/refresh_config_widget.dart';
import 'package:customer/utils/screen_dimension_utils.dart';
import 'package:customer/utils/ui_constant.dart';
import 'package:customer/utils/ui_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

import 'bloc/driver_reviews_bloc.dart';

class DriverReviewsScreen extends StatelessWidget {
  final int driverId;
  final String name;
  final String drvRating;
  final int reviewCount;

  DriverReviewsScreen(
      this.driverId, this.name, this.drvRating, this.reviewCount);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider<DriverReviewsBloc>(
          create: (context) => DriverReviewsBloc()),
    ], child: ReviewScreen(driverId, name, drvRating, reviewCount));
  }
}

class ReviewScreen extends StatefulWidget {
  final int driverId;
  final String name;
  final String drvRating;
  final int reviewCount;

  ReviewScreen(this.driverId, this.name, this.drvRating, this.reviewCount);

  @override
  _ReviewScreenState createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  DriverReviewsBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = Provider.of<DriverReviewsBloc>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((callback) async {
      bloc.driverId = widget.driverId;
      bloc.getListFromApi(callback: () {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: AppRefreshConfiguration(
        child: Scaffold(
          appBar: AppBar(

              backgroundColor: Colors.white,
              elevation: 0.0,
              centerTitle: true,
              iconTheme: IconThemeData(color: ColorResource.colorPrimary),
              leading: IconButton(
                onPressed: () => Navigator.maybePop(context),
                icon: Icon(Icons.arrow_back_ios,size: responsiveSize(24),),
              ),
              title: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    widget.name.toUpperCase(),
                    style: TextStyle(
                        color: ColorResource.colorPrimary,
                        fontWeight: FontWeight.bold,
                      fontSize: responsiveDefaultTextSize()
                    ),
                  ),
                ],
              ),
            bottom: PreferredSize(child: Container(child: _buildRating(widget.drvRating, widget.reviewCount),), preferredSize: Size.fromHeight(responsiveSize(20.0)),),
          ),
          body: Stack(
            children: <Widget>[
              Container(
                width: double.infinity,
                //color: Colors.white,
                child: Column(
                  children: [
                    getList<DriverReviewsBloc>(
                      bloc,
                      () => ReviewDriverItem(),
                      onItemClicked: (item) => {},
                    ),
                  ],
                ),
              ),
              showLoader<DriverReviewsBloc>(bloc),
            ],
          ),
        ),
      ),
    );
  }

  _buildRating(rating, ratingCount) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        RatingBarIndicator(
          itemCount: 5,
          rating: double.parse(rating),
          itemBuilder: (context, index) => Icon(
            Icons.star,
            color: ColorResource.colorMariGold,
          ),
          itemSize: responsiveSize(20),
        ),
        SizedBox(
          width: 15,
        ),
        Text(
          localize('number_decimal_count',dynamicValue: rating.toString(),symbol: "%f")
              + localize('number_count_bracket',dynamicValue: ratingCount.toString()),
          style: TextStyle(
              fontSize: responsiveDefaultTextSize(),
              fontFamily: 'roboto',
              fontWeight: FontWeight.w500,
              color: ColorResource.colorMarineBlue),
        )
      ],
    );
  }
}
