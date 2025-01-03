import 'package:flutter/material.dart';

class AdaptiveLayout extends StatelessWidget {
  final WidgetBuilder mobileLayout;
  final WidgetBuilder tabletLayout;
  final WidgetBuilder destopLayout;
  const AdaptiveLayout({
    super.key,
    required this.mobileLayout,
    required this.tabletLayout,
    required this.destopLayout,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (MediaQuery.sizeOf(context).width < 800) {
        return mobileLayout(context);
      } else if (MediaQuery.sizeOf(context).width < 1200) {
        return tabletLayout(context);
      } else {
        return destopLayout(context);
      }
    });
  }
}
