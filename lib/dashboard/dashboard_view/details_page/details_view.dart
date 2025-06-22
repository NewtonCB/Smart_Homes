import 'package:flutter/material.dart';
import 'package:Nestify/dashboard/dashboard_view/details_page/swipe_image/swipe_img_view.dart';
import 'package:url_launcher/url_launcher.dart';


class DetailsPage extends StatelessWidget {
  final Map<String, dynamic> post;

  DetailsPage({required this.post});

  @override
  Widget build(BuildContext context) {
    List<String> images = List<String>.from(post['images'] ?? []);
    double latitude = post['location']['latitude'];
    double longitude = post['location']['longitude'];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          'Details',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(5.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image swiper (assuming SwiperImageContainer is defined elsewhere)
              SwiperImageContainer(imageUrls: images),
              // Description and details
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title and price
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Expanded(
                          child: Text(
                             'Rent Amount',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 8),
                          decoration: BoxDecoration(
                            color: Colors.blue.shade50,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            '${post['rentAmount'] ?? '0'} Tsh/Month',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color:  Color(0xff06113c) ,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    // Location
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: const Icon(Icons.location_on, color: Colors.grey),
                      title: const Text(
                        'Location',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                      ),
                      trailing:
                      Text(
                        post['district'] ?? 'Unknown Location',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                      // Row(
                      //   children: [
                      //     const Icon(Icons.location_on, color: Colors.grey),
                      //     const SizedBox(width: 5),
                      //     Text(
                      //       post['district'] ?? 'Unknown Location',
                      //       style: const TextStyle(
                      //         fontSize: 16,
                      //         color: Colors.grey,
                      //       ),
                      //     ),
                      //   ],
                      // ),
                    ),
                    const SizedBox(height: 20),
                    // Divider
                    const Divider(color: Colors.grey, thickness: 0.5),
                    const SizedBox(height: 20),
                    // Poster info with decorated ListTile
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: const LinearGradient(
                            colors: [Color(0xff758694), Color(0xff06113c)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 10,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.account_circle,
                          size: 40,
                          color: Colors.white,
                        ),
                      ),
                      title: Text(
                        post['name'] ?? 'Posted by User',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      trailing: GestureDetector(
                        onTap: () {
                          // Launch phone dialer when tapped
                          final phoneNumber = post['phoneNumber'];
                          if (phoneNumber != null && phoneNumber.isNotEmpty) {
                            launch('tel:$phoneNumber');
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('No phone number available'),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: const LinearGradient(
                              colors: [Color(0xff758694), Color(0xff06113c)],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 10,
                                offset: const Offset(0, 5),
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.phone,
                            size: 24,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Description
                    const Text(
                      'Description',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      post['description'] ?? 'No description provided.',
                      style: const TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                    const SizedBox(height: 20),
                    // Google Maps button
                    SizedBox(
                      width: double.infinity,
                      child: GestureDetector(
                        onTap: () => _navigateToGoogleMaps(latitude, longitude),
                        child: Container(
                          height: 150, // Adjust height as needed
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: const DecorationImage(
                              image: AssetImage('assets/img/google.jpg'), // Add a mockup image
                              fit: BoxFit.cover,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.3),
                                blurRadius: 10,
                                offset: const Offset(0, 5),
                              ),
                            ],
                          ),
                          child: Center(
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.6),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: const Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.map, color: Colors.white),
                                  SizedBox(width: 8),
                                  Text(
                                    'Track The Location',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _navigateToGoogleMaps(double latitude, double longitude) async {
    final url = 'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}