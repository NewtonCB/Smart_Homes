import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Nestify/dashboard/dashboard_view/dashbord_components/search_bar/search_bar_view.dart';
import 'package:get/get.dart';
// import 'theme_controller.dart'; // Import the ThemeController

// Top Bar Component
class TopBar extends StatelessWidget {
  // final ThemeController themeController = Get.put(ThemeController());

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160.h,
      decoration: const BoxDecoration(
        color: Colors.white54,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: Column(children: [
        SizedBox(height: 20.sp),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: SearchBarWithFilter(controller: SearchController()),
        ),
      ]),
    );
  }
}

