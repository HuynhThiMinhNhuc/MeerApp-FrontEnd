import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meerapp/config/colorconfig.dart';
import 'package:meerapp/config/fontconfig.dart';
import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:meerapp/present/component/post.dart';
import 'package:meerapp/present/page/home_page/homepage.dart';
import 'package:meerapp/present/page/map/map_page.dart';

class RootApp extends StatefulWidget {
  const RootApp({Key? key}) : super(key: key);

  @override
  State<RootApp> createState() => _RootAppState();
}

class _RootAppState extends State<RootApp> {
  int currentPage = 0;

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
        return Text("urgent page");
      case 2:
        return MapPage();
      default:
        return Text("profile page");
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
          "MeerChats",
          style: kText24BoldMain,
        ),
      ),
    );
  }

  AppBar urgentAppbar() {
    return AppBar(
      backgroundColor: meerColorBackground,
      title: Text(
        "Tin khẩn cấp",
        style: kText20MediumBlack,
      ),
      elevation: 0,
      centerTitle: true,
    );
  }

  AppBar mapAppbar() {
    return AppBar(
      backgroundColor: meerColorBackground,
      title: Text(
        "Bản đồ",
        style: kText20MediumBlack,
      ),
      elevation: 0,
      centerTitle: true,
    );
  }

  AppBar profileAppbar() {
    return AppBar(
      backgroundColor: meerColorBackground,
      title: Text(
        "Tài khoản",
        style: kText20MediumBlack,
      ),
      elevation: 0,
      centerTitle: true,
    );
  }

  FancyBottomNavigation getBottomTabBar() {
    return FancyBottomNavigation(
      tabs: [
        TabData(iconData: FontAwesomeIcons.house, title: "Bài viết"),
        TabData(iconData: FontAwesomeIcons.hotjar, title: "Khẩn cấp"),
        TabData(iconData: FontAwesomeIcons.locationDot, title: "Bản đồ"),
        TabData(iconData: FontAwesomeIcons.user, title: "Hồ sơ")
      ],
      onTabChangedListener: (int position) {
        setState(() {
          currentPage = position;
        });
      },
    );
  }
}
