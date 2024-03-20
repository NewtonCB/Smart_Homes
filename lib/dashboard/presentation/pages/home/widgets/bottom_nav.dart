import 'package:flutter/material.dart';

class FloatingActionButtonWithBottomNav extends StatefulWidget {
  const FloatingActionButtonWithBottomNav({super.key});

  @override
  _FloatingActionButtonWithBottomNavState createState() => _FloatingActionButtonWithBottomNavState();
}

class _FloatingActionButtonWithBottomNavState extends State<FloatingActionButtonWithBottomNav> {
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
            child: const Icon(
              color: Colors.white,
                Icons.menu
            ),
          ),
        AnimatedPositioned(
          duration: const Duration(milliseconds: 300),
          bottom: _showBottomNav ? 0 : - kBottomNavigationBarHeight - 16, // Adjust the value for padding
          left: 16, // Add left margin
          right: 0, // Add right margin


          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 16), // Add margin space
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.8), // Increase opacity for shadow
                  spreadRadius: 4, // Increase spread radius for shadow
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
                  label: 'Chats',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: 'Messages',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.arrow_back),
                  label: 'Search',
                ),
              ],
              onTap: (index) {
                // Handle navigation to different screens here
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
