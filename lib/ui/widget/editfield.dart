import 'dart:io';

import 'package:customer/ui/widget/auto_suggestion_widget.dart';
import 'package:customer/ui/widget/dropdown.dart';
import 'package:customer/ui/widget/searchable_list.dart';
import 'package:customer/utils/common_utils.dart';
import 'package:customer/utils/screen_dimension_utils.dart';
import 'package:customer/utils/ui_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart';
import 'package:html/dom.dart' as dom;

class TextEditText<T> extends StatefulWidget {
  var hintText = "";
  var labelText = "";
  TextEditingController textEditingController;
  var keyboardType;
  bool obscured = false;
  Map<String, String> validationMessageRegexPair;
  var enableBorderColor;
  var focusedBorderColor;
  var textColor;
  var maxlength;
  var fontWeight;
  var textAlign;
  bool isOptionalFieldWithValidation;
  bool readOnly;
  Widget suffixIcon;
  ValueChanged<String> onChanged;
  var onTap;
  var verticalPad;
  Color suffixIconColor;
  String errorText;
  bool isFilterWidget;

  //dropdown or autosuggestion item list
  List<T> suggestionDropDownItemList;
  bool isSearchableItemWidget;
  Function searchDrodownCallback;
  final hintTextColor;
  final labelTextColor;
  final double fontSize;
  final labelTextBgColor;
  final behaveNormal;
  GlobalKey<FormState> formkey;
  final bool isHtmlText;
  final int errorMaxLines;
  final isDropDown;
  final withImg;
  final TextCapitalization textCapitalization;

  TextEditText(
      {Key key,
      @required this.labelText,
      this.hintText,
      this.textEditingController,
      this.keyboardType = TextInputType.text,
      this.suggestionDropDownItemList,
      this.isOptionalFieldWithValidation = false,
      this.obscured = false,
      this.isFilterWidget = false,
      this.isSearchableItemWidget = false,
      this.validationMessageRegexPair,
      this.enableBorderColor = ColorResource.colorLightBlueGrey,
      this.textColor = Colors.black,
      this.focusedBorderColor = ColorResource.colorLightBlueGrey,
      this.maxlength,
      this.readOnly = false,
      this.textAlign = TextAlign.left,
      this.suffixIcon,
      this.onChanged,
      this.fontSize = 14.0,
      this.searchDrodownCallback,
      this.onTap,
      this.suffixIconColor = ColorResource.colorLightBlueGrey,
      this.errorText,
      this.formkey,
      this.fontWeight,
      this.verticalPad = DimensionResource.formFieldContentPadding,
      this.hintTextColor = ColorResource.colorLightBlueGrey,
      this.labelTextBgColor = Colors.white,
      this.labelTextColor = ColorResource.brownish_grey,
      this.behaveNormal = false,
      this.isHtmlText = false,
      this.errorMaxLines = 2,
      this.isDropDown = false,
      this.withImg = false,
      this.textCapitalization = TextCapitalization.none})
      : super(key: key) {
    if (this.isSearchableItemWidget) this.readOnly = true;
  }

  @override
  State<StatefulWidget> createState() => _TextEditText<T>();
}

class _TextEditText<T> extends State<TextEditText> {
  TextFieldBloc rootBloc;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((callback) {
      if (widget.onTap != null && !widget.isSearchableItemWidget)
        widget.textEditingController?.addListener(() {
          //   print("edittext:"+widget.textEditingController.text);
          if (!isNullOrEmpty(widget.textEditingController.text))
            rootBloc.currentText = widget.textEditingController.text;
        });
    });

