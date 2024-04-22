import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainPageController extends GetxController {
  MainPageController(this.tab);

  final String? tab;
  late final PageController pageController;

  @override
  void onInit() {
    switch (tab) {
      case 'orders':
        pageController = PageController(initialPage: 1);
        break;
      case 'favorites':
        pageController = PageController(initialPage: 2);
        break;
      case 'account':
        pageController = PageController(initialPage: 3);
        break;
      default:
        pageController = PageController();
    }
    super.onInit();
  }

  //currentPageIndex
  final _currentPageIndex = 0.obs;
  int get currentPageIndex => _currentPageIndex.value;
  void onUpdateSelectedIndex(int index) {
    pageController.jumpToPage(index);
    _currentPageIndex.value = index;
  }
}
