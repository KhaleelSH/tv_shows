import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

const double _kActivityIndicatorRadius = 14.0;

/// [AdaptiveRefreshIndicator] shows different refresh indicators for
/// different operating systems, ex: Material indicator for Android
/// and Cupertino indicator for iOS.
class AdaptiveRefreshIndicator extends StatelessWidget {
  const AdaptiveRefreshIndicator({
    Key? key,
    required this.child,
    required this.onRefresh,
  }) : super(key: key);

  final Widget child;
  final AsyncCallback onRefresh;

  @override
  Widget build(BuildContext context) {
    switch (Platform.operatingSystem) {
      case 'android':
        return RefreshIndicator(
          child: child,
          onRefresh: onRefresh,
        );
      case 'ios':
        return CustomScrollView(
          slivers: [
            CupertinoSliverRefreshControl(
              onRefresh: onRefresh,
              refreshIndicatorExtent: MediaQuery.of(context).padding.top + 40,
              builder: (context, refreshState, pulledExtent,
                  refreshTriggerPullDistance, refreshIndicatorExtent) {
                final double percentageComplete =
                    (pulledExtent / refreshTriggerPullDistance).clamp(0.0, 1.0);
                return Center(
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: <Widget>[
                      Positioned(
                        top: MediaQuery.of(context).padding.top,
                        left: 0.0,
                        right: 0.0,
                        child: _buildIndicatorForRefreshState(
                          refreshState,
                          _kActivityIndicatorRadius,
                          percentageComplete,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            SliverToBoxAdapter(child: child),
          ],
        );
    }
    return child;
  }

  // This code is from [refresh.dart] and I copied it here to fix issue
  // with iPhone notch padding when the screen is over scrolled to refresh.
  static Widget _buildIndicatorForRefreshState(
      RefreshIndicatorMode refreshState,
      double radius,
      double percentageComplete) {
    switch (refreshState) {
      case RefreshIndicatorMode.drag:
        const Curve opacityCurve = Interval(0.0, 0.35, curve: Curves.easeInOut);
        return Opacity(
          opacity: opacityCurve.transform(percentageComplete),
          child: CupertinoActivityIndicator.partiallyRevealed(
              radius: radius, progress: percentageComplete),
        );
      case RefreshIndicatorMode.armed:
      case RefreshIndicatorMode.refresh:
        return CupertinoActivityIndicator(radius: radius);
      case RefreshIndicatorMode.done:
        return CupertinoActivityIndicator(radius: radius * percentageComplete);
      case RefreshIndicatorMode.inactive:
        return Container();
    }
  }
}