    super.initState();
  }

  @override
  void dispose() {
    // widget.textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.textEditingController != null && !widget.readOnly)
      widget.textEditingController.selection = TextSelection.collapsed(
          offset: widget.textEditingController.text.length);

    if (!Platform.isIOS && widget.isSearchableItemWidget) {
      return AutocompleteSuggestionWidget(
        labelText: widget.labelText,
        hintText: widget.hintText ?? "",
        suggestionList: widget.suggestionDropDownItemList,
        onSuggestionItemSelected: (item) {
          widget.searchDrodownCallback(item);
          widget.formkey?.currentState?.validate();
        },
      );
    }

    if (widget.isDropDown && !Platform.isIOS) {
      return DropDownWidget(
        withImg: widget.withImg,
        dropDownItems: widget.suggestionDropDownItemList,
        hintText: widget.hintText,
        labelText: widget.labelText,
        onItemSelcted: widget.searchDrodownCallback,
      );
    }
    return ChangeNotifierProvider<TextFieldBloc>(
      create: (context) => TextFieldBloc(widget.validationMessageRegexPair,
          widget.obscured, widget.isOptionalFieldWithValidation),
      child: Padding(
        padding:
            EdgeInsets.fromLTRB(0, responsiveSize(8.0), 0, responsiveSize(8.0)),
        child: Consumer<TextFieldBloc>(
          builder: (context, bloc, _) {
            rootBloc = bloc;
            return Stack(
              alignment: Alignment.topLeft,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: responsiveSize(6.0)),
                  child: TextFormField(
                    maxLines: 1,
                    textAlign: widget.textAlign,
                    onTap: () {
                      if (widget.isSearchableItemWidget)
                        buildSearchableItemComponent<T>(bloc);
                      else if (widget.onTap != null) {
                        widget.onTap();
                      }
                    },
                    keyboardType: widget.keyboardType,
                    inputFormatters: widget.keyboardType == TextInputType.number
                        ? <TextInputFormatter>[
                            WhitelistingTextInputFormatter.digitsOnly
                          ]
                        : null,
                    controller: widget.textEditingController,
                    obscureText: bloc.passwordVisible,
                    readOnly: widget.readOnly,
                    validator: (value) {
                      if (widget.textEditingController != null) {
                        bloc.currentText = widget.textEditingController.text;
                      }
                      if (isNullOrEmpty(bloc.currentText)) {
                        // print("validate");
                        bloc.currentText = "";
                      }
                      return bloc.errorText;
                    },
                    onChanged: (text) {
                      // print("onchange");
                      bloc.currentText = text;
                      if (widget.onChanged != null) widget.onChanged(text);
                      widget.formkey?.currentState?.validate();
                    },
                    textCapitalization: widget.textCapitalization,
                    decoration: InputDecoration(
                      errorMaxLines: widget.errorMaxLines,
                      errorStyle:
                          TextStyle(fontSize: responsiveDefaultTextSize()),

                      contentPadding: !widget.isFilterWidget
                          ? getResponsiveDimension(
                              widget.verticalPad)
                          : getResponsiveDimension(
                              DimensionResource.filterFormFieldContentPadding),
                      enabledBorder: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(responsiveSize(8.0)),
                        borderSide: BorderSide(
                          color: widget.enableBorderColor,
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(responsiveSize(8.0)),
                      ),
                      counterText: '',
                      labelText: widget.behaveNormal
                          ? widget.labelText.toUpperCase()
                          : null,
                      hintText: widget.hintText,
                      hintStyle: TextStyle(
                          color: widget.hintTextColor,
                          fontSize: responsiveDefaultTextSize()),
                      errorText: widget.errorText ?? bloc.errorText,
                      suffixIcon: widget.obscured
                          ? IconButton(
                              padding:
                                  EdgeInsets.only(right: responsiveSize(20.0)),
                              icon: Icon(
                                bloc.passwordVisible
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: widget.suffixIconColor,
                                size: responsiveSize(24.0),
                              ),
                              onPressed: () {
                                bloc.passwordVisible = !bloc.passwordVisible;
                              },
                            )
                          : widget.suffixIcon ?? null,
                      fillColor: ColorResource.colorWhite,
                      focusedBorder: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(responsiveSize(8.0)),
                        borderSide: BorderSide(
                          color: widget.focusedBorderColor,
                        ),
                      ),
                      labelStyle: TextStyle(
                          color: widget.labelTextColor,
                          fontFamily: 'roboto',
                          fontWeight: FontWeight.w400,
                          fontSize: responsiveTextSize(13.0)),

                      // suffixIcon: Icon(Icons.airplay),
                    ),
                    style: TextStyle(
                        color: widget.textColor,
                        fontSize: responsiveTextSize(widget.fontSize),
                        fontWeight: widget.fontWeight),
                    maxLength: widget.maxlength,
                  ),
                ),
                Visibility(
                  visible: !widget.behaveNormal,
                  child: Positioned(
                      left: responsiveSize(10.0),
                      child: Container(
                          padding: EdgeInsets.only(
                              left: responsiveSize(4.0),
                              right: responsiveSize(4.0)),
                          color: widget.labelTextBgColor,
                          child: !widget.isHtmlText
                              ? Text(
                                  widget.labelText.toUpperCase(),
                                  style: TextStyle(
                                    color: widget.labelTextColor,
                                    fontSize: responsiveTextSize(13.0),
                                    fontFamily: "roboto",
                                    fontWeight: FontWeight.w400,
                                  ),
                                )
                              : Html(
                                  shrinkToFit: true,
                                  blockSpacing: 0.0,
                                  padding: EdgeInsets.all(0.0),
                                  defaultTextStyle: TextStyle(
                                      color: widget.labelTextColor,
                                      fontSize: responsiveTextSize(13.0)),
                                  data: widget.labelText?.toUpperCase(),
                                  customTextStyle:
                                      (dom.Node node, TextStyle baseStyle) {
                                    if (node is dom.Element) {
                                      switch (node.localName) {
                                        case "big":
                                          return baseStyle.merge(TextStyle(
                                              height: 0,
                                              fontSize:
                                                  responsiveTextSize(21.0)));
                                      }
                                    }
                                    return baseStyle;
                                  }))),
                ),
              ],
            );
          },
        ),
      ),
    );
    /*    return widget.onTap==null? contentWidget:GestureDetector(
      onTap: widget.onTap,
      child: AbsorbPointer( absorbing: true,child: contentWidget),
    );*/
  }

  buildSearchableItemComponent<T>(TextFieldBloc bloc) async {
    print(widget.suggestionDropDownItemList.length);
    T result = await Navigator.push<T>(
        context,
        CupertinoPageRoute(
            builder: (context) => SearchableListWidget<T>(
                  title: widget.labelText,
                  itemList: widget.suggestionDropDownItemList,
                )));
    print("result:" + result.toString());
    if (result != null) {
      bloc.currentText = result.toString();
      widget.searchDrodownCallback(result);
      widget.formkey?.currentState?.validate();
    }
  }
}

