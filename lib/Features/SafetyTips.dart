import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:women_safety/provider/circularPrgsbar.dart';

class Safetytips extends StatefulWidget {
  const Safetytips({super.key});

  @override
  State<Safetytips> createState() => _SafetytipsState();
}

class _SafetytipsState extends State<Safetytips> {

  late final WebViewController _controller;
  bool _isloading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();


    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
            // Provider.of<circularprgsbar>(context, listen: false).setloading(true);


          },
          onPageStarted: (String url) {
            // print('this is running on onPageStarted' + url);
            Provider.of<circularprgsbar>(context, listen: false).setloading(true);
          },
          onPageFinished: (String url) {
            Provider.of<circularprgsbar>(context, listen: false).setloading(false);

            print("this page is running on OnpageFinished" + url);
          },
          onHttpError: (HttpResponseError error) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(
          'https://www.instructables.com/Basic-Street-Safety-for-Women/'))
          .catchError((error) {
        print('WebView error: $error');
      });
  }

  @override
  void dispose() {
    // TODO: implement dispose

    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white), // Back icon with white color
          onPressed: () {
            Navigator.pop(context); // Action to go back to the previous screen
          },
        ),
        title: Text(
          "Safety Tips",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: 'cursive',
            fontSize: 28,
            color: Colors.white,
          ),
        ),
      ),
      body: Consumer<circularprgsbar>(
        builder: (context, authprovider, child) {
          return authprovider.loading
              ? Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.white,
            ),
          )
              : WebViewWidget(controller: _controller);
        },
      ),
    );
  }
}
