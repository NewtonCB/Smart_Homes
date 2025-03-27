import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import '../../details_page/details_view.dart';

class VerticalScrollCards extends StatefulWidget {
  @override
  _VerticalScrollCardsState createState() => _VerticalScrollCardsState();
}

class _VerticalScrollCardsState extends State<VerticalScrollCards> {
  final DatabaseReference postsRef = FirebaseDatabase.instance.ref().child('posts');
  List<Map<String, dynamic>> postsList = [];
  List<Map<String, dynamic>> filteredPostsList = [];

  @override
  void initState() {
    super.initState();
    fetchPosts();
  }

  void fetchPosts() {
    postsRef.onValue.listen((DatabaseEvent event) {
      if (event.snapshot.value != null) {
        Map<dynamic, dynamic> posts = event.snapshot.value as Map<dynamic, dynamic>;
        List<Map<String, dynamic>> fetchedPostsList = [];

        for (var entry in posts.entries) {
          Map<String, dynamic> post = Map<String, dynamic>.from(entry.value);
          post['key'] = entry.key;

          // Ensure images are correctly parsed
          post['images'] = post['images'] != null ? List<String>.from(post['images']) : <String>[];

          // Parse timestamp
          if (post['timestamp'] != null && post['timestamp'] is String) {
            post['timestamp'] = DateTime.parse(post['timestamp']);
          }

          fetchedPostsList.add(post);
        }

        setState(() {
          postsList = fetchedPostsList;
          filteredPostsList = _filterPosts(fetchedPostsList);
        });
      } else {
        setState(() {
          postsList = [];
          filteredPostsList = [];
        });
      }
    });
  }

  List<Map<String, dynamic>> _filterPosts(List<Map<String, dynamic>> posts) {
    DateTime now = DateTime.now();
    return posts.where((post) {
      DateTime postDate = post['timestamp'];
      return now.difference(postDate).inDays < 1; // Show posts from the last 24 hours
    }).toList();
  }

  String formatTimePosted(DateTime postDate) {
    Duration diff = DateTime.now().difference(postDate);
    if (diff.inDays > 0) {
      return '${diff.inDays} days ago';
    } else if (diff.inHours > 0) {
      return '${diff.inHours} hours ago';
    } else if (diff.inMinutes > 0) {
      return '${diff.inMinutes} minutes ago';
    } else if (diff.inSeconds > 0) {
      return '${diff.inSeconds} seconds ago';
    } else {
      return 'Just now';
    }
  }

  @override
  Widget build(BuildContext context) {
    return filteredPostsList.isEmpty
        ? Center(
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.red[100],
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: Colors.red, width: 1.5),
        ),
        child: const Text(
          'Oops! Nothing has posted today.',
          style: TextStyle(color: Colors.red, fontSize: 16.0),
          textAlign: TextAlign.center,
        ),
      ),
    )
        : ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: filteredPostsList.length,
      itemBuilder: (context, index) {
        Map<String, dynamic> post = filteredPostsList[index];
        String coverImage = post['images'].isNotEmpty ? post['images'][0] : 'assets/images/house1.jpg';
        String title = post['title'] ?? 'No Title';
        DateTime postDate = post['timestamp'];
        String timePosted = formatTimePosted(postDate);
        bool hasWifi = post['amenities']?.contains('wifi') ?? false;
        bool hasBathroom = post['amenities']?.contains('bathroom') ?? false;
        bool hasFence = post['amenities']?.contains('fence') ?? false;
        bool hasAC = post['amenities']?.contains('ac') ?? false;
        String rentAmount = post['rentAmount'] ?? 'No Rent Amount';

        return GestureDetector(
          onTap: () {
            // Navigate to details page
            Get.to(() => DetailsPage(post: post));
          },
          child: Card(
            margin: const EdgeInsets.all(8.0),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 80.0,
                        height: 80.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          image: DecorationImage(
                            image: coverImage.startsWith('http') ? NetworkImage(coverImage) : AssetImage(coverImage) as ImageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16.0),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              title,
                              style: const TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              timePosted,
                              style: const TextStyle(fontSize: 14.0),
                            ),
                            Wrap(
                              spacing: 8.0,
                              runSpacing: 4.0,
                              children: [
                                if (hasWifi) ...[
                                  const Icon(Icons.wifi, size: 20.0),
                                  const Text('Wifi', style: TextStyle(fontSize: 12.0)),
                                ],
                                if (hasBathroom) ...[
                                  const Icon(Icons.bathtub, size: 20.0),
                                  const Text('Bathroom', style: TextStyle(fontSize: 12.0)),
                                ],
                                if (hasFence) ...[
                                  const Icon(Icons.home, size: 20.0),
                                  const Text('Inside a gate', style: TextStyle(fontSize: 12.0)),
                                ],
                                if (hasAC) ...[
                                  const Icon(Icons.ac_unit, size: 20.0),
                                  const Text('AC', style: TextStyle(fontSize: 12.0)),
                                ],
                              ],
                            ),
                            const SizedBox(height: 5,),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: Text(
                                '$rentAmount Tsh/Month',
                                style: const TextStyle(
                                  fontSize: 13.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
