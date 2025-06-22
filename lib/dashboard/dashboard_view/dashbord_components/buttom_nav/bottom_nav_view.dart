import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:Nestify/posting_page/post_view.dart';

import 'package:flutter/material.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:get/get.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'bottom_nav_controller.dart';

class BottomNavView extends StatelessWidget {
  final BottomNavController controller = Get.put(BottomNavController());

  @override
  Widget build(BuildContext context) {
    return Obx(
          () => BottomNavyBar(
            // backgroundColor: const Color(0xff06113c),
        selectedIndex: controller.selectedIndex.value,
        onItemSelected: (index) {
          if (index != controller.selectedIndex.value) {
            controller.updateIndex(index);
          }
        },
        items: [
          _buildBottomNavyBarItem(Icons.home, 'Home', controller.selectedIndex.value == 0),
          _buildBottomNavyBarItem(Icons.dynamic_feed, 'Feeds', controller.selectedIndex.value == 1),
          _buildBottomNavyBarItem(Icons.add_a_photo, 'Upload', controller.selectedIndex.value == 2),
          _buildBottomNavyBarItem(Icons.person, 'Profile', controller.selectedIndex.value == 3),
        ],
      ),
    );
  }

  BottomNavyBarItem _buildBottomNavyBarItem(IconData icon, String title, bool isSelected) {
    return BottomNavyBarItem(
      icon: isSelected
          ? Bounce(
        child: Icon(icon),
      )
          : Icon(icon),
      title: Text(title),
      activeColor: const Color(0xff06113c),
      inactiveColor: const Color(0xff06113c),
    );
  }
}




// class FloatingActionButtonWithBottomNav extends StatefulWidget {
//   const FloatingActionButtonWithBottomNav({Key? key}) : super(key: key);
//
//   @override
//   _FloatingActionButtonWithBottomNavState createState() =>
//       _FloatingActionButtonWithBottomNavState();
// }
//
// class _FloatingActionButtonWithBottomNavState
//     extends State<FloatingActionButtonWithBottomNav> {
//   bool _showBottomNav = false;
//
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         if (!_showBottomNav) // Show floating button if bottom nav is not visible
//           FloatingActionButton(
//             backgroundColor: const Color(0xff06113c),
//             onPressed: () {
//               setState(() {
//                 _showBottomNav = true;
//               });
//             },
//             child: const Icon(Icons.menu, color: Colors.white),
//           ),
//         AnimatedPositioned(
//           duration: const Duration(milliseconds: 300),
//           bottom: _showBottomNav ? 0 : -kBottomNavigationBarHeight - 16, // Adjust the value for padding
//           left: 35, // Add left margin
//           right: 15, // Add right margin
//           child: Container(
//             decoration: BoxDecoration(
//               color: Colors.white,
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.grey.withOpacity(0.8), // Increase opacity for shadow
//                   spreadRadius: 10, // Increase spread radius for shadow
//                   blurRadius: 10, // Increase blur radius for shadow
//                   offset: const Offset(0, 3),
//                 ),
//               ],
//             ),
//             child: BottomNavigationBar(
//               items: const [
//                 BottomNavigationBarItem(
//                   backgroundColor: Color(0xff06113c),
//                   icon: Icon(Icons.home),
//                   label: 'Home',
//                 ),
//                 BottomNavigationBarItem(
//                   icon: Icon(Icons.dynamic_feed),
//                   label: 'feeds',
//                 ),
//                 BottomNavigationBarItem(
//                   icon: Icon(Icons.add_a_photo),
//                   label: 'upload',
//                 ),
//                 BottomNavigationBarItem(
//                   icon: Icon(Icons.person),
//                   label: 'profile',
//                 ),
//                 BottomNavigationBarItem(
//                   icon: Icon(Icons.arrow_back),
//                   label: 'back',
//                 ),
//               ],
//               onTap: (index) {
//
//                 switch (index) {
//                   case 0:
//                   // Navigate to Home Page
//                     Get.toNamed('/home');
//                     break;
//                   case 1:
//                   // Navigate to Settings Page
//                     Get.toNamed('/feed');
//                     break;
//                   case 2:
//                   // Navigate to Settings Page
//                     Get.toNamed('/add_photo');
//                     break;
//                   case 3:
//                   // Navigate to Settings Page
//                     Get.toNamed('/register');
//                     break;
//                   default:
//                   // Default case if needed
//                     break;
//                 }
//
//                 setState(() {
//                   _showBottomNav = false;
//                 });
//               },
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }

