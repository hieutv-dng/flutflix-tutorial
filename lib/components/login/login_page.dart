import 'package:flutflix/data/index.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildLogo(),
            const SizedBox(height: 32),
            _buildGoogleSignInButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'assets/flutflix.png',
          fit: BoxFit.cover,
          height: 80,
          filterQuality: FilterQuality.high,
        ),
      ],
    );
  }

  Widget _buildGoogleSignInButton() {
    return ElevatedButton(
      onPressed: () {
        Get.find<AuthService>().signInWithGoogle();
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        shape: const StadiumBorder(),
        textStyle: const TextStyle(
          fontWeight: FontWeight.w600,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            'assets/google.png',
            fit: BoxFit.cover,
            height: 24,
            filterQuality: FilterQuality.high,
          ),
          const SizedBox(width: 16),
          const Text('Đăng nhập với Google'),
        ],
      ),
    );
  }
}
