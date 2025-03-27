import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:math';
import 'package:get/get.dart';

import '../../details_page/details_view.dart';

class HorizontalScrollCards extends StatefulWidget {
  const HorizontalScrollCards({super.key});

  @override
  _HorizontalScrollCardsState createState() => _HorizontalScrollCardsState();
}

class _HorizontalScrollCardsState extends State<HorizontalScrollCards> {
  final DatabaseReference postsRef = FirebaseDatabase.instance.ref().child('posts');
  List<Map<String, dynamic>> postsList = [];
  Position? _currentPosition;

  @override
  void initState() {
    super.initState();
    fetchPosts();
    _determinePosition();
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
          if (post['images'] != null) {
            post['images'] = (post['images'] as List<dynamic>).map((e) => e.toString()).toList();
          } else {
            post['images'] = <String>[]; // Set to empty list if null
          }

          fetchedPostsList.add(post);
        }

        setState(() {
          postsList = fetchedPostsList;
        });
      } else {
        // Handle case where no posts exist
        setState(() {
          postsList = [];
        });
      }
    });
  }

  Future<void> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied, we cannot request permissions.');
    }

    _currentPosition = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    setState(() {});
  }

  double calculateDistance(double startLatitude, double startLongitude, double endLatitude, double endLongitude) {
    const double earthRadius = 6371; // Earth radius in kilometers
    double dLat = _degreesToRadians(endLatitude - startLatitude);
    double dLng = _degreesToRadians(endLongitude - startLongitude);
    double a = sin(dLat / 2) * sin(dLat / 2) +
        cos(_degreesToRadians(startLatitude)) * cos(_degreesToRadians(endLatitude)) *
            sin(dLng / 2) * sin(dLng / 2);
    double c = 2 * atan2(sqrt(a), sqrt(1 - a));
    return earthRadius * c;
  }

  double _degreesToRadians(double degrees) {
    return degrees * pi / 180;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200.0,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: postsList.length,
        itemBuilder: (context, index) {
          Map<String, dynamic> post = postsList[index];
          String coverImage = post['images'].isNotEmpty ? post['images'][0] : 'assets/images/house2.jpg';
          String title = post['title'] ?? 'No Title';
          String rentAmount = post['rentAmount'] ?? 'No Rent Amount';

          double? distance;
          if (_currentPosition != null && post['location'] != null) {
            double lat = post['location']['latitude'];
            double lng = post['location']['longitude'];
            distance = calculateDistance(_currentPosition!.latitude, _currentPosition!.longitude, lat, lng);
          }

          return GestureDetector(
            onTap: () {
              // Navigate to details page
              Get.to(() => DetailsPage(post: post));
            },
            child: Container(
              width: 160.0,
              margin: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: coverImage.startsWith('http') ? NetworkImage(coverImage) : AssetImage(coverImage) as ImageProvider,
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: 8.0,
                    right: 8.0,
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.location_on, color: Colors.white, size: 16.0),
                          SizedBox(width: 4.0),
                          Text(
                            distance != null ? '${distance.toStringAsFixed(1)} km' : 'Calculating...',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 8.0,
                    left: 8.0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          '$rentAmount Tsh/Month',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
