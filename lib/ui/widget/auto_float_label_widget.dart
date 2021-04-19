import 'dart:io';

import 'package:customer/styles.dart';
import 'package:customer/ui/widget/cupertino_picker_widget.dart';
import 'package:customer/ui/widget/dropdown.dart';
import 'package:customer/ui/widget/search_widget.dart';
import 'package:customer/ui/widget/searchable_list.dart';
import 'package:customer/utils/image_utils.dart';
import 'package:customer/utils/screen_dimension_utils.dart';
import 'package:customer/utils/ui_constant.dart';
import 'package:customer/utils/validationUtils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'auto_suggestion_widget.dart';

class AutoFloatLabelTextField<T> extends StatefulWidget {
  final List<T> items;
  final bool isDrop;
  final bool withImg;
  final String text;
  final int maxLines;
  final int maxLength;
  final bool readOnly;
  final bool isValidate;
  final String hintText;
  final bool borderLess;
  final String labelText;
  final String prefImgUrl;
  final Function callback;
  final bool searchFromApi;
  final bool startForResult;
  final bool onlyRightBorder;
  final String suffixImgPath;
  final TextInputType textInputType;
  final TextEditingController controller;
  final TextCapitalization textCapitalization;
  final List<TextInputFormatter> inputFormatter;
  final HexColor textColor = ColorResource.colorBlack;

   AutoFloatLabelTextField(this.controller,
      {this.labelText,
      @required this.hintText,
      this.suffixImgPath,
      this.maxLines,
      this.readOnly=false,
      this.isValidate = false,
      this.onlyRightBorder=false,
      this.borderLess=false,
      this.maxLength,
      this.items,
      this.callback,
      this.text,
      this.isDrop=false,
      this.prefImgUrl,
      this.withImg = false,
      this.searchFromApi = false,
      this.startForResult = false,
      this.textInputType = TextInputType.text,
      this.inputFormatter,
      this.textCapitalization=TextCapitalization.none});

  @override
  AutoFloatLabelTextFieldState createState() => AutoFloatLabelTextFieldState();
}

class AutoFloatLabelTextFieldState extends State<AutoFloatLabelTextField> {
  bool _autoValidate = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //This block has been commented to display goods type data on different screen.
    /*if( widget.isDrop && !Platform.isIOS) {
      return DropDownWidget(
        withImg: widget.withImg,
        dropDownItems: widget.items,
        hintText: widget.hintText,
        labelText: widget.labelText,
        onItemSelcted: widget.callback,
        isOnlyRightBorder: widget.onlyRightBorder,
      );
    }

    if(!Platform.isIOS && !widget.searchFromApi && widget.startForResult) {
    return  AutocompleteSuggestionWidget(labelText: widget.labelText,
        hintText: widget.hintText??"",
        suggestionList: widget.items,
        onSuggestionItemSelected: (item){
          widget.callback(item);
        },);

    }*/
    return Container(
      decoration:  !widget.onlyRightBorder
          ? null
          : BoxDecoration(
              border: Border(
                right: BorderSide(width: 1.0, color: ColorResource.brownish_grey),
              ),
            ),
      child: Stack(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top:responsiveSize(8.0),bottom: responsiveSize(8.0),left: widget.borderLess?responsiveSize(8.0):0),
            child: TextFormField(
              autocorrect: false,
              readOnly: widget.readOnly,
              maxLines: widget.maxLines,
              controller: widget.readOnly
                  ? TextEditingController.fromValue(TextEditingValue(
                      text: widget.text,
                      selection:
                          TextSelection.collapsed(offset: widget.text.length)))
                  : null,
              maxLength: widget.maxLength,
              inputFormatters: widget.inputFormatter,
              keyboardType: widget.textInputType,
              textCapitalization: widget.textCapitalization,
              style: TextStyle(
                  fontFamily: "roboto",
                  fontSize: responsiveTextSize(18.0),
                  color: widget.textColor),
              decoration: InputDecoration(
                  contentPadding: !widget.borderLess? getResponsiveDimension(DimensionResource.formFieldContentPadding) : null,
                  border: widget.borderLess != null && widget.borderLess
                      ? InputBorder.none
                      : OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(responsiveSize(6.0))),
                        ),
                  focusedBorder: widget.borderLess != null && widget.borderLess
                      ? InputBorder.none
                      : OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(responsiveSize(6.0))),
                          borderSide:
                              BorderSide(color: ColorResource.brownish_grey),
                        ),
                  alignLabelWithHint: true,
                  hintText: widget.hintText,
                  hintStyle: Styles.hintTextStyle,
                  suffixIcon:
                           widget.isDrop
                          ? Image.asset("images/ic_drop_down_arrow.png")
                          : null,
                  prefixIcon: widget.prefImgUrl == null
                      ? null
                      : Padding(
                          padding: EdgeInsets.all(responsiveSize(8.0)),
                          child: getNetworkImageProvider(
                                  url: widget.prefImgUrl,
                                  width: 32.0,
                                  height: 20.0),
                        )),
              onTap: () => (widget.callback == null || !widget.isDrop)
                  ? (widget.startForResult
                      ? _navigateAndDisplaySelection(context)
                      : null)
                  : _onTap(),
              onChanged: (text) {
                if (!widget.isDrop) {
                  widget.callback(text);
                  _autoValidate = text.isEmpty ? false : widget.isValidate;
                }
              },
              autovalidate: widget.isValidate && _autoValidate ? true : false,
              validator: widget.isValidate ? validateMobile : null,
              //_selectTime(context),
            ),
          ),
          widget.labelText == null
              ? SizedBox.shrink()
              : Positioned(
                  left: responsiveSize(20.0),
                  child: Container(
                      padding: EdgeInsets.only(left: responsiveSize(3.0), right: responsiveSize(3.0)),
                      color: ColorResource.colorWhite,
                      child: Text(
                        widget.labelText,
                        style: TextStyle(
                          color: ColorResource.labelColor,
                          fontSize: responsiveDefaultTextSize(),
                          fontFamily: "roboto",
                          fontWeight: FontWeight.w300,
                        ),
                      ))),
        ],
      ),
    );
  }

  _onTap() {
      showCupertinoModalPopup(
          context: context,
          builder: (BuildContext context) {
            return SpinnerWidget(
              items: widget.items,
              withImg: widget.withImg,
              onSelected: widget.callback,
            );
          });

  }

  _navigateAndDisplaySelection(BuildContext context) async {


    final result = await Navigator.push(
        context,
        CupertinoPageRoute(
            builder: (context) =>
                widget.searchFromApi ? SearchList() : SearchableListWidget(
                  title:widget.labelText ,
                  itemList: widget.items,
                )));
    if (result != null) widget.callback(result);
  }
}
