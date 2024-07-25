import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:geolocator/geolocator.dart';
import 'package:renting_app/posting_page/post_model.dart';
import 'package:firebase_database/firebase_database.dart';

class PostingPageController extends GetxController {
  var name = ''.obs;
  var phoneNumber = ''.obs;
  var title = ''.obs;
  var description = ''.obs;
  var rentAmount = ''.obs;
  var rentPeriod = 'Per Month'.obs;
  var selectedDistrict = 'Ilala'.obs;
  var location = Location(latitude: 0, longitude: 0).obs;
  var selectedImages = <XFile>[].obs;
  var amenities = <String>[].obs;

  final ImagePicker picker = ImagePicker();

  // Function to pick images one by one
  Future<void> pickImages() async {
    final List<XFile>? images = await picker.pickMultiImage();
    if (images != null) {
      selectedImages.addAll(images);
    }
  }

  void removeAmenity(int index) {
    amenities.removeAt(index);
  }

  Future<void> getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      location.value = Location(latitude: position.latitude, longitude: position.longitude);
    } catch (e) {
      print('Error getting location: $e');
    }
  }

  Future<void> uploadPost(BuildContext context) async {
    final newPost = PostModel(
      name: name.value,
      phoneNumber: phoneNumber.value,
      title: title.value,
      description: description.value,
      rentAmount: rentAmount.value,
      rentPeriod: rentPeriod.value,
      district: selectedDistrict.value,
      location: location.value,
      amenities: amenities.toList(),
      images: selectedImages.map((image) => image.path).toList(),
    );

    try {
      await FirebaseDatabase.instance.ref().child('posts').push().set(newPost.toJson());

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Success'),
            content: const Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.check_circle, color: Colors.green, size: 50),
                SizedBox(height: 20),
                Text('Post uploaded successfully!'),
              ],
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  name.value = '';
                  phoneNumber.value = '';
                  title.value = '';
                  description.value = '';
                  rentAmount.value = '';
                  rentPeriod.value = 'Per Month';
                  selectedDistrict.value = 'Ilala';
                  location.value = Location(latitude: 0, longitude: 0);
                  selectedImages.clear();
                  amenities.clear();
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    } catch (error) {
      print('Failed to upload post: $error');
    }
  }
}
