import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class StackedWebview extends StatefulWidget {
  final String initialUrl;
  final AppBar? appbar;

  const StackedWebview({
    super.key,
    required this.initialUrl,
    this.appbar,
  });

  @override
  State<StackedWebview> createState() => _StackedWebviewState();
}

class _StackedWebviewState extends State<StackedWebview> {
  final List<String> urlStack = [];
  late WebViewController newController;

  @override
  void initState() {
    super.initState();

    // Initialize the new controller
    newController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String url) {
            // Add the URL to the stack if it's not already the last one
            if (urlStack.isEmpty || urlStack.last != url) {
              setState(() {
                urlStack.add(url);
              });
              debugPrint("URL added to stack: $url");
            }
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.initialUrl));
  }

  Future<void> _handleBackNavigation() async {
    if (urlStack.length > 1) {
      // Remove the current URL
      setState(() {
        urlStack.removeLast();
      });

      // Load the previous URL
      final previousUrl = urlStack.last;
      await newController.loadRequest(Uri.parse(previousUrl));
    } else {
      // Close the app if there are no more URLs to navigate back to
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (urlStack.length > 1) {
          _handleBackNavigation();
          return false; // Prevent default back navigation
        }
        return true; // Allow app to exit
      },
      child: Scaffold(
        appBar: widget.appbar,
        body: WebViewWidget(controller: newController),
      ),
    );
  }
}
