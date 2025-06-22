import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:Nestify/dashboard/dashboard_view/dashbord_components/swipe_image/swiper_controller.dart';

class SwipeImageContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final SwiperController controller = Get.find<SwiperController>();

    return GetBuilder<SwiperController>(
      builder: (_) {
        return Stack(
          children: [
            Container(
              width: double.infinity,
              height: 150.0.h,
              margin: const EdgeInsets.symmetric(vertical: 16.0),
              decoration: const BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black38,
                    blurRadius: 5,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Stack(
                children: [
                  PageView.builder(
                    controller: controller.pageController,
                    itemCount: controller.images.length, // Use the actual count
                    onPageChanged: (page) {
                      controller.currentPage = page;
                      controller.update();
                    },
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10.0),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(controller.images[index].imagePath),
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
                          (controller.images.length / controller.itemsToSlide).ceil(),
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
