import 'package:flutflix/components/index.dart';
import 'package:flutflix/data/index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'home/home_page.dart';
import 'main_page_controller.dart';
import 'profile/profile_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({
    super.key,
    this.tab = 'home',
  });

  final String? tab;

  static const path = '/';

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late final MainPageController _controller;

  @override
  void initState() {
    _controller = Get.put(MainPageController(widget.tab));
    super.initState();
  }

  @override
  void dispose() {
    Get.delete<MainPageController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _controller.pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          const HomePage(),
          Obx(() {
            final user = Get.find<AuthService>().user;
            if (user != null) {
              return const ProfilePage();
            } else {
              return const LoginPage();
            }
          })
        ],
      ),
      bottomNavigationBar: _buildBottomNavBar(context),
    );
  }

  Widget _buildBottomNavBar(BuildContext context) {
    return Obx(() {
      return BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.profile_circled),
            label: 'My Flutflix',
          ),
        ],
        currentIndex: _controller.currentPageIndex,
        onTap: _controller.onUpdateSelectedIndex,
      );
    });
  }
}
