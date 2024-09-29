import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teameat/0_config/environment.dart';
import 'package:teameat/1_presentation/core/layout/scaffold.dart';
import 'package:teameat/2_application/core/i_react.dart';
import 'package:teameat/2_application/home/section/banner_page_controller.dart';
import 'package:teameat/99_util/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class BannerPage extends GetView<BannerPageController> {
  const BannerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return TEScaffold(body: _BannerPageWebView(c.url));
  }
}

class _BannerPageWebView extends StatefulWidget {
  final String url;

  const _BannerPageWebView(this.url);

  @override
  State<_BannerPageWebView> createState() => __BannerPageWebViewState();
}

class __BannerPageWebViewState extends State<_BannerPageWebView> {
  late final controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..setNavigationDelegate(
      NavigationDelegate(
        onNavigationRequest: (NavigationRequest request) {
          if (request.url.startsWith('teameat://')) {
            print(request.url);
            return NavigationDecision.prevent;
          }
          if (request.url == widget.url) {
            return NavigationDecision.navigate;
          }
          return NavigationDecision.prevent;
        },
      ),
    )
    ..loadRequest(Uri.parse(widget.url));

  @override
  Widget build(BuildContext context) {
    return WebViewWidget(controller: controller);
  }
}
