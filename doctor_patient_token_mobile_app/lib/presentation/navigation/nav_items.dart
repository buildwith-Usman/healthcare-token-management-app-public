import 'package:flutter/material.dart';


class NavItem {
  final String label;
  final Widget Function() screenBuilder;
  final Widget unselectedIcon;
  final Widget selectedIcon;
  final GlobalKey<NavigatorState> navigatorKey;

  NavItem({
    required this.label,
    required this.screenBuilder,
    required this.unselectedIcon,
    required this.selectedIcon,
  }) : navigatorKey = GlobalKey<NavigatorState>();
}

