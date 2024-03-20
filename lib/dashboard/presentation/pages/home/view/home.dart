// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:renting_app/dashboard/presentation/pages/home/widgets/appbar.dart';
import 'package:renting_app/dashboard/presentation/pages/home/widgets/button_group.dart';
import 'package:renting_app/dashboard/presentation/pages/home/widgets/card_Horizontal_List.dart';
import 'package:renting_app/dashboard/presentation/pages/home/widgets/card_vertical_list.dart';
import 'package:renting_app/dashboard/presentation/pages/home/widgets/search_and_filter.dart';
import 'package:renting_app/dashboard/presentation/pages/home/widgets/bottom_nav.dart';
import 'package:renting_app/dashboard/presentation/themes/colors.dart';
import 'package:renting_app/dashboard/presentation/themes/config.dart';

import '../widgets/title_bar.dart';
import 'package:renting_app/screens/feed_screen.dart'; // Import your FeedScreen

class ScreenHome extends StatelessWidget {
  const ScreenHome({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenConfig().init(context);

    return Scaffold(
      backgroundColor: const Color(0xffF7EBE1),
      appBar: appbar__widget(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: const [
              SearchAndFilter(),
              ButtonGroup__widget(),
              kSizedBoxHeight_8,
              TitleBar__widget(
                title: 'Near from you',
                visibility: true,
              ),
              CardHorizontalList__widget(),
              kSizedBoxHeight_8,
              TitleBar__widget(
                title: 'Best for you',
                visibility: true,
              ),
              CaerdVerticalList__widget(),
              kSizedBoxHeight_16,
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButtonWithBottomNav(),
    );
  }
}
