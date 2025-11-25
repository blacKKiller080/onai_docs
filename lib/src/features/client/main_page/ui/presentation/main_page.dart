import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:onai_docs/src/core/resources/resources.dart';

@RoutePage()
class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  double maxHeight = 0;
  double loadProgress = 0.0;

  String loadError = '';
  String currentUrl = '';

  InAppWebViewController? webViewController;
  ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16)
                  .copyWith(bottom: 10),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Главная', style: AppTextStyles.os14w600),
                  Text('ИП ИВАНОВ', style: AppTextStyles.os14w600)
                ],
              ),
            ),
            Expanded(
              child: InAppWebView(
                initialUrlRequest: URLRequest(
                  url: WebUri('https://onaidocs.kz/'),
                ),
                initialSettings: InAppWebViewSettings(
                  transparentBackground: true,
                  useShouldOverrideUrlLoading: false,
                  mediaPlaybackRequiresUserGesture: false,
                  supportZoom: false,
                  clearCache: true,
                  useOnLoadResource: false,
                  horizontalScrollBarEnabled: false,
                  clearSessionCache: true,
                  cacheEnabled: false,
                  builtInZoomControls: false,
                  allowsLinkPreview: false,
                  disableLongPressContextMenuOnLinks: true,
                  allowsInlineMediaPlayback: true,
                  disableContextMenu: true,
                  disableHorizontalScroll: true,
                  useShouldInterceptAjaxRequest: false,
                  useShouldInterceptFetchRequest: false,
                  // domStorageEnabled: false,
                ),
                onWebViewCreated: (controller) {
                  webViewController = controller;
                },
                onLoadStart: (controller, url) {
                  currentUrl = url.toString();
                  setState(() {});
                  log('Main Page Controller Value - $controller');
                  context.loaderOverlay.show();
                },
                onLoadStop: (controller, url) {
                  log('finished in main with $url');
                  setState(() {
                    currentUrl = url.toString();
                    loadProgress = 100.0;
                  });
                  context.loaderOverlay.hide();
                },
                onReceivedError: (controller, request, error) {
                  if (mounted) {
                    setState(() {
                      loadError = error.description;
                    });
                  }
                  log('Error on main page - ${error.description}');

                  context.loaderOverlay.hide();
                },
                onProgressChanged: (controller, progress) {
                  log('NavigationProgress - $progress');
                  // _updateProgress();
                },
                shouldOverrideUrlLoading: (controller, navigationAction) async {
                  log('override to in main ${navigationAction.request.url}');
                  setState(() {
                    currentUrl = navigationAction.request.url.toString();
                  });

                  return NavigationActionPolicy.ALLOW;
                },
                onPermissionRequest: (controller, permissionRequest) async {
                  return PermissionResponse(
                    resources: permissionRequest.resources,
                    action: PermissionResponseAction.GRANT,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
