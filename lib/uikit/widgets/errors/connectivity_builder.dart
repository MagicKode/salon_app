import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

import 'network_error_widget.dart';

class ConnectivityBuilder extends StatelessWidget {
  final Widget child;
  final Widget? loadingWidget;
  final VoidCallback? onRetry;
  final bool showErrorOnNoConnection;

  const ConnectivityBuilder({
    super.key,
    required this.child,
    this.loadingWidget,
    this.onRetry,
    this.showErrorOnNoConnection = true,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ConnectivityResult>(
      stream: Connectivity().onConnectivityChanged,
      builder: (context, snapshot) {
        final hasInternet = snapshot.data != ConnectivityResult.none;

        if (!hasInternet && showErrorOnNoConnection) {
          return NetworkErrorWidget(
            onRetry: onRetry ?? () {},
          );
        }

        return child;
      },
    );
  }
}
