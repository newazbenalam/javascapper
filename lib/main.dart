import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

void main() => runApp(const MaterialApp(home: WebViewExample()));

class WebViewExample extends StatefulWidget {
  const WebViewExample({Key? key}) : super(key: key);

  @override
  _WebViewExampleState createState() => _WebViewExampleState();
}

class _WebViewExampleState extends State<WebViewExample> {
  late final InAppWebViewController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flutter Simple Example')),
      body: InAppWebView(
        initialUrlRequest: URLRequest(url: Uri.parse('https://m.youtube.com')),
        onWebViewCreated: (controller) {
          this.controller = controller;
        },
        onLoadStop: (controller, url) {
          scrapeContent();
        },
      ),
    );
  }

  Future<void> scrapeContent() async {
    try {
      String? href = await controller.evaluateJavascript(source: snippet);
      if (href != null && href.isNotEmpty) {
        debugPrint('Scraped HREF: $href');
      } else {
        // debugPrint('Failed to scrape HREF.');
      }
    } catch (e) {
      debugPrint('Error: $e');
    }
  }

  String snippet = '''
  javascript: (function () {
    var header = document.querySelector("header");
    if (header) header.remove();
    var footer = document.querySelector("footer");
    if (footer) footer.remove();
    var thumbnailLinks = document.querySelectorAll(".media-item-thumbnail-container");
    if (thumbnailLinks.length > 2) {
      return thumbnailLinks[2].href;
    } else {
      return "";
    }
  })();
  ''';
}
