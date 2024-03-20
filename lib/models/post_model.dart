class Post {
  final String authorName;
  final String authorImageUrl;
  final String timeAgo;
  final String imageUrl;
  bool isLiked; // New property
  int likeCount;

  Post({
    required this.authorName,
    required this.authorImageUrl,
    required this.timeAgo,
    required this.imageUrl,
    this.isLiked = false, // Default value
    this.likeCount = 0, // Default value
  });
}


final List<Post> posts = [
  Post(
    authorName: 'Sam Martin',
    authorImageUrl: 'assets/img/post0.jpg',
    timeAgo: '5 min',
    imageUrl: 'assets/img/house_1.jpeg',
  ),
  Post(
    authorName: 'Sam Martin',
    authorImageUrl: 'assets/img/post0.jpg',
    timeAgo: '10 min',
    imageUrl: 'assets/img/house_2.jpeg',
  ),
];

final List<String> stories = [
  'assets/img/build_1.jpg',
  'assets/img/house_1.jpeg',
  'assets/img/house_2.jpeg',
  'assets/img/room_1.jpg',
  'assets/img/room_2.jpeg',
  'assets/img/transport_1.jpg',

];
