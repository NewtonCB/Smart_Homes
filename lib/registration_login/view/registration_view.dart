import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../components/text_form_field.dart';
import 'package:renting_app/registration_login/controler/registration_controller.dart';

class RegistrationPage extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final RegistrationController controller = Get.put(RegistrationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF7EBE1),
      appBar: AppBar(
        backgroundColor: const Color(0xffF7EBE1),
        title: const Text(
          'Register',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/choosing.png'),
            fit: BoxFit.fitWidth,
          ),
        ),
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset(
                    'assets/img/mylogo.png',
                    height: 100,
                  ),
                  const SizedBox(height: 12.0),
                  GestureDetector(
                    onTap: () => controller.pickImage(),
                    child: Obx(() {
                      return CircleAvatar(
                        backgroundColor: Colors.grey,
                        radius: 50,
                        backgroundImage: controller.profileImagePath.value.isEmpty
                            ? const AssetImage('assets/img/default_pic.png')
                            : FileImage(File(controller.profileImagePath.value)) as ImageProvider,
                      );
                    }),
                  ),
                  Obx(() {
                    return controller.profileImagePath.value.isNotEmpty
                        ? TextButton(
                      onPressed: () => controller.removeImage(),
                      child: const Text('Remove Image'),
                    )
                        : const SizedBox.shrink();
                  }),
                  const SizedBox(height: 10),
                  const Text('Please upload your profile picture'),
                  const SizedBox(height: 10),
                  CustomTextFormField(
                    hintText: 'First Name',
                    icon: Icons.person,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your first name';
                      }
                      return null;
                    },
                    controller: controller.firstNameController,
                  ),
                  const SizedBox(height: 10),
                  CustomTextFormField(
                    hintText: 'Last Name',
                    icon: Icons.person,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your last name';
                      }
                      return null;
                    },
                    controller: controller.lastNameController,
                  ),
                  const SizedBox(height: 10),
                  CustomTextFormField(
                    hintText: 'Email',
                    icon: Icons.email,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your email';
                      }
                      if (!GetUtils.isEmail(value)) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                    controller: controller.emailController,
                  ),
                  const SizedBox(height: 10),
                  CustomTextFormField(
                    hintText: 'Phone Number',
                    icon: Icons.phone,
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your phone number';
                      }
                      return null;
                    },
                    controller: controller.phoneNumberController,
                  ),
                  const SizedBox(height: 10),
                  Obx(() {
                    return GestureDetector(
                      onTap: () => _showRoleDialog(context),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              controller.selectedRole.value.isEmpty
                                  ? 'Select Role'
                                  : controller.selectedRole.value,
                              style: TextStyle(color: Colors.grey.shade700),
                            ),
                            Icon(Icons.arrow_drop_down, color: Colors.grey.shade700),
                          ],
                        ),
                      ),
                    );
                  }),
                  const SizedBox(height: 10),
                  CustomTextFormField(
                    hintText: 'Street',
                    icon: Icons.location_on,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your street';
                      }
                      return null;
                    },
                    controller: controller.streetController,
                  ),
                  const SizedBox(height: 10),
                  CustomTextFormField(
                    hintText: 'Password',
                    icon: Icons.lock,
                    obscureText: true,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter a password';
                      }
                      return null;
                    },
                    controller: controller.passwordController,
                  ),
                  const SizedBox(height: 10),
                  CustomTextFormField(
                    hintText: 'Confirm Password',
                    icon: Icons.lock,
                    obscureText: true,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please confirm your password';
                      } else if (value != controller.passwordController.text) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                    controller: controller.confirmPasswordController,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        controller.registerUser();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff06113c),
                    ),
                    child: const Text(
                      'Register',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextButton(
                    onPressed: () => Get.toNamed('/login'),
                    child: const Text(
                      'Already have an account? Login',
                      style: TextStyle(color: Colors.black54),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showRoleDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Select Role'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: controller.roles.map((role) {
              return ListTile(
                title: Text(role),
                onTap: () {
                  controller.selectedRole.value = role;
                  Get.back();
                },
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
