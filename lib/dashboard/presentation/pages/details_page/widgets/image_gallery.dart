import 'package:flutter/material.dart';
import 'package:renting_app/dashboard/gen/assets.gen.dart';
import 'package:renting_app/dashboard/presentation/components/text.dart';
import 'package:renting_app/dashboard/presentation/themes/colors.dart';
import 'package:renting_app/dashboard/presentation/themes/config_files/screen_size_config.dart';

const int _imageCount = 4;
const int _spaceBetween = 16;
const int _screenPadding = 16 * 2;

class ImageGallery__widget extends StatelessWidget {
  const ImageGallery__widget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        image_gallery_item(assetImage: Assets.images.additional1.path),
        image_gallery_item(assetImage: Assets.images.additional2.path),
        image_gallery_item(assetImage: Assets.images.additional3.path),
        GestureDetector(
          onTap: () {
            // Show popup view
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return const ImagePopupView();
              },
            );
          },
          child: image_gallery_item(
            assetImage: Assets.images.additional4.path,
            isMask: true,
          ),
        ),
      ],
    );
  }
}

final _screenWidth = ScreenConfig.screenWidth;
const _gapCount = _imageCount - 1;
const _totalSpace = _screenPadding + (_gapCount * _spaceBetween);
final double _availableSpace = _screenWidth - _totalSpace;
final double _itemSize = _availableSpace / _imageCount;

class image_gallery_item extends StatelessWidget {
  const image_gallery_item({
    super.key,
    required this.assetImage,
    this.isMask = false,
  });

  final String assetImage;
  final bool isMask;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: _itemSize,
          width: _itemSize,
          decoration: BoxDecoration(
            color: kColorText2,
            borderRadius: BorderRadius.circular(10),
            shape: BoxShape.rectangle,
            image: DecorationImage(image: AssetImage(assetImage)),
          ),
        ),
        Visibility(
          visible: isMask,
          child: Container(
            height: _itemSize,
            width: _itemSize,
            decoration: BoxDecoration(
              color: kColorBlack.withOpacity(0.5),
              borderRadius: BorderRadius.circular(10),
              shape: BoxShape.rectangle,
            ),
            child: const Center(
              child: TitleMedium__text(text: '+5', color: kColorWhite),
            ),
          ),
        ),
      ],
    );
  }
}

class ImagePopupView extends StatelessWidget {
  const ImagePopupView({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Gallery',
        style: TextStyle(
          fontSize: 18,
          color: kColorText1,

        ),
      ),
      content: SizedBox(
        width: double.maxFinite,
        height: 300, // Adjust height as needed
        child: ListView.builder(
          itemCount: _imageCount,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                Assets.images.additional1.path, // Replace with actual image path
                fit: BoxFit.cover,
              ),
            );
          },
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text(

              'Close',
            style: TextStyle(
              color: kColorText1,
            ),
          ),
        ),
      ],
    );
  }
}
