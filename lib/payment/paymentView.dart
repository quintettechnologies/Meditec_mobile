import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class PaymentView extends StatefulWidget {
  final url;

  PaymentView(this.url);

  @override
  _PaymentViewState createState() => _PaymentViewState();
}

class _PaymentViewState extends State<PaymentView> {
  var isloading = true;
  final Completer<InAppWebViewController> _completer =
      Completer<InAppWebViewController>();
  bool _isLoadingPage;

  @override
  void initState() {
    super.initState();

    _isLoadingPage = true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // if (searchFocus.hasFocus) {
        //   setState(() {
        //     searchFocus.unfocus();
        //   });
        // }
        Navigator.pop(context, "cancel");
        return true;
      },
      child: SafeArea(
        child: Scaffold(
          body: Stack(
            children: <Widget>[
              InAppWebView(
                onWebViewCreated: (InAppWebViewController webViewController) {
                  _completer.complete(webViewController);
                },
                onLoadStart: (InAppWebViewController controller, String url) {
                  setState(() {
                    _isLoadingPage = true;
                  });
                  if (url.split('/').contains("confirm") ||
                      url.split('/').contains("cancel") ||
                      url.split('/').contains("fail")) {
                    Navigator.pop(context, url);
                  }
                },
                onProgressChanged:
                    (InAppWebViewController controller, int url) {},
                onLoadStop: (InAppWebViewController controller, String url) {
                  setState(() {
                    _isLoadingPage = false;
                  });
                },
                initialUrl: '${widget.url}',
              ),
              _isLoadingPage
                  ? Center(child: CircularProgressIndicator())
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
