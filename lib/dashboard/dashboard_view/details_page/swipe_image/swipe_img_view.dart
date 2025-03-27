// lib/dashboard/dashboard_view/details_page/swipe_image/swipe_img_view.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:renting_app/controllers/swiper_controller.dart';
import 'swiper_controller.dart';

class SwiperImageContainer extends StatelessWidget {
  final List<String> imageUrls;

  const SwiperImageContainer({Key? key, required this.imageUrls}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SwipeController controller = Get.put(SwipeController());
    controller.setImages(imageUrls); // Set the image URLs in the controller

    return GetBuilder<SwipeController>(
      builder: (_) {
        return Stack(
          children: [
            Container(
              width: double.infinity,
              height: 200.0,
              margin: const EdgeInsets.symmetric(vertical: 16.0),
              child: Stack(
                children: [
                  PageView.builder(
                    controller: controller.pageController,
                    itemCount: controller.imageUrls.length, // Use the actual count
                    onPageChanged: (page) {
                      controller.currentPage = page;
                      controller.update();
                    },
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10.0),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(controller.imageUrls[index]), // Use NetworkImage
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      );
                    },
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          (controller.imageUrls.length / controller.itemsToSlide).ceil(),
                              (index) {
                            return AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              width: controller.currentPage ~/ controller.itemsToSlide == index ? 12.0 : 8.0,
                              height: 8.0,
                              margin: const EdgeInsets.symmetric(horizontal: 4.0),
                              decoration: BoxDecoration(
                                color: controller.currentPage ~/ controller.itemsToSlide == index ? const Color(0xff06113c) : Colors.white,
                                borderRadius: BorderRadius.circular(4.0),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              left: 0,
              top: 0,
              bottom: 0,
              child: IconButton(
                icon: const Icon(Icons.arrow_left, color: Colors.white),
                onPressed: controller.previousPage,
              ),
            ),
            Positioned(
              right: 0,
              top: 0,
              bottom: 0,
              child: IconButton(
                icon: const Icon(Icons.arrow_right, color: Colors.white),
                onPressed: controller.nextPage,
              ),
            ),
          ],
        );
      },
    );
  }
}