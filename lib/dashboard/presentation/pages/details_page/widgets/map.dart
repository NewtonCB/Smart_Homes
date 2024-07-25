import 'package:flutter/material.dart';
import 'package:renting_app/dashboard/gen/assets.gen.dart';
import 'package:renting_app/dashboard/presentation/themes/colors.dart';
import 'package:url_launcher/url_launcher.dart';

class Map__widget extends StatelessWidget {
  const Map__widget({super.key});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async{
       await launchUrl(Uri.parse('https://www.google.com/maps/search/dit+/@-6.8149439,39.2790284,16z/data=!3m1!4b1?entry=ttu'));
      },
      child: AspectRatio(
        aspectRatio: 3 / 2,
        child: Container(
          decoration: BoxDecoration(
            color: kColorText2,
            borderRadius: BorderRadius.circular(16),
            image: DecorationImage(
              image: AssetImage(Assets.images.map.path),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
