import 'package:customer/core/localization/AppTranslation.dart';
import 'package:customer/flavor/flavor_config.dart';
import 'package:customer/ui/payment/pay_response.dart';
import 'package:customer/ui/widget/app_bar.dart';
import 'package:customer/ui/widget/navigation_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PayScreen extends StatefulWidget {
  final String webViewUrl;
  final String authToken;
  final title;

  const PayScreen({Key key, this.webViewUrl, this.authToken, this.title}) : super(key: key);

  @override
  _PayScreenState createState() => _PayScreenState();
}

class _PayScreenState extends State<PayScreen> {
  static final bCashPaymentSuccess =
      "${FlavorConfig.instance.values.baseUrl}/customerpayment/success.html";
  static final bCashPaymentFailure =
      '${FlavorConfig.instance.values.baseUrl}/customerpayment/error.html';

  onPageFinished() {
    print('Page download finish...');
  }

  @override
  Widget build(BuildContext context) {
    final url = widget.webViewUrl;
    print("url: $url");
    return Scaffold(
      appBar: AppBarWidget(
        title: widget.title,
      ),
      body: WebView(
        initialUrl: url,
        javascriptMode: JavascriptMode.unrestricted,
        onPageFinished: (url) => onPageFinished(),
        onWebViewCreated: (controller){
          controller.loadUrl(url,headers: {'authtoken':widget.authToken});
        },
        navigationDelegate: (action) async{
          print(action.url);
          if(action.url.startsWith(bCashPaymentSuccess)){
            await navigateNextScreen(context, PayResponse(translate(context, 'pay_com'),action.url));
            Navigator.pop(context,true);
          }else if(action.url.startsWith(bCashPaymentFailure)){
            await navigateNextScreen(context, PayResponse(translate(context, 'pay_err'),action.url));
            Navigator.pop(context,true);
          }
          return NavigationDecision.navigate;
        },
      ),
    );
  }
}
