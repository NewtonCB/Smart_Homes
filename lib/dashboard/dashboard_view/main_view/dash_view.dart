import 'package:flutter/material.dart';
import 'package:Nestify/dashboard/dashboard_view/dashbord_components/app_bar/appbar_view.dart';
import 'package:Nestify/dashboard/dashboard_view/dashbord_components/buttom_nav/bottom_nav_view.dart';
import 'package:Nestify/dashboard/dashboard_view/dashbord_components/buttons_group/button_grp_view.dart';
import 'package:Nestify/dashboard/dashboard_view/dashbord_components/horizontal_scroll_cards/horizontal_crds_view.dart';
import 'package:Nestify/dashboard/dashboard_view/dashbord_components/vertical_scroll_cards/vertical_crds_view.dart';
import 'package:Nestify/dashboard/dashboard_view/dashbord_components/search_bar/search_bar_view.dart';
import 'package:Nestify/dashboard/dashboard_view/dashbord_components/swipe_image/swipe_img_view.dart';
import 'package:Nestify/dashboard/dashboard_view/dashbord_components/Titles/near_from_you.dart';
import 'package:Nestify/dashboard/dashboard_view/dashbord_components/Titles/recomended.dart';
import 'package:Nestify/dashboard/dashboard_view/dashbord_components/search_bar/search_bar_controller.dart';
import 'package:get/get.dart';
class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final TextEditingController searchController =  TextEditingController();
  final CustomSearchController searchBarController = Get.put(CustomSearchController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF7EBE1),
      appBar: CustomAppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Column(
              children: [
                SearchBarWithFilter(controller: searchController),
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
      ),
      bottomNavigationBar: BottomNavView(),
    );
  }
}
