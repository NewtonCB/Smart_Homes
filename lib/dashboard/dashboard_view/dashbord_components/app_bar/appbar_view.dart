import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text(
        'smartRENTAL',
        style: TextStyle(
          shadows: [
            Shadow(
              blurRadius: 3.0,
              color: Colors.grey,
              offset: Offset(2.0, 2.0),
            ),
          ],
          fontWeight: FontWeight.bold,
          color: Color(0xff06113c),
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.person),
          onPressed: () {},
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
