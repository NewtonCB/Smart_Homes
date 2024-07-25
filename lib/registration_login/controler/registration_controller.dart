import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:renting_app/registration_login/model/registration_model.dart';

class RegistrationController extends GetxController {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  var profileImagePath = ''.obs;
  var selectedRole = ''.obs;
  var selectedStreets = <String>[].obs;
  var roles = ['Agent', 'Landlord'].obs;
  var streets = ['Street 1', 'Street 2', 'Street 3'].obs;
  var filteredStreets = <String>[].obs;

  final ImagePicker _picker = ImagePicker();

  @override
  void dispose() {
    // Dispose all text editing controllers when not needed anymore
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    phoneNumberController.dispose();
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

  void addStreet(String street) {
    if (!selectedStreets.contains(street)) {
      selectedStreets.add(street);
    }
  }

  void removeStreet(String street) {
    selectedStreets.remove(street);
  }

  void registerUser() async {
    try {
      final UserCredential userCredential =
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      final user = UserModel(
        firstName: firstNameController.text,
        lastName: lastNameController.text,
        email: emailController.text,
        phoneNumber: phoneNumberController.text,
        password: passwordController.text,
        role: selectedRole.value,
        streets: selectedStreets.toList(), // Convert observable list to regular list
        profilePicture: profileImagePath.value,
      );

      await FirebaseDatabase.instance
          .ref()
          .child('users')
          .child(userCredential.user!.uid)
          .set(user.toJson());

      Get.dialog(
        AlertDialog(
          title: const Icon(Icons.check_circle, color: Colors.green, size: 80),
          content: const Text('Registration Successful!'),
          actions: [
            TextButton(
              onPressed: () {
                Get.back(); // Close the dialog
                Get.offNamed('/login'); // Navigate to login page
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  void filterStreets(String query) {
    if (query.isEmpty) {
      filteredStreets.value = streets;
    } else {
      filteredStreets.value = streets
          .where((street) => street.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
  }
}
