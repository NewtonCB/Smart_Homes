import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import '../dashbord_components/app_bar/appbar_view.dart';
import 'package:renting_app/dashboard/dashboard_view/dashbord_components/search_bar/search_bar_controller.dart';
import 'swiper_component.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({super.key});

  @override
  _FeedPageState createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  final DatabaseReference postsRef = FirebaseDatabase.instance.ref().child('posts');
  final CustomSearchController searchController = Get.find();
  List<Map<String, dynamic>> postsList = [];
  List<Map<String, dynamic>> filteredPostsList = [];

  @override
  void initState() {
    super.initState();
    fetchPosts();
    searchController.searchQuery.listen((query) {
      _filterPosts(query);
    });
  }

  void fetchPosts() {
    postsRef.onValue.listen((DatabaseEvent event) {
      if (event.snapshot.value != null) {
        Map<dynamic, dynamic> posts = event.snapshot.value as Map<dynamic, dynamic>;
        List<Map<String, dynamic>> fetchedPostsList = [];

        for (var entry in posts.entries) {
          Map<String, dynamic> post = Map<String, dynamic>.from(entry.value);
          post['key'] = entry.key;

          // Debugging: Log fetched data
          print('Fetched post data: $post');

          // Ensure images are correctly parsed
          if (post['images'] != null) {
            post['images'] = (post['images'] as List<dynamic>).map((e) => e.toString()).toList();
          } else {
            post['images'] = <String>[]; // Set to empty list if null
          }

          // Check URL accessibility and format
          post['images'].forEach((url) {
            // Log each URL for debugging
            print('Image URL: $url');
          });

          fetchedPostsList.add(post);
        }

        setState(() {
          postsList = fetchedPostsList;
          filteredPostsList = postsList;
          _filterPosts(searchController.searchQuery.value);
        });
      } else {
        // Handle case where no posts exist
        print('No posts available');
        setState(() {
          postsList = [];
          filteredPostsList = [];
        });
      }
    });
  }

  void _filterPosts(String query) {
    setState(() {
      filteredPostsList = postsList.where((post) {
        String title = post['title']?.toLowerCase() ?? '';
        String description = post['description']?.toLowerCase() ?? '';
        return title.contains(query.toLowerCase()) || description.contains(query.toLowerCase());
      }).toList();
    });
  }

  String timeAgo(DateTime date) {
    Duration diff = DateTime.now().difference(date);
    if (diff.inDays >= 1) {
      return '${diff.inDays} days ago';
    } else if (diff.inHours >= 1) {
      return '${diff.inHours} hours ago';
    } else if (diff.inMinutes >= 1) {
      return '${diff.inMinutes} minutes ago';
    } else {
      return 'Just now';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF7EBE1),
      appBar: CustomAppBar(),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: filteredPostsList.length,
              itemBuilder: (context, index) {
                Map<String, dynamic> post = filteredPostsList[index];
                DateTime postDate = DateTime.parse(post['timestamp']);
                List<String> imageUrls = List<String>.from(post['images'] ?? []);

                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  elevation: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Check if imageUrls is not empty before passing to CustomSwiper
                        if (imageUrls.isNotEmpty)
                          CustomSwiper(imageUrls: imageUrls),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                post['title'] ?? '',
                                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Text(
                              '${post['rentAmount']} Tsh',
                              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text(
                          timeAgo(postDate),
                          style: const TextStyle(color: Colors.grey),
                        ),
                        const SizedBox(height: 10),
                        Text(post['description'] ?? ''),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            const Icon(Icons.account_circle),
                            const SizedBox(width: 10),
                            Text(post['name'] ?? ''),
                            const SizedBox(width: 20),
                            const Icon(Icons.phone),
                            const SizedBox(width: 10),
                            Text(post['phoneNumber'] ?? ''),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.info),
                              onPressed: () {
                                // Navigate to details page
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.location_on),
                              onPressed: () {
                                // Navigate to location using lat/lng
                                double lat = post['location']['latitude'];
                                double lng = post['location']['longitude'];
                                // Use your preferred method to navigate to Google Maps
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
