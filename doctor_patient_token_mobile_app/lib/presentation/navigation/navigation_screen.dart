import 'package:doctor_patient_token_mobile_app/app/config/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import '../../app/services/app_get_view_stateful.dart';
import 'nav_controller.dart';

class NavigationScreen extends GetStatefulWidget<NavController> {
  const NavigationScreen({super.key});

  @override
  State<NavigationScreen> createState() => _NavigationScreen();
}

class _NavigationScreen extends State<NavigationScreen> {
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
          body: IndexedStack(
            index: widget.controller.currentIndex.value,
            children: widget.controller.navItems
                .map((item) => Navigator(
                      key: item.navigatorKey,
                      onGenerateRoute: (settings) {
                        return MaterialPageRoute(
                          builder: (_) => item.screenBuilder(),
                        );
                      },
                    ))
                .toList(),
          ),
          bottomNavigationBar: widget.controller.shouldShowNavBar.value
              ? BottomNavigationBar(
                  currentIndex: widget.controller.currentIndex.value,
                  selectedItemColor: AppColors.primary,
                  onTap: widget.controller.changeTab,
                  items: widget.controller.navItems.map((item) {
                    return BottomNavigationBarItem(
                      icon: item.unselectedIcon,
                      activeIcon: item.selectedIcon,
                      label: item.label,
                    );
                  }).toList(),
                )
              : null);
    });
  }
}
