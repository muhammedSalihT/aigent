import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:responsive_framework/responsive_framework.dart';

class ResponsiveUtils {
  ResponsiveUtils._();

  static bool isMobile(BuildContext context) =>
      ResponsiveBreakpoints.of(context).smallerOrEqualTo(MOBILE);

  static bool isTablet(BuildContext context) =>
      ResponsiveBreakpoints.of(context).between(MOBILE, TABLET);

  static bool isDesktop(BuildContext context) =>
      ResponsiveBreakpoints.of(context).largerThan(TABLET);

  static double value(
    BuildContext context, {
    required double mobile,
    required double tablet,
    required double desktop,
  }) {
    if (isMobile(context)) return mobile;
    if (isTablet(context)) return tablet;
    return desktop;
  }

  static int gridCrossAxisCount(
    BuildContext context, {
    int mobile = 1,
    int tablet = 2,
    int desktop = 3,
  }) {
    if (isMobile(context)) return mobile;
    if (isTablet(context)) return tablet;
    return desktop;
  }
}
