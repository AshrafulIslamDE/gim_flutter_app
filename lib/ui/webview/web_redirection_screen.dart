import 'dart:async';

import 'package:customer/ui/widget/app_bar.dart';
import 'package:customer/flavor/flavor_config.dart';
import 'package:customer/ui/widget/base_widget.dart';
import 'package:customer/ui/widget/caller_layout.dart';
import 'package:customer/utils/screen_dimension_utils.dart';
import 'package:customer/utils/ui_constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';


class WebRedirectionScreen extends StatefulWidget{
  final String webViewUrl;
  final title;
  const WebRedirectionScreen({Key key, this.webViewUrl, this.title}) : super(key: key);

  @override
  _WebRedirectionScreenState createState() => _WebRedirectionScreenState();
}

class _WebRedirectionScreenState extends State<WebRedirectionScreen> {
  WebViewController _controller;
  bool shoudlShowLoader=true;
  onPageFinished(){
      Future.delayed(const Duration(milliseconds: 400), () {
        if(mounted)
        setState(() {
          shoudlShowLoader=false;
        });

    });

  }
  @override
  Widget build(BuildContext context) {
    final url=FlavorConfig.instance.values.baseUrl+widget.webViewUrl;
    print("url"+url);
    return Scaffold(
      appBar: AppBarWidget(title: widget.title,),

      body: Stack(
        children: <Widget>[

          WebView(
            initialUrl: url,
          javascriptMode: JavascriptMode.unrestricted,
           onPageFinished:(url)=> onPageFinished(),


          ),
         showLoader(),
          Visibility(
            visible: false,
            child: networkErrorWithRetry(context, (){

            }),
          ),
          Positioned(bottom:1,right: 10,child: CallerWidget(autoAlignment: false,)),

        ],
      ),
    );

  }
  showLoader(){
    return Center(
      child:  Visibility(
              visible: shoudlShowLoader,
              child: SizedBox(
                width: responsiveSize(40),
                height: responsiveSize(40),
                child: CircularProgressIndicator(
                  backgroundColor: ColorResource.colorMarineBlue,
                ),
              )),
    );
  }
}

