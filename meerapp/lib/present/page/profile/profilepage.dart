import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meerapp/config/colorconfig.dart';
import 'package:meerapp/constant/current_user.dart';
import 'package:meerapp/constant/post.dart';
import '../../../config/fontconfig.dart';
import '../../component/post.dart';
import '../home_page/widget/introduce_campaignwidget.dart';
import '../home_page/widget/join_campaign_user.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with TickerProviderStateMixin {
  late TabController _tabController;
  int currentTab = 0;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    double c_width = MediaQuery.of(context).size.width;
    List name = currentUser['fullname'].toString().split(' ');
    return SingleChildScrollView(
        child: Column(children: [
      Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                height: 250.h,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      colorFilter: ColorFilter.mode(
                          Colors.black.withOpacity(0.3), BlendMode.darken),
                      image: AssetImage("asset/avt1.jpg"),
                      fit: BoxFit.cover),
                ),
              ),
              Positioned(
                bottom: -60.h,
                left: 20.w,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: 90.h,
                      height: 90.h,
                      padding: const EdgeInsets.all(3),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        gradient:
                            LinearGradient(colors: meerColorGradientActive),
                      ),
                      child: Container(
                        width: 86.h,
                        height: 86.h,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 3),
                          image: DecorationImage(
                              alignment: Alignment(0, -0.8.h),
                              image: AssetImage("asset/avt1.jpg"),
                              fit: BoxFit.cover),
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        SizedBox(
                          height: 40.h,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 17.w),
                          child: SizedBox(
                            width: c_width - 130.w,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                joinedOverview('Đã tạo', 15),
                                joinedOverview('Đã tham gia', 15),
                                joinedOverview('Bỏ tham gia', 15),
                                SizedBox(
                                  width: 20.w,
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
              padding: EdgeInsets.only(left: 20.w, right: 15.w, top: 75.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name[name.length - 2] + ' ' + name[name.length - 1],
                    style: kText15BoldBlack,
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Text(
                    currentUser['description'].toString(),
                    style: kText13RegularBlack,
                  ),
                ],
              )),
          Column(
              // TODO: Open comment here
              // children: List.generate(
              //     posts.length,
              //     (index) => Post(
              //           avatarUrl: posts[index]["avatarUrl"],
              //           name: posts[index]["name"],
              //           address: posts[index]["address"],
              //           postImageUrl: posts[index]["postImageUrl"],
              //           title: posts[index]["title"],
              //           time: posts[index]["time"],
              //           content: posts[index]["content"],
              //           addressUser: posts[index]["addressUser"],
              //         ))),
              // ? Test data
              children: [Text('test')],)
        ],
      )
    ],
            ),
    );
  }

  Widget joinedOverview(String title, int number) {
    return Column(
      children: [
        Text(
          number.toString(),
          style: kText15BoldBlack,
        ),
        SizedBox(
          height: 5.h,
        ),
        Text(
          title,
          style: kText11RegularHintText,
        ),
      ],
    );
  }
}
