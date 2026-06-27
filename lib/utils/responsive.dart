import 'package:flutter/material.dart';

/// Breakpoints used across the dashboard.
///
/// mobile  : < 700
/// tablet  : 700 - 1099
/// desktop : >= 1100
class AppBreakpoints {
  AppBreakpoints._();

  static const double mobile = 700;
  static const double tablet = 1100;
}

enum DeviceType { mobile, tablet, desktop }

/// Static helpers for checking device type from a [BuildContext].
class Responsive {
  Responsive._();

  static double widthOf(BuildContext context) => MediaQuery.of(context).size.width;

  static DeviceType deviceTypeOf(BuildContext context) {
    final width = widthOf(context);
    if (width < AppBreakpoints.mobile) return DeviceType.mobile;
    if (width < AppBreakpoints.tablet) return DeviceType.tablet;
    return DeviceType.desktop;
  }

  static bool isMobile(BuildContext context) =>
      deviceTypeOf(context) == DeviceType.mobile;

  static bool isTablet(BuildContext context) =>
      deviceTypeOf(context) == DeviceType.tablet;

  static bool isDesktop(BuildContext context) =>
      deviceTypeOf(context) == DeviceType.desktop;

  /// True for tablet AND desktop — i.e. "wide enough to show the sidebar".
  static bool isWide(BuildContext context) => !isMobile(context);

  /// Horizontal page padding that grows with screen size.
  static double pagePadding(BuildContext context) {
    switch (deviceTypeOf(context)) {
      case DeviceType.mobile:
        return 16;
      case DeviceType.tablet:
        return 24;
      case DeviceType.desktop:
        return 32;
    }
  }
}

/// Picks one of three builders depending on the current [DeviceType].
///
/// Any of [tablet] / [desktop] can be omitted; they fall back to the next
/// smaller variant (desktop -> tablet -> mobile).
class ResponsiveLayout extends StatelessWidget {
  const ResponsiveLayout({
    super.key,
    required this.mobile,
    this.tablet,
    this.desktop,
  });

  final WidgetBuilder mobile;
  final WidgetBuilder? tablet;
  final WidgetBuilder? desktop;

  @override
  Widget build(BuildContext context) {
    final type = Responsive.deviceTypeOf(context);

    switch (type) {
      case DeviceType.desktop:
        return (desktop ?? tablet ?? mobile)(context);
      case DeviceType.tablet:
        return (tablet ?? mobile)(context);
      case DeviceType.mobile:
        return mobile(context);
    }
  }
}

/// Constrains content to a max width and centers it on very large screens
/// (e.g. ultra-wide monitors), so the dashboard doesn't stretch awkwardly.
class MaxWidthBox extends StatelessWidget {
  const MaxWidthBox({
    super.key,
    required this.child,
    this.maxWidth = 1600,
  });

  final Widget child;
  final double maxWidth;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: child,
      ),
    );
  }
}