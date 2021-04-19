import 'package:customer/utils/common_utils.dart';
import 'package:customer/utils/screen_dimension_utils.dart';
import 'package:customer/utils/ui_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class AutocompleteSuggestionWidget<T> extends StatefulWidget {
  void Function(T) onSuggestionItemSelected;
  var suggestionList = List<T>();
  var labelText = "";
  var hintText = "";
  final labelTextColor;
  final double fontSize;
  final labelTextBgColor;
  final borderColor;
  final textColor;
  AutocompleteSuggestionWidget(
      {Key key,
      this.onSuggestionItemSelected,
      this.labelTextColor = ColorResource.brownish_grey,
      this.labelTextBgColor = Colors.white,
      this.labelText,
      this.fontSize = 14.0,
      this.hintText,
      this.textColor = Colors.black,
      this.borderColor = ColorResource.brownish_grey,
      this.suggestionList})
      : super(key: key);

  @override
  _AutocompleteTextFieldState createState() => _AutocompleteTextFieldState();
}

class _AutocompleteTextFieldState<T>
    extends State<AutocompleteSuggestionWidget<T>> {
  var controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final borderLayout= OutlineInputBorder(
      borderRadius: BorderRadius.circular(responsiveSize(8.0)),
      borderSide: BorderSide(
        color: widget.borderColor,
      ),
    );
    return Stack(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top:10),
          child: TypeAheadField(
            getImmediateSuggestions: true,
            hideSuggestionsOnKeyboardHide: false,
            autoFlipDirection: true,
            textFieldConfiguration: TextFieldConfiguration(
              autofocus: false,
              controller: controller,
              style: TextStyle(
                  color: Colors.black, fontSize: responsiveDefaultTextSize()),
              decoration: InputDecoration(
                  enabledBorder: borderLayout,
                  border: borderLayout,
                  disabledBorder:borderLayout,
                  focusedBorder: borderLayout,
                  contentPadding: getResponsiveDimension(DimensionResource.formFieldContentPadding),
                  hintText: widget.hintText),

            ),

            onSuggestionSelected: (suggestion) {
              this.controller.text = suggestion.toString();
              if (widget.onSuggestionItemSelected != null)
                this.widget.onSuggestionItemSelected(suggestion);
            },
            itemBuilder: (context, suggestion) {
              return ListTile(
                title: Text(suggestion.toString()),
              );
            },
            suggestionsCallback: (pattern) {
              return getSuggestions(pattern);
            },
          ),
        ),
        Visibility(
          visible: !isNullOrEmpty(widget.labelText),
          child: Positioned(
              left: responsiveSize(15.0),
              top: 3,
              child: Container(
                  padding: EdgeInsets.only(
                      left: responsiveSize(4.0), right: responsiveSize(4.0)),
                  color: widget.labelTextBgColor,
                  child: Text(
                    widget.labelText == null
                        ? ""
                        : widget.labelText.toUpperCase(),
                    style: TextStyle(
                      color: widget.labelTextColor,
                      fontSize: responsiveTextSize(12.0),
                      fontFamily: "roboto",
                      fontWeight: FontWeight.w400,
                    ),
                  ))),
        )
      ],
    );
  }

  getSuggestions<T>(String query) {
    if(isNullOrEmptyList(widget.suggestionList)) return;
    var matches = widget.suggestionList.map((f)=>(f)).toList();
    matches.retainWhere((s) => s.toString().toLowerCase().contains(query.toLowerCase()));
    return matches;
  }
}
