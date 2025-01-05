import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:promotion_dashboard/view/screens/dashboard.dart';
import 'package:promotion_dashboard/view/screens/products.dart';

abstract class HomeController extends GetxController {}

class HomeControllerImp extends HomeController {
  var selectedIndex = 0;

  final List screens = const [
    Dashboard(),
    Products(),
    SizedBox(),
    SizedBox(),
    SizedBox(),
  ];

  void changeIndex(int index) {
    selectedIndex = index;
    update();
  }
}
