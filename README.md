<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/tools/pub/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/to/develop-packages).
-->

A Flutter package that provides a WebView with custom back navigation, managed via a stack of URLs. This allows users to go back in their browsing history without exiting the app, enhancing the standard WebView with custom navigation control.

## Features

- Allows back navigation through browsing history managed via a stack.
- Prevents the app from closing when the back button is pressed if there’s previous browsing history.
- Compatible with the `webview_flutter` package for a seamless web browsing experience within Flutter apps.

## Getting started

Add `stacked_webview` as a dependency in your `pubspec.yaml` file:

```ymal
dependencies:
  stacked_webview: ^1.0.1
```
then run flutter pub get


## Usage

To use StackedWebview, pass a WebViewController instance and the initial URL you want to load:

```dart
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:stacked_webview/stacked_webview.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyWebViewScreen(),
    );
  }
}

class MyWebViewScreen extends StatefulWidget {
  @override
  _MyWebViewScreenState createState() => _MyWebViewScreenState();
}

class _MyWebViewScreenState extends State<MyWebViewScreen> {
  late WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stacked WebView Example'),
      ),
      body: StackedWebview(
        controller: _controller,
        initialUrl: 'https://www.example.com',
      ),
    );
  }
}
```

### Parameters
controller (required): An instance of WebViewController for managing web view state.
initialUrl (required): The initial URL to load in the WebView.
appbar : You can give a custom appbar if you want to show above your webview

## Additional information

### How it Works
StackedWebview maintains a stack of URLs that the user visits. When the back button is pressed, it loads the previous URL in the stack, allowing users to navigate backward without closing the app.