class TextFieldBloc with ChangeNotifier {
  var _isRequiredTextField = false;
  String _currentText = "";
  String _errorText = null;
  bool _passwordVisible = false;
  bool _isOptionalFieldWithValidation = false;

  bool get passwordVisible => _passwordVisible;

  set passwordVisible(bool value) {
    _passwordVisible = value;
    notifyListeners();
  }

  get isRequiredTextField => _isRequiredTextField;

  set isRequiredTextField(value) {
    _isRequiredTextField = value;
  }

  Map<String, String> validationMessageRegexPair;

  get errorText => _errorText;

  set errorText(value) {
    _errorText = value;
  }

  TextFieldBloc(this.validationMessageRegexPair, this._passwordVisible,
      this._isOptionalFieldWithValidation) {
    if (validationMessageRegexPair != null &&
        validationMessageRegexPair.length > 0) _isRequiredTextField = true;
  }

  get currentText => _currentText;

  set currentText(value) {
    _currentText = value;
    bool isValid = true;
    // print("notify");
    if (_isRequiredTextField) {
      if (_isOptionalFieldWithValidation && value.toString().isEmpty) {
        removeErrorMsg();
      } else {
        for (String key in validationMessageRegexPair.keys) {
          RegExp regex = RegExp(key);
          // print("key: "+key);
          // print("value"+value);
          if (!regex.hasMatch(value)) {
            isValid = false;
            _errorText = validationMessageRegexPair[key];
            notifyListeners();
            break;
          }
        }

        if (isValid) {
          removeErrorMsg();
          // print("notify error dismiss");
        }
      }
    }
  }

  removeErrorMsg() {
    if (_errorText != null && _errorText.isNotEmpty) {
      // print("errormessage removed");
      _errorText = null;
      notifyListeners();
    }
  }
}
