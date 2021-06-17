import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
// import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentView extends StatefulWidget {
  final url;

  PaymentView(this.url);

  @override
  _PaymentViewState createState() => _PaymentViewState();
}

class _PaymentViewState extends State<PaymentView> {
  var isloading = true;
  // final Completer<InAppWebViewController> _completer =
  //     Completer<InAppWebViewController>();
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();
  bool _isLoadingPage;

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
    _isLoadingPage = true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context, "cancel");
        return true;
      },
      child: SafeArea(
        child: Scaffold(
          body: Stack(
            children: <Widget>[
              WebView(
                initialUrl: '${widget.url}',
                onPageStarted: (url) {
                  setState(() {
                    _isLoadingPage = true;
                  });
                  if (url.split('/').contains("confirm") ||
                      url.split('/').contains("cancel") ||
                      url.split('/').contains("fail")) {
                    Navigator.pop(context, url);
                  }
                },
                navigationDelegate: (NavigationRequest request) {
                  return NavigationDecision.navigate;
                },
                onPageFinished: (url) {
                  setState(() {
                    _isLoadingPage = false;
                  });
                },
                gestureNavigationEnabled: true,
                javascriptMode: JavascriptMode.unrestricted,
                onWebViewCreated: (WebViewController webViewController) {
                  _controller.complete(webViewController);
                },
                javascriptChannels: <JavascriptChannel>[
                  _toasterJavascriptChannel(context),
                ].toSet(),
              ),
              // InAppWebView(
              //   onWebViewCreated: (InAppWebViewController webViewController) {
              //     _completer.complete(webViewController);
              //   },
              //   onLoadStart: (InAppWebViewController controller, String url) {
              //     setState(() {
              //       _isLoadingPage = true;
              //     });
              //     if (url.split('/').contains("confirm") ||
              //         url.split('/').contains("cancel") ||
              //         url.split('/').contains("fail")) {
              //       Navigator.pop(context, url);
              //     }
              //   },
              //   onProgressChanged:
              //       (InAppWebViewController controller, int url) {},
              //   onLoadStop: (InAppWebViewController controller, String url) {
              //     setState(() {
              //       _isLoadingPage = false;
              //     });
              //   },
              //   initialUrl: '${widget.url}',
              // ),
              _isLoadingPage
                  ? Center(
                      child: SpinKitCircle(
                        color: Color(0xFF00BABA),
                        size: 50.0,
                      ),
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}

JavascriptChannel _toasterJavascriptChannel(BuildContext context) {
  return JavascriptChannel(
      name: 'Toaster',
      onMessageReceived: (JavascriptMessage message) {
        // ignore: deprecated_member_use
        Scaffold.of(context).showSnackBar(
          SnackBar(content: Text(message.message)),
        );
      });
}
