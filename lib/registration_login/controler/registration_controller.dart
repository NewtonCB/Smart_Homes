import 'package:flutter/material.dart';
import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:Nestify/registration_login/model/registration_model.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class RegistrationController extends GetxController {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController streetController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  var profileImagePath = ''.obs;
  var selectedRole = ''.obs;
  var roles = ['Agent', 'Landlord'].obs;

  final ImagePicker _picker = ImagePicker();

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    phoneNumberController.dispose();
    streetController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  void pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profileImagePath.value = pickedFile.path;
    }
  }

  void removeImage() {
    profileImagePath.value = '';
  }

  Future<String> uploadProfileImage(String filePath) async {
    final file = File(filePath);
    final storageRef = FirebaseStorage.instance
        .ref()
        .child('profile_pictures/${DateTime.now().millisecondsSinceEpoch}.jpg');
    final uploadTask = storageRef.putFile(file);
    final snapshot = await uploadTask.whenComplete(() {});
    return await snapshot.ref.getDownloadURL();
  }

  void clearForm() {
    firstNameController.clear();
    lastNameController.clear();
    emailController.clear();
    phoneNumberController.clear();
    streetController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
    profileImagePath.value = '';
    selectedRole.value = '';
  }

  void registerUser() async {
    Get.dialog(
      Center(
        child: LoadingAnimationWidget.staggeredDotsWave(
          color: Color(0xff06113c),
          size: 50,
        ),
      ),
      barrierDismissible: false,
    );

    try {
      final UserCredential userCredential =
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      String profileImageUrl = '';
      if (profileImagePath.value.isNotEmpty) {
        profileImageUrl = await uploadProfileImage(profileImagePath.value);
      }

      final user = UserModel(
        firstName: firstNameController.text,
        lastName: lastNameController.text,
        email: emailController.text,
        phoneNumber: phoneNumberController.text,
        password: passwordController.text,
        role: selectedRole.value,
        streets: [streetController.text],
        profilePicture: profileImageUrl,
      );

      await FirebaseDatabase.instance
          .ref()
          .child('users')
          .child(userCredential.user!.uid)
          .set(user.toJson());

      Get.back(); // Close the loading dialog

      Get.dialog(
        AlertDialog(
          title: const Icon(Icons.check_circle, color: Colors.green, size: 80),
          content: const Text('Registration Successful!'),
          actions: [
            TextButton(
              onPressed: () {
                clearForm();
                Get.back(); // Close the dialog
                Get.offNamed(''); // Navigate to login page
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } catch (e) {
      Get.back(); // Close the loading dialog
      Get.snackbar('Error', e.toString());
    }
  }
}
