import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:Nestify/registration_login/view/registration_view.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      // backgroundColor:  Colors.grey,
      title: Container(
        // margin: EdgeInsets.only(left: 10),
          child: Image.asset(
            'assets/logos/app_bar.png',
            width: 110.w,
            height: 120.h
          )
      ),  // Add your logo
      // leadingWidth: 0.01,
      actions: [
        IconButton(
          icon: const Icon(
              Icons.notifications,
            color: Color(0xff06113c),
          ),
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(
              Icons.settings,
            color: Color(0xff06113c),
          ),
          onPressed: () {},
        ),
      ],
      // backgroundColor: Colors.white,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

