import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../feed_page/feed_page_view.dart';

class FilterDialog extends StatefulWidget {
  @override
  _FilterDialogState createState() => _FilterDialogState();
}

class _FilterDialogState extends State<FilterDialog> {
  String? _selectedPriceRange;
  String? _selectedDistrict;
  String? _selectedPropertyType;

  final List<String> priceRanges = [
    '0 - 50k',
    '50k - 100k',
    '100k - 200k',
    '200k - 500k',
    '500k - 1.0M',
  ];

  final List<String> districts = [
    'Ilala',
    'Kinondoni',
    'Ubungo',
    'Temeke',
    'Kigamboni',
  ];

  final List<String> propertyTypes = [
    'Single room',
    'Master room',
    'Living room',
  ];

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Filter Options'),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDropdown('Price Range', priceRanges, _selectedPriceRange, (value) {
              setState(() {
                _selectedPriceRange = value;
              });
            }),
            _buildDropdown('District', districts, _selectedDistrict, (value) {
              setState(() {
                _selectedDistrict = value;
              });
            }),
            _buildDropdown('Property Type', propertyTypes, _selectedPropertyType, (value) {
              setState(() {
                _selectedPropertyType = value;
              });
            }),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Get.back(); // Close the dialog
            _applyFilters();
          },
          child: Text('Apply'),
        ),
        TextButton(
          onPressed: () {
            Get.back(); // Close the dialog
          },
          child: Text('Cancel'),
        ),
      ],
    );
  }

  void _applyFilters() {
    // Pass filter options to FeedPage
    Get.to(() => FeedPage(
      priceRange: _selectedPriceRange ?? '',
      district: _selectedDistrict ?? '',
      propertyType: _selectedPropertyType ?? '',
    ));
  }

  Widget _buildDropdown(
      String title,
      List<String> items,
      String? selectedValue,
      ValueChanged<String?> onChanged,
      ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: title,
          border: OutlineInputBorder(),
        ),
        value: selectedValue,
        items: items.map((item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Text(item),
          );
        }).toList(),
        onChanged: onChanged,
      ),
    );
  }
}
