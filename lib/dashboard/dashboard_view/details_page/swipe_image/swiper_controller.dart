// lib/controllers/swiper_controller.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SwipeController extends GetxController {
  final PageController pageController = PageController();
  final List<String> imageUrls = []; // List of image URLs
  int currentPage = 0;
  final int itemsToSlide = 1;

  void setImages(List<String> newImageUrls) {
    imageUrls.clear();
    imageUrls.addAll(newImageUrls);
    update();
  }

  void nextPage() {
    pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void previousPage() {
    pageController.previousPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }
}