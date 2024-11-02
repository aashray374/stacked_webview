import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class StackedWebview extends StatefulWidget {
  final WebViewController controller;
  final String initialUrl;
  final AppBar? appbar;

  const StackedWebview({
    super.key,
    required this.controller,
    required this.initialUrl,
    this.appbar,
  });

  @override
  State<StackedWebview> createState() => _StackedWebviewState();
}

class _StackedWebviewState extends State<StackedWebview> {
  final List<String> urlStack = [];

  @override
  void initState() {
    super.initState();
    urlStack.add(widget.initialUrl);

    widget.controller.setNavigationDelegate(
      NavigationDelegate(
        onPageStarted: (String url) {
          if (Uri.parse(url).isAbsolute) {
            urlStack.add(url);
          }
        },
      ),
    );

    widget.controller.loadRequest(Uri.parse(widget.initialUrl));
  }

  void _handleBackNavigation(bool didPop, Object? result) {
    if (urlStack.length > 1) {
      urlStack.removeLast();
      widget.controller.loadRequest(Uri.parse(urlStack.last));
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: _handleBackNavigation,
      child: Scaffold(
        appBar: widget.appbar,
        body: WebViewWidget(controller: widget.controller),
      )
    );
  }
}