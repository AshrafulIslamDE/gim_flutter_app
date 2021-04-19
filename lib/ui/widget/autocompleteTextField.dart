import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class AutocompleteTextField<T> extends StatelessWidget{
  void Function(T) onSuggestionItemSelected;
  var
  suggestionList=List<T>();
  var labelText="";
  var hintText="";
  var controller=TextEditingController();
  AutocompleteTextField({Key key,this.onSuggestionItemSelected,this.suggestionList,this.hintText,this.labelText}):super(key:key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TypeAheadField(

        textFieldConfiguration: TextFieldConfiguration(
            autofocus: true,
            controller:  controller,

            decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: labelText,
                 hintText: hintText
            )

        ),
        onSuggestionSelected: (suggestion) {
          this.controller.text = suggestion;
          this.onSuggestionItemSelected(suggestion);
        },
        itemBuilder:(context,suggestion){
          print("suggestion"+suggestion.toString());
          return ListTile(
            title: Text(suggestion.toString()),
          );
        },

        suggestionsCallback:(pattern){
         return getSuggestions(pattern);
        },
      ),
    );
  }

  getSuggestions(String query)  {
    List<String> matches = List();
    var stringList=suggestionList.map((f)=>f.toString()).toList();
    matches.addAll(stringList);
    //print("length:"+matches.length.toString());
    matches.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
   // print("length:"+matches.length.toString());
    return matches;

  }
}


