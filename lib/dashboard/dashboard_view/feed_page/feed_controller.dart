import 'package:get/get.dart';
import 'package:firebase_database/firebase_database.dart';

class FeedController extends GetxController {
  var feedItems = <FeedItem>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchFeedData();
  }

  void fetchFeedData() {
    DatabaseReference ref = FirebaseDatabase.instance.ref().child('posts');

    ref.onValue.listen((event) {
      final data = event.snapshot.value as Map<dynamic, dynamic>?;

      if (data != null) {
        feedItems.value = data.entries.map((entry) {
          final post = entry.value as Map<dynamic, dynamic>;
          return FeedItem(
            title: post['title'] ?? '',
            description: post['description'] ?? '',
            imageUrl: post['images'].isNotEmpty ? post['images'][0] : 'assets/img/default_image.png',
            profileImageUrl: 'assets/img/imgagent.png', // Assuming a default profile image
            location: '${post['location']['latitude']}, ${post['location']['longitude']}',
            datePosted: 'Posted ${DateTime.now().difference(DateTime.parse(post['timestamp'])).inDays} days ago',
            bathroomCount: post['bathroomCount'] ?? 0,
            bedroomCount: post['bedroomCount'] ?? 0,
            wifi: post['wifi'] ?? 'No',
          );
        }).toList();
      } else {
        feedItems.clear();
      }
    });
  }
}

class FeedItem {
  final String title;
  final String description;
  final String imageUrl;
  final String profileImageUrl;
  final String location;
  final String datePosted;
  final int bathroomCount;
  final int bedroomCount;
  final String wifi;

  FeedItem({
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.profileImageUrl,
    required this.location,
    required this.datePosted,
    required this.bathroomCount,
    required this.bedroomCount,
    required this.wifi,
  });
}
