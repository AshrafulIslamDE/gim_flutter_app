import 'package:customer/core/localization/AppTranslation.dart';
import 'package:customer/data/local/db/goods_type.dart';
import 'package:customer/ui/widget/bloc/filterable_list_bloc.dart';
import 'package:customer/utils/screen_dimension_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../styles.dart';
import 'create_trip_title_widget.dart';

class FilterableListWidget extends StatefulWidget {
  @override
  _FilterableListWidgetState createState() => _FilterableListWidgetState();
}

class _FilterableListWidgetState extends State<FilterableListWidget> {
  TextEditingController controller = new TextEditingController();
  String filter;

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      setState(() {
        filter = controller.text;
      });
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CreateTripHeader(
        isShowBackButton: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: new Column(children: <Widget>[
          new Padding(
            padding: new EdgeInsets.only(top: 20.0),
          ),
          new TextField(
            autofocus: true,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.grey),
              ),
              alignLabelWithHint: true,
              hintText: AppTranslations.of(context).text("lbl_goods_type"),
              hintStyle: Styles.hintTextStyle,
            ),
            controller: controller,
            style: TextStyle(fontSize: responsiveDefaultTextSize(),),
          ),
          ChangeNotifierProvider<FilterableListBloc>(
            create: (context) => FilterableListBloc(),
            child: Consumer<FilterableListBloc>(
              builder: (context, bloc, _) => bloc.items == null
                  ? Container()
                  : getFilteredList(bloc.items),
            ),
          )
        ]),
      ),
    );
  }

  Widget getFilteredList(List<GoodsType> items) {
    List filteredList = items
        .where((item) =>
    filter != null &&
        filter != '' &&
        item.toString().toLowerCase().contains(filter.toLowerCase()))
        .toList();
    if (filter == null || filter.trim().length == 0) filteredList = items;
    return Expanded(
      child: ListView.separated(
          separatorBuilder: (context, index) => Divider(
            color: Colors.grey,
          ),
          itemCount: filteredList.length,
          itemBuilder: (BuildContext context, int index) => ListTile(
            title: Text(
              filteredList[index].toString(), style: TextStyle(fontSize: responsiveDefaultTextSize()),
            ),
            onTap: () {
              Navigator.pop(context, items.indexOf(filteredList[index]));
            },
          )),
    );
  }
}