import 'dart:async';

import 'package:customer/ui/widget/app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class LoadLocalHtmlFile extends StatefulWidget{
  final title;
  final fileName;
  const LoadLocalHtmlFile({Key key, this.title, this.fileName}) :
        super(key: key);

  @override
  _LoadLocalHtmlFileState createState() =>
      _LoadLocalHtmlFileState();
}

class _LoadLocalHtmlFileState extends State<LoadLocalHtmlFile> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: _loadLocalHTML(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return WebviewScaffold(
            appBar: AppBarWidget(title: widget.title),
            withJavascript: true,
            appCacheEnabled: true,
            url: new Uri.dataFromString(snapshot.data, mimeType: 'text/html')
                .toString(),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text("${snapshot.error}"),
            ),
          );
        }
        return Scaffold(
          body: Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Future<String> _loadLocalHTML() async {
    return await rootBundle.loadString(widget.fileName);
  }
}


