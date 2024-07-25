import 'package:flutter/material.dart';
import 'package:renting_app/dashboard/dashboard_view/feed_page/feed_controller.dart';

class DetailsPage extends StatelessWidget {
  final FeedItem item;

  const DetailsPage({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(item.imageUrl, fit: BoxFit.cover),
            const SizedBox(height: 16.0),
            Text(item.title, style: const TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8.0),
            Text(item.datePosted, style: const TextStyle(color: Colors.grey)),
            const SizedBox(height: 8.0),
            // Text('Rent: ${item.rentAmount}', style: const TextStyle(fontSize: 18.0)),
            const SizedBox(height: 16.0),
            Text(item.description),
          ],
        ),
      ),
    );
  }
}
