import 'package:customer/data/repository/google_repository.dart';
import 'package:customer/styles.dart';
import 'package:customer/ui/create_trip/bloc/map_bloc.dart';
import 'package:customer/utils/common_utils.dart';
import 'package:customer/utils/screen_dimension_utils.dart';
import 'package:customer/utils/ui_constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class GooglePlacesSearchWidget<T> extends StatefulWidget {
  final String value;
  var labelText = "";
  var hintText = "";
  final bool isSrc;
  final MapBloc bloc;
  final FocusNode focusNode;
  final typeAheadController;
  var suggestionList = List<T>();
  final bool immediateSuggestion;
  final void Function(bool) callBack;
  void Function(T) onSuggestionItemSelected;

  GooglePlacesSearchWidget(
      {Key key,
      this.onSuggestionItemSelected,
      this.suggestionList,
      this.hintText,
      this.labelText,
      this.value,
      this.isSrc,
      this.bloc,
      this.callBack,
      this.focusNode,
      this.typeAheadController,
      this.immediateSuggestion = true})
      : super(key: key);

  @override
  GooglePlacesSearchWidgetState createState() =>
      GooglePlacesSearchWidgetState();
}

class GooglePlacesSearchWidgetState extends State<GooglePlacesSearchWidget> {
  @override
  void initState() {
    super.initState();
    widget.focusNode.addListener(() {
      if (widget.focusNode.hasFocus) widget.callBack(widget.isSrc);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          top: responsiveSize(10.0),
          left: responsiveSize(10.0),
          right: responsiveSize(10.0)),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(responsiveSize(4.0))),
        ),
        elevation: responsiveSize(8.0),
        margin: EdgeInsets.only(
            left: responsiveSize(10.0), right: responsiveSize(10.0)),
        child: Theme(
          data: Theme.of(context).copyWith(
            primaryColor: ColorResource.colorBlack,
          ),
          child: TypeAheadField(
            hideOnLoading: true,
            hideOnEmpty: true,
            hideOnError: true,
            getImmediateSuggestions: widget.immediateSuggestion,
            textFieldConfiguration: TextFieldConfiguration(
              controller: widget.typeAheadController,
              autofocus: true,
              focusNode: widget.focusNode,
              style: DefaultTextStyle.of(context).style.copyWith(
                  fontFamily: 'roboto',
                  fontWeight: FontWeight.w300,
                  color: ColorResource.colorBlack,
                  fontSize: responsiveTextSize(20.0)),
              cursorColor: ColorResource.colorBlack,
              decoration: InputDecoration(
                hintText: widget.hintText,
                hintStyle: Styles.mapHintTextStyle,
                suffixIcon: InkWell(
                  child: Icon(
                    CupertinoIcons.clear,
                    size: responsiveSize(40.0),
                  ),
                  onTap: () {
                    widget.isSrc
                        ? widget.bloc.selCoordinates[MapBloc.pickUp] = null
                        : widget.bloc.selCoordinates[MapBloc.dropOff] = null;
                    widget.callBack(widget.isSrc);
                    Future.delayed(Duration(milliseconds: 50)).then((_) {
                      this.widget.typeAheadController.clear();
                    });
                  },
                ),
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                contentPadding: EdgeInsets.only(
                    left: responsiveSize(10.0),
                    top: responsiveSize(10.0),
                    right: responsiveSize(10.0)),
              ),
            ),
            onSuggestionSelected: (suggestion) {
              this.widget.typeAheadController.text =
                  suggestion.toString() == TextConst.CURRENT_LOCATION
                      ? ''
                      : suggestion.lat == null ? suggestion.toString() : suggestion.address;
              this.widget.onSuggestionItemSelected(suggestion);
            },
            itemBuilder: (context, suggestion) {
              print("suggestion" + suggestion.toString());
              return Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Colors.grey),
                  ),
                ),
                child: ListTile(
                  leading: Icon(suggestion.iconData, color: Colors.grey),
                  title: Text(
                    suggestion.toString(),
                    style: TextStyle(
                        fontFamily: 'roboto',
                        fontWeight: FontWeight.w300,
                        fontSize: 20.0,
                        color: ColorResource.colorMarineBlue),
                  ),
                ),
              );
            },
            suggestionsCallback: (pattern) async{
              return GoogleRepository.getPlaceSearchResult(pattern);
            },
            transitionBuilder: (context, suggestionsBox, controller) {
              return suggestionsBox;
            },
          ),
        ),
      ),
    );
  }
}
