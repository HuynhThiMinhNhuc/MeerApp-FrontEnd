import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meerapp/config/colorconfig.dart';
import 'package:meerapp/config/fontconfig.dart';
import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:meerapp/present/page/home_page/home_page.dart';
import 'package:meerapp/present/page/map/map_page.dart';
import 'package:meerapp/present/page/new_campaign_page/create_new_campaign_page.dart';
import 'package:meerapp/present/page/new_emergency_page/create_new_emergencypage.dart';
import 'package:meerapp/present/page/profile/profilepage.dart';
import 'package:meerapp/present/page/urgent_page/urgent_page.dart';

class RootApp extends StatefulWidget {
  const RootApp({Key? key}) : super(key: key);

  @override
  State<RootApp> createState() => _RootAppState();
}

class _RootAppState extends State<RootApp> {
  int currentPage = 0;
  bool controlVisibleFloatingBtn = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: meerColorWhite,
      floatingActionButton: Visibility(
        visible: controlVisibleFloatingBtn,
        child: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => currentPage == 1
                        ? const CreateNewEmergencyPage(isCreate: true,)
                        : CreateNewCampaignPage(isCreate: true,)),

              );
            },
            child: const Icon(FontAwesomeIcons.pen)),
      ),
      appBar: getAppBar(),
      body: getBody(),
      bottomNavigationBar: getBottomTabBar(),
    );
  }

  Widget getBody() {
    switch (currentPage) {
      case 0:
        return HomePage();
      case 1:
        return UrgentPage();
      case 2:
        return MapPage();
      default:
        return ProfilePage();
    }
  }

  AppBar getAppBar() {
    switch (currentPage) {
      case 0:
        return homeAppBar();
      case 1:
        return urgentAppbar();
      case 2:
        return mapAppbar();
      default:
        return profileAppbar();
    }
  }

  AppBar homeAppBar() {
    return AppBar(
      backgroundColor: meerColorBackground,
      //centerTitle: true,
      elevation: 0,
      title: Padding(
        padding: EdgeInsets.symmetric(vertical: 15.h),
        child: Text(
          "Meers",
          style: kText24BoldMain,
        ),
      ),
    );
  }

  AppBar urgentAppbar() {
    return AppBar(
      backgroundColor: meerColorBackground,
      //centerTitle: true,
      elevation: 0,
      title: Padding(
        padding: EdgeInsets.symmetric(vertical: 15.h),
        child: Text(
          "Meers",
          style: kText24BoldMain,
        ),
      ),
    );
  }

  AppBar mapAppbar() {
    return AppBar(
      toolbarHeight: 0,
      backgroundColor: meerColorBackground,
    );
  }

  AppBar profileAppbar() {
    return AppBar(
      backgroundColor: meerColorBackground,
      toolbarHeight: 0.h,
    );
  }

  FancyBottomNavigation getBottomTabBar() {
    return FancyBottomNavigation(
      tabs: [
        TabData(iconData: FontAwesomeIcons.house, title: "Bài viết"),
        TabData(iconData: FontAwesomeIcons.hotjar, title: "Khẩn cấp"),
        TabData(iconData: FontAwesomeIcons.locationDot, title: "Bản đồ"),
        TabData(iconData: FontAwesomeIcons.userLarge, title: "Hồ sơ")
      ],
      onTabChangedListener: (int position) {
        setState(() {
          currentPage = position;
          controlVisibleFloatingBtn = position > 1 ? false : true;
        });
      },
    );
  }
}
