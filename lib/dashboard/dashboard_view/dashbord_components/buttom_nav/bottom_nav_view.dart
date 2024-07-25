import 'package:flutter/material.dart';
import 'package:renting_app/dashboard/presentation/themes/config.dart';
import 'package:get/get.dart';
import 'package:renting_app/posting_page/post_view.dart';
import 'package:renting_app/dashboard/presentation/pages/home/view/home.dart';

class FloatingActionButtonWithBottomNav extends StatefulWidget {
  const FloatingActionButtonWithBottomNav({Key? key}) : super(key: key);

  @override
  _FloatingActionButtonWithBottomNavState createState() =>
      _FloatingActionButtonWithBottomNavState();
}

class _FloatingActionButtonWithBottomNavState
    extends State<FloatingActionButtonWithBottomNav> {
  bool _showBottomNav = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (!_showBottomNav) // Show floating button if bottom nav is not visible
          FloatingActionButton(
            backgroundColor: const Color(0xff06113c),
            onPressed: () {
              setState(() {
                _showBottomNav = true;
              });
            },
            child: const Icon(Icons.menu, color: kButtonSecondaryColor),
          ),
        AnimatedPositioned(
          duration: const Duration(milliseconds: 300),
          bottom: _showBottomNav ? 0 : -kBottomNavigationBarHeight - 16, // Adjust the value for padding
          left: 35, // Add left margin
          right: 15, // Add right margin
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.8), // Increase opacity for shadow
                  spreadRadius: 10, // Increase spread radius for shadow
                  blurRadius: 10, // Increase blur radius for shadow
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: BottomNavigationBar(
              items: const [
                BottomNavigationBarItem(
                  backgroundColor: Color(0xff06113c),
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.dynamic_feed),
                  label: 'feeds',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.add_a_photo),
                  label: 'upload',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: 'profile',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.arrow_back),
                  label: 'back',
                ),
              ],
              onTap: (index) {

                switch (index) {
                  case 0:
                  // Navigate to Home Page
                    Get.toNamed('/home');
                    break;
                  case 1:
                  // Navigate to Settings Page
                    Get.toNamed('/add_photo');
                    break;
                  default:
                  // Default case if needed
                    break;
                }

                setState(() {
                  _showBottomNav = false;
                });
              },
            ),
          ),
        ),
      ],
    );
  }
}

