import 'package:flutter/material.dart';
import 'package:renting_app/dashboard/gen/assets.gen.dart';
import 'package:renting_app/dashboard/presentation/components/text.dart';
import 'package:renting_app/dashboard/presentation/pages/details_page/widgets/header_image.dart';
import 'package:renting_app/dashboard/presentation/themes/colors.dart';
import 'package:renting_app/dashboard/presentation/themes/config.dart';

class UserProfile__widget extends StatelessWidget {
  const UserProfile__widget({super.key});

  static const double _avatarSize = 40.0;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          height: _avatarSize,
          width: _avatarSize,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: kColorText3,
            image:
                DecorationImage(image: AssetImage(Assets.images.avatar.path)),
          ),
        ),
        kSizedBoxWidth_16,
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            LabelMedium__text(text: 'Garry Allen'),
            SizedBox(height: 4),
            BodySmall__text(text: 'Landrold'),
          ],
        ),
        const Spacer(),
        SquareIconButton__widget(
          icon: Assets.icons.phone.svg,
          bgColor: kColorPrimary.withOpacity(0.5),
        ),
        kSizedBoxWidth_16,
        SquareIconButton__widget(
          icon: Assets.icons.chat.svg,
          bgColor: kColorPrimary.withOpacity(0.5),
        ),
      ],
    );
  }
}
