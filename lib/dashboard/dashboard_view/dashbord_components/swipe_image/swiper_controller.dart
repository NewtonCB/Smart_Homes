// lib/controllers/swiper_controller.dart

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SwiperController extends GetxController {
  late PageController pageController;
  final int itemCount = 5; // Number of slides
  int currentPage = 0;

  @override
  void onInit() {
    super.onInit();
    pageController = PageController(
      initialPage: 0,
    );

    // Auto-scroll timer
    Timer.periodic(const Duration(seconds: 5), (Timer timer) {
      if (pageController.hasClients) {
        currentPage = (currentPage + 1) % itemCount;
        pageController.animateToPage(
          currentPage,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
        update(); // Notify listeners
      }
    });
  }

  void nextPage() {
    if (pageController.hasClients) {
      currentPage = (currentPage + 1) % itemCount;
      pageController.animateToPage(
        currentPage,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      update(); // Notify listeners
    }
  }

  void previousPage() {
    if (pageController.hasClients) {
      currentPage = (currentPage - 1 + itemCount) % itemCount;
      pageController.animateToPage(
        currentPage,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      update(); // Notify listeners
    }
  }
}
