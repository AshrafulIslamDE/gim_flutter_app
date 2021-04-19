import 'dart:convert';

import 'package:customer/ui/widget/app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';

class LocalHtmlFile extends StatefulWidget {
  final title;
  final fileName;

  const LocalHtmlFile({Key key, this.title, this.fileName}) : super(key: key);

  @override
  _LocalHtmlFileState createState() => _LocalHtmlFileState();
}

class _LocalHtmlFileState extends State<LocalHtmlFile> {
  @override
  WebViewController _webViewController;

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(title: widget.title),
      body: new WebView(
        initialUrl: '',
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController webViewcontroller) {
          _webViewController = webViewcontroller;
          _loadLocalHTML();
        },
      ),
    );
  }

  _loadLocalHTML() async {
    String content = await rootBundle.loadString(widget.fileName);
    _webViewController.loadUrl(Uri.dataFromString(content,
            mimeType: 'text/ht'
                'ml',
            encoding: Encoding.getByName('utf-8'))
        .toString());
  }
}
