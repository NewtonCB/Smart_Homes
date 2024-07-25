import 'package:flutter/material.dart';

import '../../../../gen/assets.gen.dart';
import 'list_card.dart';

class CaerdVerticalList__widget extends StatelessWidget {
  const CaerdVerticalList__widget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListCardItem__widget(
          ontap: () {},
          image: Assets.images.house4.path,
          title: 'Magomeni Mapipa',
          subText: 'Tzs. 150,000/month',
          bedCount: 6,
          bathCount: 4,
        ),
        ListCardItem__widget(
          ontap: () {},
          image: Assets.images.house3.path,
          title: 'Upanga Zanaki',
          subText: 'Tzs. 80,000 /month',
          bedCount: 5,
          bathCount: 2,
        ),
        ListCardItem__widget(
          ontap: () {},
          image: Assets.images.house6.path,
          title: 'Mnazi Mmoja Appartment',
          subText: 'Tzs. 200,000 / month',
          bedCount: 2,
          bathCount: 2,
        ),
        ListCardItem__widget(
          ontap: () {},
          image: Assets.images.house5.path,
          title: 'Olympio House Appartment',
          subText: 'Tzs. 250,000',
          bedCount: 5,
          bathCount: 2,
        ),
      ],
    );
  }
}
