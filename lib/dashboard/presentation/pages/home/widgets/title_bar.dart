import 'package:flutter/material.dart';
import 'package:renting_app/screens/feed_screen.dart'; // Import your FeedScreen

import '../../../components/text.dart';
import '../../../themes/colors.dart';

class TitleBar__widget extends StatelessWidget {
  const TitleBar__widget({
    super.key,
    required this.title,
    required this.visibility,
  });

  final String title;
  final bool visibility;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const FeedScreen()), // Navigate to FeedScreen
          );
        },
        child: Row(
          children: <Widget>[
            LabelSmall__text(text: title),
            const Spacer(),
            Visibility(
              visible: visibility,
              child: const BodySmall__text(
                text: 'See more',
                color: kColorText1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
