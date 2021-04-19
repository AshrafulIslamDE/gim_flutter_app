import 'package:customer/core/localization/AppTranslation.dart';
import 'package:customer/networking/api_response.dart';
import 'package:customer/ui/create_trip/repo/create_trip_repo.dart';
import 'package:customer/utils/screen_dimension_utils.dart';
import 'package:customer/utils/ui_constant.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import '../../styles.dart';
import 'app_bar.dart';
import 'create_trip_title_widget.dart';

class SearchList extends StatefulWidget {
  SearchList({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SearchState();
}

class _SearchState extends State<SearchList> {
  final key = GlobalKey<ScaffoldState>();
  final TextEditingController _searchQuery = TextEditingController();
  bool _isSearching = false;
  String _error;
  List _results = List();

  Timer debounceTimer;

  _SearchState() {
    _searchQuery.addListener(() {
      if (debounceTimer != null) {
        debounceTimer.cancel();
      }
      debounceTimer = Timer(Duration(milliseconds: 250), () {
        if (this.mounted && _searchQuery.text.length > 1) {
          performSearch(_searchQuery.text);
        }
      });
    });
  }

  void performSearch(String query) async {
    if (query.isEmpty) {
      setState(() {
        _isSearching = false;
        _error = null;
        _results = List();
      });
      return;
    }

    setState(() {
      _isSearching = true;
      _error = null;
      _results = List();
    });

    final response = await CreateTripRepo.lcNumber(query);
    if (this._searchQuery.text == query && this.mounted) {
      setState(() {
        _isSearching = false;
        if (response.status == Status.COMPLETED) {
          _results = response.data;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: key,
        appBar: AppBarWidget(
          title: translate(context, 'hint_lc_no'),
          shouldShowBackButton: true,
          action: <Widget>[
            Center(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 0.0),
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context, _searchQuery.text.toString());
                  },
                  child: Text(
                    translate(context, 'txt_done'),
                    style: TextStyle(
                        color: ColorResource.colorMarineBlue,
                        fontFamily: 'roboto',
                        fontSize: responsiveDefaultTextSize(),
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: new Column(children: <Widget>[
            new Padding(
              padding: new EdgeInsets.only(top: 20.0),
            ),
            TextField(
              autofocus: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.grey),
                ),
                alignLabelWithHint: true,
                hintText: AppTranslations.of(context).text('hint_search_lc'),
                hintStyle: Styles.hintTextStyle,
              ),
              controller: _searchQuery,
            ),
            buildBody(context)
          ]),
        ));
  }

  Widget buildBody(BuildContext context) {
    if (_isSearching) {
      return CenterTitle('Searching...');
    } else if (_error != null) {
      return CenterTitle(_error);
    } else {
      return Expanded(
        child: ListView.separated(
            separatorBuilder: (context, index) => Divider(
                  color: Colors.grey,
                ),
            itemCount: _results.length,
            itemBuilder: (BuildContext context, int index) => ListTile(
                  title: Text(
                    _results[index].toString(), style: TextStyle(fontSize: responsiveDefaultTextSize(),),
                  ),
                  onTap: () {
                    Navigator.pop(context, _results[index]);
                  },
                )),
      );
    }
  }
}

class CenterTitle extends StatelessWidget {
  final String title;

  CenterTitle(this.title);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        alignment: Alignment.center,
        child: Text(
          title,
          style: Theme.of(context).textTheme.body1,
          textAlign: TextAlign.center,
        ));
  }
}
