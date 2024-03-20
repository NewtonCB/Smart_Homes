import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:renting_app/dashboard/gen/assets.gen.dart';
import 'package:renting_app/dashboard/presentation/components/text.dart';
import 'package:renting_app/dashboard/presentation/themes/colors.dart';
import 'package:renting_app/dashboard/presentation/themes/config.dart';

PreferredSize appbar__widget() {
  return PreferredSize(
    preferredSize: const Size(double.infinity, 75),
    child: AppBar(
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: kColorScaffold,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: kColorScaffold,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
      backgroundColor: kColorScaffold,
      elevation: 0,
      title: Padding(
        padding: const EdgeInsets.only(top: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '2KonecT',
              style: TextStyle(
                fontSize: 24, // Adjust font size as needed
                fontWeight: FontWeight.bold, // Use heavy bold
                color: kColorText1,
                shadows: [
                  Shadow(
                    color: Colors.black.withOpacity(0.5),
                    offset: const Offset(2, 2),
                    blurRadius: 2,
                  ),
                ],
              ),
            ),

            const Spacer(),
            GestureDetector(
              onTap: () {
                // Handle sign up action
              },
              child: const CircleAvatar(
                radius: 15,
                backgroundColor: kColorPrimary,
                child: Icon(
                  Icons.person,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(width: 16),
          ],
        ),
      ),
    ),
  );
}
