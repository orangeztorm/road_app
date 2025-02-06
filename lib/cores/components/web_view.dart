// import 'package:flutter/material.dart';
// import 'package:warpspeed/cores/__cores.dart';
// import 'package:webview_flutter/webview_flutter.dart';

// class WebviewScreen extends StatefulWidget {
//   const WebviewScreen(this.url, {super.key, this.title});

//   final String url;
//   final String? title;

//   @override
//   State<WebviewScreen> createState() => _WebviewScreenState();
// }

// class _WebviewScreenState extends State<WebviewScreen> {
//   late WebViewController _controller;

//   @override
//   void initState() {
//     super.initState();
//     _controller = WebViewController()
//       ..setJavaScriptMode(JavaScriptMode.unrestricted)
//       ..setBackgroundColor(const Color(0x00000000))
//       ..setNavigationDelegate(NavigationDelegate(
//         onProgress: (int progress) {},
//         onPageStarted: (String url) {},
//         onPageFinished: (String url) {},
//         onWebResourceError: (WebResourceError error) {},
//         onNavigationRequest: (NavigationRequest request) {
//           if (request.url.startsWith('https://www.youtube.com/')) {
//             return NavigationDecision.prevent;
//           }
//           return NavigationDecision.navigate;
//         },
//       ))
//       ..loadRequest(Uri.parse(widget.url));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ScaffoldWidget(
//       usePadding: false,
//       useSingleScroll: false,
//       appBar: const CustomAppBar.sub(title: ''),
//       body: WebViewWidget(controller: _controller),
//     );
//   }
// }
