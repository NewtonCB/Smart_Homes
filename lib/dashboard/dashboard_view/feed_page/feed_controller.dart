import 'package:get/get.dart';

class FeedController extends GetxController {
  // Observable list of feed items
  var feedItems = <FeedItem>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchFeedData(); // Fetch data when the controller is initialized
  }

  // Fetches feed data
  void fetchFeedData() {
    // Example data fetching logic
    // In a real app, this could be from an API or database
    feedItems.value = List.generate(
      10,
          (index) => FeedItem(
        title: 'Post Title $index',
        description: 'This is the description for post $index',
        imageUrl: 'assets/img/house_4.jpg',
        profileImageUrl: 'assets/img/imgagent.png',
        location: 'Location $index',
        datePosted: 'Posted 3 days ago',
        bathroomCount: 1,
        bedroomCount: 2,
        wifi: 'Free',
      ),
    );
  }
}

// FeedItem class to represent each item
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
