import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:geolocator/geolocator.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:Nestify/posting_page/post_model.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';

class PostingPageController extends GetxController {
  var name = ''.obs;
  var phoneNumber = ''.obs;
  var title = 'Choose Type of Property'.obs;
  var description = ''.obs;
  var rentAmount = ''.obs;
  var rentPeriod = 'Choose Rent Period'.obs;
  var selectedDistrict = 'Ilala'.obs;
  var location = Location(latitude: 0, longitude: 0).obs;
  var selectedImages = <XFile>[].obs;
  var amenities = <String>[].obs;

  final ImagePicker picker = ImagePicker();

  // Function to pick images
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

  Future<List<String>> uploadImages(List<XFile> images) async {
    List<String> imageUrls = [];
    try {
      final storage = FirebaseStorage.instance;
      for (var image in images) {
        final ref = storage.ref().child('post_images/${DateTime.now().millisecondsSinceEpoch}_${image.name}');

        print('Uploading ${image.name} to Firebase Storage'); // Debug statement
        await ref.putFile(File(image.path));

        final url = await ref.getDownloadURL();
        print('Uploaded ${image.name}, URL: $url'); // Debug statement
        imageUrls.add(url);
      }
    } catch (e) {
      print('Failed to upload images: $e');
    }
    return imageUrls;
  }

  Future<void> uploadPost(BuildContext context) async {
    // Show loading dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Center(
          child: LoadingAnimationWidget.staggeredDotsWave(
            color: const Color(0xff06113c),
            size: 50,
          ),
        );
      },
    );

    // Get image URLs after uploading
    List<String> imageUrls = await uploadImages(selectedImages);

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
      images: imageUrls,
      timestamp: DateTime.now().toIso8601String(),
    );

    print('New Post Data: ${newPost.toJson()}'); // Debug statement

    try {
      await FirebaseDatabase.instance.ref().child('posts').push().set(newPost.toJson());

      // Close loading dialog
      Navigator.of(context).pop();

      // Show success dialog
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
                  // Clear form data
                  name.value = '';
                  phoneNumber.value = '';
                  title.value = 'Choose Type of Property';
                  description.value = '';
                  rentAmount.value = '';
                  rentPeriod.value = 'Choose Rent Period';
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
      // Close loading dialog
      Navigator.of(context).pop();
      print('Failed to upload post: $error');
    }
  }

}
