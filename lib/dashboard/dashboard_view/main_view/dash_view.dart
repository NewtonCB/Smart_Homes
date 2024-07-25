import 'package:flutter/material.dart';
import 'package:renting_app/dashboard/dashboard_view/dashbord_components/app_bar/appbar_view.dart';
import 'package:renting_app/dashboard/dashboard_view/dashbord_components/buttom_nav/bottom_nav_view.dart';
import 'package:renting_app/dashboard/dashboard_view/dashbord_components/buttons_group/button_grp_view.dart';
import 'package:renting_app/dashboard/dashboard_view/dashbord_components/horizontal_scroll_cards/horizontal_crds_view.dart';
import 'package:renting_app/dashboard/dashboard_view/dashbord_components/vertical_scroll_cards/vertical_crds_view.dart';
import 'package:renting_app/dashboard/dashboard_view/dashbord_components/search_bar/search_bar_view.dart';
import 'package:renting_app/dashboard/dashboard_view/dashbord_components/swipe_image/swipe_img_view.dart';
import 'package:renting_app/dashboard/dashboard_view/dashbord_components/Titles/near_from_you.dart';
import 'package:renting_app/dashboard/dashboard_view/dashbord_components/Titles/recomended.dart';
class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF7EBE1),
      appBar: CustomAppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SearchBarWithFilter(),
              const ButtonRow(),
              SwipeImageContainer(),
              const NearFromYou(), // Add the NearFromYou component
              HorizontalScrollCards(),
              const Recommended(), // Add the Recommended component
              VerticalScrollCards(),
            ],
          ),
        ),
      ),
      floatingActionButton: const FloatingActionButtonWithBottomNav(),
    );
  }
}