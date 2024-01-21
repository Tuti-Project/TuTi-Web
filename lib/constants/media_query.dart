import 'package:flutter/material.dart';

import 'breakpoints.dart';

class MQ {
  final BuildContext context;
  MQ(this.context);

  double get width => MediaQuery.of(context).size.width;

  double get height => MediaQuery.of(context).size.height;

  bool get isMobile => MediaQuery.of(context).size.width < Breakpoints.sm;

  bool get isTablet =>
      MediaQuery.of(context).size.width >= Breakpoints.sm &&
      MediaQuery.of(context).size.width < Breakpoints.lg;

  bool get isDesktop => MediaQuery.of(context).size.width >= Breakpoints.lg;
}
