import 'package:flutter/material.dart';
import 'package:renting_app/dashboard/presentation/components/button.dart';
import 'package:renting_app/dashboard/presentation/components/text.dart';
import 'package:renting_app/dashboard/presentation/pages/details_page/widgets/header_image.dart';
import 'package:renting_app/dashboard/presentation/pages/details_page/widgets/image_gallery.dart';
import 'package:renting_app/dashboard/presentation/pages/details_page/widgets/map.dart';
import 'package:renting_app/dashboard/presentation/pages/details_page/widgets/user_profile.dart';
import 'package:renting_app/dashboard//presentation/themes/colors.dart';
import 'package:renting_app/dashboard/presentation/themes/config.dart';
import 'package:renting_app/dashboard/presentation/pages/home/widgets/bottom_nav.dart';

class ScreenDetails extends StatelessWidget {
  const ScreenDetails({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenConfig().init(context);
    return Scaffold(
      backgroundColor: const Color(0xffF7EBE1),
      body: Stack(
        children: [
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(left: 16, right: 16, bottom: 80),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  kSizedBoxHeight_16,
                  const HeaderImage__widget(),
                  kSizedBoxHeight_24,
                  const LabelSmall__text(text: 'Description'),
                  kSizedBoxHeight_16,
                  RichText(
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    text: const TextSpan(
                      text:
                          'The 3 level house that has a modern design, has a large pool and a garage that fits up to four cars... ',
                      style: kBodySmallTextstyle,
                      children: [
                        TextSpan(
                          text: 'Show More',
                          style: TextStyle(
                            color: kColorText1,
                          ),
                        ),
                      ],
                    ),
                  ),
                  kSizedBoxHeight_24,
                  const UserProfile__widget(),
                  kSizedBoxHeight_24,
                  const LabelSmall__text(text: 'Gallery'),
                  kSizedBoxHeight_16,
                  const ImageGallery__widget(),
                  kSizedBoxHeight_32,
                  const Map__widget(),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              width: ScreenConfig.screenWidth,
              decoration: BoxDecoration(
                color: kColorWhite,
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  stops: const [0.6, 1.0],
                  colors: [
                    kColorWhite,
                    kColorWhite.withOpacity(0.0),
                  ],
                ),
              ),
              child: const Padding(
                padding:
                    EdgeInsets.symmetric(vertical: 24, horizontal: 16),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        BodyMedium__text(text: 'Price', color: kColorText2),
                        kSizedBoxHeight_8,
                        LabelMedium__text(text: 'Rp. 2.500.000.000 / Year'),
                      ],
                    ),
                    Spacer(),
                    // Container(
                    //   decoration: BoxDecoration(boxShadow: [
                    //     BoxShadow(
                    //       color: kColorAccent.withOpacity(0.2),
                    //       offset: Offset(0, 15),
                    //       blurRadius: 15,
                    //     ),
                    //   ]),
                    //   child: Accent__Button__Medium(
                    //     text: 'Rent Now',
                    //     leftIconVisibility: false,
                    //     rightIconVisibility: false,
                    //     onTap: () {},
                    //   ),
                    // )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
      floatingActionButton: const FloatingActionButtonWithBottomNav(), // Use the custom widget as the floatingActionButton
    );
  }
}
