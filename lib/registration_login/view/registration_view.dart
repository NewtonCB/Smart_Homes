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
                  Obx(() {
                    return GestureDetector(
                      onTap: () => _showStreetDialog(context),
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
                              controller.selectedStreets.isEmpty
                                  ? 'Select Streets'
                                  : controller.selectedStreets.join(', '),
                              style: TextStyle(color: Colors.grey.shade700),
                            ),
                            Icon(Icons.arrow_drop_down, color: Colors.grey.shade700),
                          ],
                        ),
                      ),
                    );
                  }),
                  Obx(() {
                    return Wrap(
                      children: controller.selectedStreets
                          .map((street) => Chip(
                        label: Text(street),
                        onDeleted: () => controller.removeStreet(street),
                      ))
                          .toList(),
                    );
                  }),
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

  void _showStreetDialog(BuildContext context) {
    TextEditingController searchController = TextEditingController();
    // Use RxList directly without wrapping in another Rx
    RxList<String> filteredStreets = controller.streets;

    void filterSearchResults(String query) {
      if (query.isEmpty) {
        filteredStreets.value = controller.streets;
      } else {
        filteredStreets.value = controller.streets
            .where((street) => street.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    }

    showDialog(
      context: context,
      builder: (context) {
        return Expanded(
          child: Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Container(
              constraints: const BoxConstraints(maxHeight: 300), // Limiting the height of the dialog
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Select Streets',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: searchController,
                    decoration: const InputDecoration(hintText: 'Search Streets'),
                    onChanged: (value) {
                      filterSearchResults(value);
                    },
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: Obx(() {
                      return ListView.builder(
                        itemCount: filteredStreets.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(filteredStreets[index]),
                            onTap: () {
                              controller.addStreet(filteredStreets[index]);
                              Get.back();
                            },
                          );
                        },
                      );
                    }),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

}
