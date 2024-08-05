import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:intl/intl.dart';

class VerticalScrollCards extends StatefulWidget {
  @override
  _VerticalScrollCardsState createState() => _VerticalScrollCardsState();
}

class _VerticalScrollCardsState extends State<VerticalScrollCards> {
  final DatabaseReference postsRef = FirebaseDatabase.instance.ref().child('posts');
  List<Map<String, dynamic>> postsList = [];

  @override
  void initState() {
    super.initState();
    fetchPosts();
  }

  Future<void> fetchPosts() async {
    postsRef.onValue.listen((DatabaseEvent event) {
      if (event.snapshot.value != null) {
        Map<dynamic, dynamic> posts = event.snapshot.value as Map<dynamic, dynamic>;
        List<Map<String, dynamic>> fetchedPostsList = [];

        for (var entry in posts.entries) {
          Map<String, dynamic> post = Map<String, dynamic>.from(entry.value);
          post['key'] = entry.key;

          // Ensure images are correctly parsed
          post['images'] = post['images'] != null ? List<String>.from(post['images']) : <String>[];

          // Ensure rentAmount is parsed as a string
          post['rentAmount'] = post['rentAmount']?.toString() ?? 'No Rent Amount';

          // Parse timestamp as an integer
          if (post['timestamp'] != null && post['timestamp'] is String) {
            post['timestamp'] = int.tryParse(post['timestamp']) ?? 0;
          } else if (post['timestamp'] == null) {
            post['timestamp'] = 0;
          }

          fetchedPostsList.add(post);
        }

        setState(() {
          postsList = fetchedPostsList;
        });
      } else {
        setState(() {
          postsList = [];
        });
      }
    });
  }

  String formatTimePosted(int timestamp) {
    if (timestamp == 0) return 'Unknown Time';
    DateTime date = DateTime.fromMillisecondsSinceEpoch(timestamp);
    return DateFormat('dd MMM yyyy, hh:mm a').format(date);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: postsList.length,
      itemBuilder: (context, index) {
        Map<String, dynamic> post = postsList[index];
        String coverImage = post['images'].isNotEmpty ? post['images'][0] : 'assets/images/house1.jpg';
        String title = post['title'] ?? 'No Title';
        String timePosted = formatTimePosted(post['timestamp']);
        bool hasWifi = post['amenities'].contains('wifi');
        bool hasBathroom = post['amenities'].contains('bathroom');
        bool hasFence = post['amenities'].contains('fence');
        bool hasAC = post['amenities'].contains('ac');
        String rentAmount = post['rentAmount'] ?? 'No Rent Amount';

        return GestureDetector(
          onTap: () {
            // Handle card tap, navigate to details page in future
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
