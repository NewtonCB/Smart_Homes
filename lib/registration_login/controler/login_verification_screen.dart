import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../components/text_form_field.dart';
import 'login_controller.dart';

class VerificationPage extends StatelessWidget {
  final String verificationId;
  final LoginController controller = Get.find<LoginController>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>(); // Define the form key

  VerificationPage({required this.verificationId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF7EBE1),
      appBar: AppBar(
        backgroundColor: const Color(0xffF7EBE1),
        title: const Text(
          'Verify OTP',
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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: SingleChildScrollView(
            child: Form(  // Wrap in a Form widget
              key: _formKey, // Assign the form key
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(height: 30.0),
                  Image.asset(
                    'assets/img/mylogo.png',
                    height: 100,
                  ),
                  const SizedBox(height: 80.0),
                  const Text(
                    'Enter the OTP sent to your phone number',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Color(0xff06113c),
                    ),
                  ),
                  const SizedBox(height: 30),
                  CustomTextFormField(
                    hintText: 'OTP',
                    icon: Icons.lock,
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter the OTP';
                      }
                      return null;
                    },
                    controller: controller.otpController,
                  ),
                  const SizedBox(height: 20),
                  Obx(() {
                    return ElevatedButton(
                      onPressed: controller.isLoading.value ? null : () {
                        if (_formKey.currentState!.validate()) {
                          controller.verifyOtp(verificationId);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff06113c),
                      ),
                      child: controller.isLoading.value
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text(
                        'Verify OTP',
                        style: TextStyle(color: Colors.white),
                      ),
                    );
                  }),
                  const SizedBox(height: 20),
                  TextButton(
                    onPressed: () => Get.back(),
                    child: const Text(
                      'Back to Login',
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
}
