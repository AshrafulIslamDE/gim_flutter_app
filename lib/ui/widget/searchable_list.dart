import 'package:customer/styles.dart';
import 'package:customer/ui/widget/app_bar.dart';
import 'package:customer/utils/screen_dimension_utils.dart';
import 'package:flutter/material.dart';

class SearchableListWidget<T> extends StatefulWidget {
  String title;
  List<T> itemList;
  SearchableListWidget({this.title,this.itemList});

  @override
  _FilterableListWidgetState createState() => _FilterableListWidgetState();
}

class _FilterableListWidgetState extends State<SearchableListWidget> {
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
      appBar: AppBarWidget(title: widget.title,shouldShowBackButton: true,),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child:  Column(children: <Widget>[
             Padding(
              padding:  EdgeInsets.only(top: 5.0),
            ),
             TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.grey),
                ),
                alignLabelWithHint: true,
                hintText: widget.title,
                hintStyle: Styles.hintTextStyle,
              ),
              controller: controller,
            ),
             widget.itemList == null
                  ? Container()
                  : getFilteredList(widget.itemList),

          ]),
        ),
      ),
    );
  }

  Widget getFilteredList<T>(List<T> items) {
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
              filteredList[index].toString(),
              style: TextStyle(fontSize: responsiveDefaultTextSize()),
            ),
            onTap: () {
              Navigator.pop(context, filteredList[index]);
            },
          )),
    );
  }
}


