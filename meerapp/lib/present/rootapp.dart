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
import 'package:flutter_svg/flutter_svg.dart';
import 'package:meerapp/singleton/user.dart';

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

  // final bodies = [
  //   HomePage(),
  //   UrgentPage(),
  //   MapPage(),
  //   ProfilePage()
  // ];

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
                        ? CreateNewEmergencyPage()
                        : CreateNewCampaignPage()),
              ).then((value) {
                if (value == 'ok') {
                  setState(() {});
                }
              });
            },
            child: const Icon(FontAwesomeIcons.pen)),
      ),
      appBar: getAppBar(),
      body: getBody(),
      bottomNavigationBar: getBottomTabBar(),
    );
  }

  Widget getBody() {
    // return bodies[currentPage];
    switch (currentPage) {
      case 0:
        return HomePage();
      case 1:
        return UrgentPage();
      case 2:
        return MapPage();
      default:
        return ProfilePage(
          userId: UserSingleton.instance.auth!.userId!,
        );
    }
  }

  AppBar getAppBar() {
    switch (currentPage) {
      case 0:
        return homeAppBar();
      case 1:
        return homeAppBar();
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
        actions: [
          Container(
              margin: EdgeInsets.only(right: 10.w),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Stack(
                      alignment: AlignmentDirectional.center,
                      children: [
                        Container(
                          width: 35.h,
                          height: 35.h,
                          decoration: BoxDecoration(
                              color: meerColorWhite,
                              borderRadius: BorderRadius.circular(10.h),
                              boxShadow: [
                                BoxShadow(
                                  color: meerColorGreyHintText.withOpacity(0.2),
                                  offset: Offset(0, 2),
                                  blurRadius: 20.0,
                                )
                              ]),
                          child: Center(
                            child: Container(
                                height: 20.h,
                                width: 17.w,
                                child:
                                    SvgPicture.asset("asset/notification.svg")),
                          ),
                        ),
                        Container(
                          height: 38.h,
                          width: 38.h,
                          alignment: AlignmentDirectional.topEnd,
                          child: Container(
                            width: 10.h,
                            height: 10.h,
                            decoration: BoxDecoration(
                                color: Colors.red, shape: BoxShape.circle),
                          ),
                        ),
                      ],
                    ),
                  ]))
        ]);
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
