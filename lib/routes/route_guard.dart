import 'package:cunex_wellness/features/landing/providers/navigation_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RouteGuard extends GetMiddleware {
  final int index;
  
  RouteGuard(this.index);
  
  @override
  RouteSettings? redirect(String? route) {
    Get.find<NavigationController>().selectedIndex.value = index;
    return null;
  }
}