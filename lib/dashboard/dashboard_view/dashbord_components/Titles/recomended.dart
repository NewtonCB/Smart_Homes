import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:renting_app/dashboard/dashboard_view/feed_page/feed_controller.dart';
import 'package:renting_app/dashboard/dashboard_view/feed_page/feed_page_view.dart';

class Recommended extends StatelessWidget {
  const Recommended({super.key});

  @override
  Widget build(BuildContext context) {
    final FeedController controller = Get.put(FeedController()); // Ensure FeedController is available

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Recommended',
            style: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.bold,
              color:  Color(0xff06113c),
            ),
          ),
          TextButton(
            onPressed: () {
              Get.to(() =>  FeedPage(), binding: BindingsBuilder(() {
              }));
            },
            child: const Text(
                'See more',
              style: TextStyle(
                color:  Color(0xff06113c),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
