import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:renting_app/dashboard/dashboard_view/dashbord_components/app_bar/appbar_view.dart';
import 'package:renting_app/dashboard/dashboard_view/feed_page/feed_controller.dart';
import 'package:renting_app/dashboard/dashboard_view/dashbord_components/search_bar/search_bar_view.dart';
import 'package:renting_app/dashboard/dashboard_view/dashbord_components/buttom_nav/bottom_nav_view.dart';

class FeedPage extends StatelessWidget {
  const FeedPage({super.key});

  @override
  Widget build(BuildContext context) {
    final FeedController controller = Get.find(); // Retrieve the FeedController instance

    return Scaffold(
      backgroundColor: const Color(0xffF7EBE1),
      appBar: CustomAppBar(),
      body: SafeArea(
        child: Column(
          children: [
            SearchBarWithFilter(),
            Expanded(
              child: Obx(() {
                // Observe changes in the feedItems list
                if (controller.feedItems.isEmpty) {
                  return const Center(child: CircularProgressIndicator()); // Show loading indicator while fetching
                }
                return ListView.builder(
                  itemCount: controller.feedItems.length,
                  itemBuilder: (context, index) {
                    final item = controller.feedItems[index];
                    return Card(
                      margin: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.white,
                              Colors.white70],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(
                              children: [
                                Container(
                                  height: 200.0,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(item.imageUrl), // Use item image
                                      fit: BoxFit.cover,
                                    ),
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(8.0),
                                      topRight: Radius.circular(8.0),
                                    ),
                                  ),

                                ),
                                Positioned(
                                  top: 8.0,
                                  right: 8.0,
                                  child: Container(
                                    padding: const EdgeInsets.all(4.0),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(50.0),
                                    ),
                                    child: const Icon(Icons.location_on, color: Color(0xff06113c)),
                                  ),
                                ),
                                Positioned(
                                  top: 8.0,
                                  left: 8.0,
                                  child: CircleAvatar(
                                    backgroundImage: AssetImage(item.profileImageUrl),
                                    backgroundColor: const Color(0xff06113c), // Use item profile image
                                    radius: 20.0,
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(item.title, style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
                                  const SizedBox(height: 4.0),
                                  Text(item.datePosted, style: const TextStyle(color: Colors.grey)),
                                  const SizedBox(height: 8.0),
                                  Row(
                                    children: [
                                      const Icon(Icons.bathtub, size: 16.0),
                                      const SizedBox(width: 4.0),
                                      Text('${item.bathroomCount}'),
                                      const SizedBox(width: 16.0),
                                      const Icon(Icons.wifi, size: 16.0),
                                      const SizedBox(width: 4.0),
                                      Text(item.wifi),
                                      const SizedBox(width: 16.0),
                                      const Icon(Icons.bed, size: 16.0),
                                      const SizedBox(width: 4.0),
                                      Text('${item.bedroomCount}'),
                                    ],
                                  ),
                                  const SizedBox(height: 8.0),
                                  Text(item.description),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
      // floatingActionButton: const FloatingActionButtonWithBottomNav(),
    );
  }
}
