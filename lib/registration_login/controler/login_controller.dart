import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'login_verification_screen.dart';

class LoginController extends GetxController {
  var phoneNumberController = TextEditingController();
  var passwordController = TextEditingController(); // Not used for phone authentication
  var otpController = TextEditingController(); // Add this for OTP input
  var isLoading = false.obs;

  // Function to start phone authentication
  Future<void> loginUser() async {
    isLoading.value = true;
    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNumberController.text.trim(),
        verificationCompleted: (PhoneAuthCredential credential) async {
          // This callback is triggered when the auto-retrieval or instant verification occurs
          await FirebaseAuth.instance.signInWithCredential(credential);
          Get.offNamed('/profile');
        },
        verificationFailed: (FirebaseAuthException e) {
          Get.snackbar('Verification Failed', e.message ?? 'An error occurred');
        },
        codeSent: (String verificationId, int? resendToken) {
          // Navigate to the OTP verification screen with verificationId
          Get.to(() => VerificationPage(verificationId: verificationId));
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          // Auto retrieval timed out, handle accordingly
        },
      );
    } catch (e) {
      Get.snackbar('Login Failed', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  // Function to verify OTP
  Future<void> verifyOtp(String verificationId) async {
    isLoading.value = true;
    try {
      final PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: otpController.text.trim(),
      );

      await FirebaseAuth.instance.signInWithCredential(credential);
      Get.offNamed('/profile');
    } catch (e) {
      Get.snackbar('Verification Failed', e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
