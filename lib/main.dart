import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: WebViewContainer(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class WebViewContainer extends StatefulWidget {
  const WebViewContainer({super.key});

  @override
  State<WebViewContainer> createState() => _WebViewContainerState();
}

class _WebViewContainerState extends State<WebViewContainer> {
  final _url =
      'https://6495ac7394575140f22df7b5--react-native-photo-gallery-apis.netlify.app/';
  WebViewController? webViewController;

  @override
  void initState() {
    [
      Permission.photos,
      Permission.camera,
      Permission.mediaLibrary,
      Permission.videos,
    ].request().then((value) {
      webViewController = WebViewController()
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..loadRequest(Uri.parse(_url));
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('WebView')),
      body: webViewController != null
          ? WebViewWidget(
              controller: webViewController!,
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
