import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:renting_app/dashboard/dashboard_view/feed_page/feed_page_view.dart';
import 'package:renting_app/dashboard/dashboard_view/dashbord_components/search_bar/search_bar_controller.dart';

import 'filter_dialogue.dart';

class SearchBarWithFilter extends StatelessWidget {
  final TextEditingController controller;

  SearchBarWithFilter({required this.controller});

  @override
  Widget build(BuildContext context) {
    final CustomSearchController searchController = Get.find();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 4.0,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: TextField(
                controller: controller,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.5,
                ),
                cursorColor: const Color(0xff06113c),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  suffixIcon: const Icon(
                      Icons.search_rounded,
                      color: Color(0xff06113c),


                  ),
                  hintText: 'Search address, or near you',
                  hintStyle: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.5,
                    color: Colors.grey,
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide.none,
                  ),
                ),
                onChanged: (value) {
                  searchController.updateSearchQuery(value);
                },
                onSubmitted: (value) {
                  searchController.updateSearchQuery(value);
                  Get.to(() => FeedPage(
                    searchQuery: controller.text,
                    priceRange: '',
                    district: '',
                    propertyType: '',)); // Navigate to FeedPage on search submit
                },
              ),
            ),
          ),
          const SizedBox(width: 8.0),
          IconButton(
            icon: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color(0xff06113c),
                borderRadius: BorderRadius.circular(8.0), // Rounded corners
              ),
              child: const Icon(
                Icons.tune,
                color: Colors.white,
                size: 20.0,
              ),
            ),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => FilterDialog(),
              );
            },
          ),
        ],
      ),
    );
  }
}
