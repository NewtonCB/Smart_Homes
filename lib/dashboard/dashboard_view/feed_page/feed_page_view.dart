import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart'; // Add this import
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

  Future<void> _navigateToGoogleMaps(double latitude, double longitude) async {
    final url = 'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
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

                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: LinearGradient(
                      colors: [Colors.white, Colors.grey[200]!],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 5,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                        ),
                        child: Container(
                          height: 200, // Fixed height for the swiper
                          child: imageUrls.isNotEmpty
                              ? CustomSwiper(imageUrls: imageUrls)
                              : Container(
                            color: Colors.grey[300],
                            child: const Center(
                              child: Text('No Image Available'),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              post['title'] ?? '',
                              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                              overflow: TextOverflow.ellipsis,
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
                                    _navigateToGoogleMaps(lat, lng); // Call the method to open Google Maps
                                  },
                                ),
                                const Spacer(),
                                Text(
                                  '${post['rentAmount']} Tsh/Month',
                                  style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
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
