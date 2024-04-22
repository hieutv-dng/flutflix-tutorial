import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService extends GetxService {
  AuthService();

  final _user = Rxn<User>();
  User? get user => _user.value;
  late final StreamSubscription<User?> _userSubscription;

  @override
  void onInit() {
    _userSubscription =
        FirebaseAuth.instance.userChanges().listen(_onUserChanged);
    super.onInit();
  }

  @override
  void onClose() {
    _userSubscription.cancel();
    super.onClose();
  }

  void _onUserChanged(User? user) {
    _user.value = user;
  }

  Future<void> signInWithGoogle() async {
    try {
      EasyLoading.show();

      // Trigger the authentication flow
      final googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final googleAuth = await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      Get.snackbar('Thông báo', e.toString());
    } finally {
      EasyLoading.dismiss();
    }
  }

  Future<void> logout() async {
    try {
      EasyLoading.show();
      await FirebaseAuth.instance.signOut();
    } finally {
      EasyLoading.dismiss();
    }
  }
}
