import 'package:customer/ui/create_trip/bloc/map_bloc.dart';
import 'package:customer/utils/ui_constant.dart';
import 'package:customer/utils/ui_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class AutocompleteTextField<T> extends StatefulWidget {
  final String value;
  void Function(T) onSuggestionItemSelected;
  var suggestionList = List<T>();
  var labelText = "";
  var hintText = "";
  var hasFocus = false;
  var typeAheadController = TextEditingController();
  final bool immediateSuggestion;
  final FocusNode focusNode;

  AutocompleteTextField(
      {Key key,
      this.onSuggestionItemSelected,
      this.suggestionList,
      this.hintText,
      this.labelText,
      this.value,
      this.focusNode,
      this.hasFocus,
      this.immediateSuggestion = true})
      : super(key: key);

  @override
  AutocompleteTextFieldState createState() => AutocompleteTextFieldState();
}

class AutocompleteTextFieldState extends State<AutocompleteTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20.0, left: 10.0, right: 10.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(4.0)),
        ),
        elevation: 8.0,
        margin: EdgeInsets.only(left: 10.0, right: 10.0),
        child: Theme(
          data: Theme.of(context).copyWith(
            primaryColor: ColorResource.colorBlack,
          ),
          child: TypeAheadField(
            hideOnLoading: true,
            hideOnEmpty: true,
            getImmediateSuggestions: widget.immediateSuggestion,
            textFieldConfiguration: TextFieldConfiguration(
              controller: widget.typeAheadController,
              focusNode: widget.focusNode,
              autofocus: widget.hasFocus,
              style: DefaultTextStyle.of(context).style.copyWith(
                  fontFamily: 'roboto',
                  fontWeight: FontWeight.w300,
                  color: ColorResource.colorMarineBlue,
                  fontSize: 20.0),
              decoration: InputDecoration(
                hintText: widget.hintText,
                suffixIcon: InkWell(
                  child: widget.focusNode.hasFocus
                      ? Icon(CupertinoIcons.clear, size: 40.0)
                      : Image.asset("images/ic_drop_down_arrow.png"),
                  onTap: () {
                    if(!widget.focusNode.hasFocus)return;
                    Future.delayed(Duration(milliseconds: 50)).then((_) {
                      setState(() {
                        this.widget.typeAheadController.clear();
                        hideSoftKeyboard(context);
                        widget.hasFocus = false;
                      });
                    });
                  },
                ),
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                contentPadding:
                    EdgeInsets.only(left: 15, bottom: 12, top: 12, right: 15),
              ),
            ),
            onSuggestionSelected: (suggestion) {
              widget.typeAheadController.text = suggestion?.toString();
              widget.onSuggestionItemSelected(suggestion);
            },
            itemBuilder: (context, suggestion) {
              print("suggestion" + suggestion.toString());
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  suggestion.toString(),
                  style: TextStyle(
                      fontFamily: 'roboto',
                      fontWeight: FontWeight.w300,
                      fontSize: 20.0,
                      color: ColorResource.colorMarineBlue),
                ),
              );
            },
            suggestionsCallback: (pattern) {
              return getSuggestions(pattern);
            },
            transitionBuilder: (context, suggestionsBox, controller) {
              return suggestionsBox;
            },
          ),
        ),
      ),
    );
  }

  getSuggestions(String query) {
    List matches = List();
    if(widget.suggestionList != null && widget.suggestionList.length > 0){
      var stringList = widget.suggestionList.map((f) => f).toList();
      matches.addAll(stringList);
      matches.retainWhere(
              (s) => s.toString().toLowerCase().contains(query.toLowerCase()));
    }
    return matches;
  }
}
