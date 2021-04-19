import 'package:flutter/material.dart';
import 'package:flutter_typeahead/cupertino_flutter_typeahead.dart';

class GooglePlaceAutocompleteTextField<T> extends StatelessWidget {
  void Function(T) onSuggestionItemSelected;
  var suggestionList = List<T>();
  var labelText = "";
  var hintText = "";
  final TextEditingController controller = TextEditingController();
  final CupertinoSuggestionsBoxController _suggestionsBoxController =
      CupertinoSuggestionsBoxController();

  GooglePlaceAutocompleteTextField(
      {Key key,
      this.onSuggestionItemSelected,
      this.suggestionList,
      this.hintText,
      this.labelText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: CupertinoTypeAheadFormField(
        getImmediateSuggestions: true,
        suggestionsBoxController: _suggestionsBoxController,
        textFieldConfiguration: CupertinoTextFieldConfiguration(
          controller: controller,
        ),
        onSuggestionSelected: (suggestion) {
          this.controller.text = suggestion;
          this.onSuggestionItemSelected(suggestion);
        },
        itemBuilder: (context, suggestion) {
          print("suggestion" + suggestion.toString());
          return Material(
            child: ListTile(
              title: Text(suggestion.toString()),
            ),
          );
        },
        suggestionsCallback: (pattern) {
          return getSuggestions(pattern);
        },
        validator: (value) {
          if (value.isEmpty) {
            return 'Please select a city';
          }
          return "";
        },
      ),
    );
  }

  getSuggestions(String query) {
    List<String> matches = List();
    var stringList = suggestionList.map((f) => f.toString()).toList();
    matches.addAll(stringList);
    //print("length:"+matches.length.toString());
    matches.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
    // print("length:"+matches.length.toString());
    return matches;
  }
}
